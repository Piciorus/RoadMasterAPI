use actix_web::{post, web, HttpResponse, Responder};

use crate::{
    model::{
        self,
        api_response::ApiResponse,
        result::{ListResultResponse, ResultResponse},
        user::LoggedInUserRequest,
    },
    AppState,
};

#[post("/history")]
async fn post_history(
    body: web::Json<LoggedInUserRequest>,
    data: web::Data<AppState>,
) -> impl Responder {
    let history_result = sqlx::query_as!(
        ResultResponse,
        "SELECT category, nr_correct, result_test, date_test FROM results WHERE user_id = ?",
        &body.id
    )
    .fetch_all(&data.db)
    .await;

    match history_result {
        Ok(histories) => {
            let mut history_list: Vec<ResultResponse> = Vec::new();

            for history in histories.iter() {
                let category = history.category.clone();
                let nr_correct = history.nr_correct;
                let result_test = history.result_test.clone();
                let date_test = history.date_test.clone();

                let result = ResultResponse {
                    category,
                    nr_correct,
                    result_test,
                    date_test,
                };

                history_list.push(result)
            }

            let response: ApiResponse<ListResultResponse> = ApiResponse::success(
                ListResultResponse {
                    histories: history_list,
                },
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

    let query_result =
        sqlx::query(r#"INSERT INTO results (id, user_id, category, nr_correct, nr_wrong, percentage_correct, result_test)
                    VALUES (?, ?, ?, ?, ?, ?, ?)"#)
            .bind(id.clone())
            .bind(body.user_id.clone())
            .bind(body.category.clone())
            .bind(body.nr_correct.clone())
            .bind(body.nr_wrong.clone())
            .bind(body.percentage_correct.clone())
            .bind(body.result_test.clone())
            .execute(&data.db)
            .await;

    match query_result {
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
