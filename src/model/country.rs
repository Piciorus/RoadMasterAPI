use serde::{Deserialize, Serialize};

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
