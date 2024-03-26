use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct Result {
    pub user_id: String,
    pub category: String,
    pub nr_correct: i32,
    pub nr_wrong: i32,
    pub percentage_correct: i32,
    pub result_test: String,
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
