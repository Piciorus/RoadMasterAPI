use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct Tips {
    pub text: String,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct TipsResponse {
    pub tips: Vec<String>,
}
