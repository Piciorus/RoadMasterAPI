use crate::{
    model::{RegisterUserSchema},
    AppState,
};
use actix_web::{delete, get, patch, post, web, HttpResponse, Responder};
use serde_json::json;

#[post("/register")]
async fn register_handler(
    body: web::Json<RegisterUserSchema>,
    data: web::Data<AppState>,
) -> impl Responder {

    let user_id = uuid::Uuid::new_v4().to_string();

    let query_result = sqlx::query(r#"INSERT INTO users (id, username, email, password) VALUES (?, ?, ?, ?)"#)
        .bind(user_id.clone())
        .bind(body.username.to_owned())
        .bind(body.email.to_owned())
        .bind(body.password.to_owned())
        .execute(&data.db)
        .await
        .map_err(|err: sqlx::Error| err.to_string());

    if let Err(err) = query_result {
        return HttpResponse::InternalServerError().json(json!({
            "status": "error",
            "message": format!("{:?}", err),
        }));
    }

    HttpResponse::Ok().json(json!({
        "status": "success",
        "message": "User registered successfully",
    }))
}

pub fn config(conf: &mut web::ServiceConfig) {
    let scope = web::scope("/api")
        .service(register_handler);

    conf.service(scope);
}
