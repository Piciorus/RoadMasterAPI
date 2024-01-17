use crate::model::{
    CountriesInfoResponse, CountriesResponse, Country, CountryInfo, GetQuestionRequest,
    MultipleChoiceQuestion, Tips, TipsResponse,
};
use crate::{
    helper::{hash_password, is_valid_email},
    model,
    model::{
        ApiResponse, ListResultResponse, LoggedInUserRequest, LoginRequest, RegisterUserRequest,
        RegisterUserResponse, ResetPasswordRequest, ResultResponse,
    },
    AppState,
};
use actix_web::{get, post, web, HttpResponse, Responder};
use bcrypt::verify;
use rand::seq::SliceRandom;
use sqlx::MySqlPool;

//Endpoint um Fragen aus der DB zu holen
#[post("/question")]
async fn question_handler(
    body: web::Json<GetQuestionRequest>,
    data: web::Data<AppState>,
) -> impl Responder {
    let question_result = sqlx::query!(
        "SELECT * FROM multiple_choice_questions WHERE category = ?",
        &body.category
    )
    .fetch_all(&data.db)
    .await
    .unwrap();

    let question = question_result.choose(&mut rand::thread_rng()).unwrap();

    let to_bool = |i: i8| -> bool { i != 0 };

    let response = ApiResponse::success(
        MultipleChoiceQuestion {
            id: question.id.clone(),
            category: question.category.clone(),
            text: question.text.clone(),
            answers: vec![
                (
                    question.answer1.clone(),
                    to_bool(question.is_correct_answer_1),
                ),
                (
                    question.answer2.clone(),
                    to_bool(question.is_correct_answer_2),
                ),
                (
                    question.answer3.clone(),
                    to_bool(question.is_correct_answer_3),
                ),
                (
                    question.answer4.clone(),
                    to_bool(question.is_correct_answer_4),
                ),
            ],
        },
        "Bv boss",
    );

    HttpResponse::Ok().json(response)
}

//Endpoint fur registrieren
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

//Endpoint fur einloggen
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

//Endpoint fur die Veranderung des Passwortes
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

//Endpoint um das Ergebnis eines Quizes in der DB zu speichern
#[post("/result")]
async fn result_handler(
    body: web::Json<model::Result>,
    data: web::Data<AppState>,
) -> impl Responder {
    let id = uuid::Uuid::new_v4().to_string();

    let query_result =
        sqlx::query(r#"INSERT INTO results (id, user_id, category, nr_correct, nr_wrong, percentage_correct, result_test)
                    VALUES (?, ?, ?, ?, ?, ?, ?)"#)
            .bind(id.clone())
            .bind(body.user_id.clone())
            .bind(body.category.clone())
            .bind(body.nr_correct.clone())
            .bind(body.nr_wrong.clone())
            .bind(body.percentage_correct.clone())
            .bind(body.result_test.clone())
            .execute(&data.db)
            .await;

    match query_result {
        Ok(_) => {
            let response = ApiResponse::success((), "Result saved successfully");
            HttpResponse::Ok().json(response)
        }
        Err(err) => {
            let error_message = format!("Failed to save result: {:?}", err);
            let response: ApiResponse<()> = ApiResponse::error(&error_message);

            HttpResponse::InternalServerError().json(response)
        }
    }
}

//Endpoint um alle fruhere Ergebnisse eines Users aus der DB zu holen
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

//Endpoint um alle gespeicherte Landeroptionen aus der DB zu holen
#[get("/countries")]
async fn country_handler(data: web::Data<AppState>) -> impl Responder {
    let countries_result = sqlx::query_as!(Country, "SELECT * FROM countries",)
        .fetch_all(&data.db)
        .await;

    match countries_result {
        Ok(countries) => {
            let mut countries_list: Vec<Country> = Vec::new();

            for country in countries.iter() {
                let id = country.id.clone();
                let name = country.name.clone();

                let country = Country { id, name };

                countries_list.push(country)
            }

            let response: ApiResponse<CountriesResponse> = ApiResponse::success(
                CountriesResponse {
                    countries: countries_list,
                },
                "Countries retrieved successfully",
            );

            HttpResponse::Ok().json(response)
        }
        Err(err) => {
            let error_message = format!("Failed to retrieve countries: {:?}", err);
            let response: ApiResponse<()> = ApiResponse::error(&error_message);
            HttpResponse::InternalServerError().json(response)
        }
    }
}

//Endpoint um alle gespeicherte Informationen zum Fahren in einem gegebenen Land aus der DB zu holen
#[post("/country-info")]
async fn country_info_handler(
    body: web::Json<Country>,
    data: web::Data<AppState>,
) -> impl Responder {
    let country_info_result = sqlx::query_as!(
        CountryInfo,
        "SELECT text FROM countries_info WHERE country_id = ?",
        &body.id
    )
    .fetch_all(&data.db)
    .await;

    match country_info_result {
        Ok(country_infos) => {
            let mut country_info_list: Vec<String> = Vec::new();

            for country_info in country_infos.iter() {
                let text = country_info.text.clone();

                country_info_list.push(text);
            }

            let response: ApiResponse<CountriesInfoResponse> = ApiResponse::success(
                CountriesInfoResponse {
                    country_info: country_info_list,
                },
                "Country Info retrieved successfully",
            );

            HttpResponse::Ok().json(response)
        }
        Err(err) => {
            let error_message = format!("Failed to retrieve country info: {:?}", err);
            let response: ApiResponse<()> = ApiResponse::error(&error_message);
            HttpResponse::InternalServerError().json(response)
        }
    }
}

//Endpoint um alle gespeicherte Tips fur die praktische Prufung aus der DB zu holen
#[get("/tips")]
async fn tips_handler(data: web::Data<AppState>) -> impl Responder {
    let tips_result = sqlx::query_as!(Tips, "SELECT text FROM tips",)
        .fetch_all(&data.db)
        .await;

    match tips_result {
        Ok(tips) => {
            let mut tips_list: Vec<String> = Vec::new();

            for tip in tips.iter() {
                let text = tip.text.clone();

                tips_list.push(text)
            }

            let response: ApiResponse<TipsResponse> = ApiResponse::success(
                TipsResponse { tips: tips_list },
                "Tips retrieved successfully",
            );

            HttpResponse::Ok().json(response)
        }
        Err(err) => {
            let error_message = format!("Failed to retrieve tips: {:?}", err);
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

//Endpoints Zugriffskonfigurationen
pub fn config(conf: &mut web::ServiceConfig) {
    let scope = web::scope("/api")
        .service(register_handler)
        .service(login_handler)
        .service(reset_password_handler)
        .service(history_handler)
        .service(question_handler)
        .service(country_handler)
        .service(country_info_handler)
        .service(tips_handler)
        .service(result_handler);

    conf.service(scope);
}
