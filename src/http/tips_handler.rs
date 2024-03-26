use actix_web::{
    get,
    web::{self},
    HttpResponse, Responder,
};

use crate::{
    model::{
        api_response::ApiResponse,
        tips::{Tips, TipsResponse},
    },
    AppState,
};

#[get("/tips")]
async fn get_tips(data: web::Data<AppState>) -> impl Responder {
    let tips_result = sqlx::query_as!(Tips, "SELECT text FROM tips",)
        .fetch_all(&data.db)
        .await;

    match tips_result {
        Ok(tips) => {
            let mut tips_list: Vec<String> = Vec::new();

            for tip in tips.iter() {
                let text = tip.text.clone();

                tips_list.push(text)
            }

            let response: ApiResponse<TipsResponse> = ApiResponse::success(
                TipsResponse { tips: tips_list },
                "Tips retrieved successfully",
            );

            HttpResponse::Ok().json(response)
        }
        Err(err) => {
            let error_message = format!("Failed to retrieve tips: {:?}", err);
            let response: ApiResponse<()> = ApiResponse::error(&error_message);
            HttpResponse::InternalServerError().json(response)
        }
    }
}

pub fn config(conf: &mut web::ServiceConfig) {
    let scope = web::scope("/api").service(get_tips);

    conf.service(scope);
}
