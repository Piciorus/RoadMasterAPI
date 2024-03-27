use actix_web::{get, post, web, HttpResponse, Responder};

use crate::{
    model::{
        api_response::ApiResponse,
        country::{CountriesInfoResponse, CountriesResponse, Country},
    },
    AppState,
};

#[get("/countries")]
async fn get_countries(data: web::Data<AppState>) -> impl Responder {
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

#[post("/country-info")]
async fn post_country_info(body: web::Json<Country>, data: web::Data<AppState>) -> impl Responder {
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

pub fn config(conf: &mut web::ServiceConfig) {
    let scope = web::scope("/api")
        .service(get_countries)
        .service(post_country_info);

    conf.service(scope);
}
