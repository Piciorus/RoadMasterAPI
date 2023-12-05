use crate::model::Question;
use crate::{
    helper::{hash_password, is_valid_email},
    model::{
        ApiResponse, ListResultResponse, LoggedInUserRequest, LoginRequest, RegisterUserRequest,
        RegisterUserResponse, ResetPasswordRequest, ResultResponse,
    },
    AppState,
};
use actix_web::{get, post, web, HttpResponse, Responder};
use bcrypt::verify;
use sqlx::MySqlPool;

#[get("/question")]
async fn question_handler() -> impl Responder {
    println!("trimte intrebare");
    let response = ApiResponse::success(
        Question {
            id: 1,
            category: "jmekerie".to_string(),
            text: "te bulesc?".to_string(),
            correct_answer: "da".to_string(),
            wrong_answers: vec![
                "nu".to_string(),
                "poate".to_string(),
                "ma mai gandesc".to_string(),
            ],
        },
        "Bv boss",
    );

    HttpResponse::Ok().json(response)
}

#[post("/register")]
async fn register_handler(
    body: web::Json<RegisterUserRequest>,
    data: web::Data<AppState>,
) -> impl Responder {
    if !is_valid_email(&body.email) {
        let response: ApiResponse<()> = ApiResponse::error("Invalid email format");
        return HttpResponse::BadRequest().json(response);
    }

    let email_exists = sqlx::query!(
        "SELECT COUNT(*) as count FROM users WHERE email = ?",
        &body.email
    )
    .fetch_one(&data.db)
    .await
    .map(|result| result.count > 0)
    .unwrap_or(false);

    if email_exists {
        let response: ApiResponse<()> = ApiResponse::error("Email address is already registered");
        return HttpResponse::Conflict().json(response);
    }

    let user_id = uuid::Uuid::new_v4().to_string();
    let hashed_password = hash_password(&body.password.to_owned());

    let query_result =
        sqlx::query(r#"INSERT INTO users (id, username, email, password) VALUES (?, ?, ?, ?)"#)
            .bind(user_id.clone())
            .bind(body.username.to_owned())
            .bind(body.email.to_owned())
            .bind(hashed_password)
            .execute(&data.db)
            .await;

    match query_result {
        Ok(_) => {
            let response = ApiResponse::success(
                RegisterUserResponse {
                    id: user_id,
                    username: body.username.clone(),
                    email: body.email.clone(),
                    password: body.password.clone(),
                },
                "User registered successfully",
            );

            HttpResponse::Ok().json(response)
        }
        Err(err) => {
            let error_message = format!("Failed to register user: {:?}", err);
            let response: ApiResponse<()> = ApiResponse::error(&error_message);

            HttpResponse::InternalServerError().json(response)
        }
    }
}

#[post("/login")]
async fn login_handler(body: web::Json<LoginRequest>, data: web::Data<AppState>) -> impl Responder {
    let result = sqlx::query!(
        "SELECT id, password FROM users WHERE email = ?",
        &body.email
    )
    .fetch_optional(&data.db)
    .await;

    match result {
        Ok(Some(user)) => {
            if verify(&body.password, &user.password).unwrap_or(false) {
                let response = ApiResponse::success(
                    RegisterUserResponse {
                        id: get_id_from_database_by_password(&data.db, body.email.clone()).await,
                        username: get_actual_username_from_database(&data.db, body.email.clone())
                            .await,
                        email: body.email.clone(),
                        password: body.password.clone(),
                    },
                    "Login successful",
                );

                HttpResponse::Ok().json(response)
            } else {
                let response: ApiResponse<()> =
                    ApiResponse::error("Invalid email or password combination");
                HttpResponse::Unauthorized().json(response)
            }
        }
        Ok(None) => {
            let response: ApiResponse<()> =
                ApiResponse::error("Invalid email or password combination");
            HttpResponse::Unauthorized().json(response)
        }
        Err(err) => {
            let error_message = format!("Failed to authenticate user: {:?}", err);
            let response: ApiResponse<()> = ApiResponse::error(&error_message);
            HttpResponse::InternalServerError().json(response)
        }
    }
}

#[post("/reset-password")]
async fn reset_password_handler(
    body: web::Json<ResetPasswordRequest>,
    data: web::Data<AppState>,
) -> impl Responder {
    let actual_password = get_actual_password_from_database(&data.db, body.email.clone()).await;
    let actual_id = get_id_from_database_by_password(&data.db, body.email.clone()).await;

    if !verify(&body.old_password, &actual_password).unwrap_or(false) {
        let response: ApiResponse<()> = ApiResponse::error("Invalid old password");
        return HttpResponse::BadRequest().json(response);
    }

    if body.new_password != body.repeat_new_password {
        let response: ApiResponse<()> = ApiResponse::error("New passwords do not match");
        return HttpResponse::BadRequest().json(response);
    }

    let hashed_new_password = hash_password(&body.new_password);

    let update_result = sqlx::query("UPDATE users SET password = ? WHERE id = ?")
        .bind(hashed_new_password)
        .bind(actual_id)
        .execute(&data.db)
        .await;

    match update_result {
        Ok(_) => {
            let response: ApiResponse<()> = ApiResponse::success((), "Password reset successfully");
            HttpResponse::Ok().json(response)
        }
        Err(err) => {
            let error_message = format!("Failed to reset password: {:?}", err);
            let response: ApiResponse<()> = ApiResponse::error(&error_message);
            HttpResponse::InternalServerError().json(response)
        }
    }
}

#[post("/history")]
async fn history_handler(
    body: web::Json<LoggedInUserRequest>,
    data: web::Data<AppState>,
) -> impl Responder {
    let history_result = sqlx::query_as!(
        ResultResponse,
        "SELECT category, nr_correct, result_test, date_test FROM results WHERE user_id = ?",
        &body.id
    )
    .fetch_all(&data.db)
    .await;

    match history_result {
        Ok(histories) => {
            let mut history_list: Vec<ResultResponse> = Vec::new();

            for history in histories.iter() {
                let category = history.category.clone();
                let nr_correct = history.nr_correct;
                let result_test = history.result_test.clone();
                let date_test = history.date_test.clone();

                let result = ResultResponse {
                    category,
                    nr_correct,
                    result_test,
                    date_test,
                };

                history_list.push(result)
            }

            let response: ApiResponse<ListResultResponse> = ApiResponse::success(
                ListResultResponse {
                    histories: history_list,
                },
                "History retrieved successfully",
            );

            HttpResponse::Ok().json(response)
        }
        Err(err) => {
            let error_message = format!("Failed to retrieve history: {:?}", err);
            let response: ApiResponse<()> = ApiResponse::error(&error_message);
            HttpResponse::InternalServerError().json(response)
        }
    }
}

async fn get_actual_password_from_database(db: &MySqlPool, email: String) -> String {
    sqlx::query_scalar!("SELECT password FROM users WHERE email = ?", email)
        .fetch_one(db)
        .await
        .unwrap_or_default()
}

async fn get_actual_username_from_database(db: &MySqlPool, email: String) -> String {
    sqlx::query_scalar!("SELECT username FROM users WHERE email = ?", email)
        .fetch_one(db)
        .await
        .unwrap_or_default()
}

async fn get_id_from_database_by_password(db: &MySqlPool, email: String) -> String {
    sqlx::query_scalar!("SELECT id FROM users WHERE email = ?", email)
        .fetch_one(db)
        .await
        .unwrap_or_default()
}

pub fn config(conf: &mut web::ServiceConfig) {
    let scope = web::scope("/api")
        .service(register_handler)
        .service(login_handler)
        .service(reset_password_handler)
        .service(history_handler)
        .service(question_handler);

    conf.service(scope);
}
