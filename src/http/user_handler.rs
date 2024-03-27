use actix_web::{post, web, HttpResponse, Responder};
use bcrypt::verify;

use crate::{
    database::user::{
        email_exists, get_actual_password_from_database, get_actual_username_from_database,
        get_id_from_database_by_password, insert_user, try_login, update_user,
    },
    helpers::helper::{hash_password, is_valid_email},
    model::{
        api_response::ApiResponse,
        user::{LoginRequest, RegisterUserRequest, RegisterUserResponse, ResetPasswordRequest},
    },
    AppState,
};

#[post("/register")]
async fn register_handler(
    body: web::Json<RegisterUserRequest>,
    data: web::Data<AppState>,
) -> impl Responder {
    if !is_valid_email(&body.email) {
        let response: ApiResponse<()> = ApiResponse::error("Invalid email format");
        return HttpResponse::BadRequest().json(response);
    }

    if email_exists(&data.db, &body.email).await {
        let response: ApiResponse<()> = ApiResponse::error("Email address is already registered");
        return HttpResponse::Conflict().json(response);
    }

    let user_id = uuid::Uuid::new_v4().to_string();
    let hashed_password = hash_password(&body.password.to_owned());

    match insert_user(
        &data.db,
        &user_id,
        &body.username,
        &body.email,
        &hashed_password,
    )
    .await
    {
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
    match try_login(&data.db, &body.email).await {
        Ok(user) => {
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

    match update_user(&data.db, hashed_new_password, actual_id).await {
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

pub fn config(conf: &mut web::ServiceConfig) {
    let scope = web::scope("/api")
        .service(register_handler)
        .service(login_handler)
        .service(reset_password_handler);

    conf.service(scope);
}
