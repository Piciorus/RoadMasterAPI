use actix_web::{post, web, HttpResponse, Responder};

use crate::{
    database::results::{fetch_results, insert_result},
    model::{
        self, api_response::ApiResponse, result::ListResultResponse, user::LoggedInUserRequest,
    },
    AppState,
};

#[post("/history")]
async fn post_history(
    body: web::Json<LoggedInUserRequest>,
    data: web::Data<AppState>,
) -> impl Responder {
    match fetch_results(&data.db, &body.id).await {
        Ok(histories) => {
            let response: ApiResponse<ListResultResponse> = ApiResponse::success(
                ListResultResponse { histories },
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

//Endpoint um das Ergebnis eines Quizes in der DB zu speichern
#[post("/result")]
async fn post_result(
    body: web::Json<model::result::Result>,
    data: web::Data<AppState>,
) -> impl Responder {
    let id = uuid::Uuid::new_v4().to_string();

    match insert_result(
        &data.db,
        &id,
        &body.user_id,
        &body.category,
        body.nr_correct,
        body.nr_wrong,
        body.percentage_correct,
        &body.result_test,
    )
    .await
    {
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

pub fn config(conf: &mut web::ServiceConfig) {
    let scope = web::scope("/api")
        .service(post_history)
        .service(post_result);

    conf.service(scope);
}
