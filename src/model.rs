use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct RegisterUserResponse {
    pub id: String,
    pub username: String,
    pub email: String,
    pub password: String,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct RegisterUserRequest {
    pub username: String,
    pub email: String,
    pub password: String,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct GetQuestionRequest {
    pub category: String,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct LoginRequest {
    pub email: String,
    pub password: String,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct ApiResponse<T> {
    pub status: String,
    pub message: String,
    pub data: Option<T>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct ResetPasswordRequest {
    pub email: String,
    pub old_password: String,
    pub new_password: String,
    pub repeat_new_password: String,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct LoggedInUserRequest {
    pub id: String,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct ResultResponse {
    pub category: String,
    pub nr_correct: i32,
    pub result_test: String,
    pub date_test: Option<DateTime<Utc>>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct ListResultResponse {
    pub histories: Vec<ResultResponse>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct SingleChoiceQuestion {
    pub id: String,
    pub category: String,
    pub text: String,
    pub correct_answer: String,
    pub wrong_answers: Vec<String>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct MultipleChoiceQuestion {
    pub id: String,
    pub category: String,
    pub text: String,
    pub answers: Vec<(String, bool)>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct Country {
    pub id: String,
    pub name: String,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct CountriesResponse {
    pub countries: Vec<Country>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct CountryInfo {
    pub text: String,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct CountriesInfoResponse {
    pub country_info: Vec<String>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct Tips {
    pub text: String,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct TipsResponse {
    pub tips: Vec<String>,
}

impl<T> ApiResponse<T> {
    pub fn success(data: T, text: &str) -> Self {
        ApiResponse {
            status: "success".to_string(),
            message: text.to_string(),
            data: Some(data),
        }
    }

    pub fn error(message: &str) -> Self {
        ApiResponse {
            status: "error".to_string(),
            message: message.to_string(),
            data: None,
        }
    }
}
