use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct MultipleChoiceQuestion {
    pub id: String,
    pub category: String,
    pub text: String,
    pub answers: Vec<(String, bool)>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct GetQuestionRequest {
    pub category: String,
}
