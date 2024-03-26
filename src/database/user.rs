use sqlx::{mysql::MySqlQueryResult, MySqlPool};

use crate::model::user::LoginRequest;

pub(crate) async fn get_actual_password_from_database(db: &MySqlPool, email: String) -> String {
    sqlx::query_scalar!("SELECT password FROM users WHERE email = ?", email)
        .fetch_one(db)
        .await
        .unwrap_or_default()
}

pub(crate) async fn get_actual_username_from_database(db: &MySqlPool, email: String) -> String {
    sqlx::query_scalar!("SELECT username FROM users WHERE email = ?", email)
        .fetch_one(db)
        .await
        .unwrap_or_default()
}

pub(crate) async fn get_id_from_database_by_password(db: &MySqlPool, email: String) -> String {
    sqlx::query_scalar!("SELECT id FROM users WHERE email = ?", email)
        .fetch_one(db)
        .await
        .unwrap_or_default()
}

pub(crate) async fn try_login(db: &MySqlPool, email: &str) -> Result<LoginRequest, sqlx::Error> {
    let result = sqlx::query!("SELECT password FROM users WHERE email = ?", email)
        .fetch_one(db)
        .await;

    match result {
        Ok(pass) => Ok(LoginRequest {
            email: email.to_owned(),
            password: pass.password,
        }),
        Err(err) => Err(err),
    }
}

pub(crate) async fn insert_user(
    db: &MySqlPool,
    user_id: &str,
    username: &str,
    email: &str,
    hashed_pass: &str,
) -> std::result::Result<MySqlQueryResult, sqlx::Error> {
    sqlx::query(r#"INSERT INTO users (id, username, email, password) VALUES (?, ?, ?, ?)"#)
        .bind(user_id)
        .bind(username)
        .bind(email)
        .bind(hashed_pass)
        .execute(db)
        .await
}

pub(crate) async fn update_result(
    db: &MySqlPool,
    new_pass: String,
    id: String,
) -> Result<MySqlQueryResult, sqlx::Error> {
    sqlx::query("UPDATE users SET password = ? WHERE id = ?")
        .bind(new_pass)
        .bind(id)
        .execute(db)
        .await
}

pub(crate) async fn email_exists(db: &MySqlPool, email: &str) -> bool {
    sqlx::query!("SELECT COUNT(*) as count FROM users WHERE email = ?", email)
        .fetch_one(db)
        .await
        .map(|result| result.count > 0)
        .unwrap_or(false)
}
