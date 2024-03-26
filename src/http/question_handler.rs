use actix_web::{post, web, HttpResponse, Responder};

use crate::{
    model::{
        api_response::ApiResponse,
        question::{GetQuestionRequest, MultipleChoiceQuestion},
    },
    AppState,
};

use rand::prelude::SliceRandom;

#[post("/question")]
async fn post_question(
    body: web::Json<GetQuestionRequest>,
    data: web::Data<AppState>,
) -> impl Responder {
    let question_result = sqlx::query!(
        "SELECT * FROM multiple_choice_questions WHERE category = ?",
        &body.category
    )
    .fetch_all(&data.db)
    .await
    .unwrap();

    let question = question_result.choose(&mut rand::thread_rng()).unwrap();

    let to_bool = |i: i8| -> bool { i != 0 };

    let response = ApiResponse::success(
        MultipleChoiceQuestion {
            id: question.id.clone(),
            category: question.category.clone(),
            text: question.text.clone(),
            answers: vec![
                (
                    question.answer1.clone(),
                    to_bool(question.is_correct_answer_1),
                ),
                (
                    question.answer2.clone(),
                    to_bool(question.is_correct_answer_2),
                ),
                (
                    question.answer3.clone(),
                    to_bool(question.is_correct_answer_3),
                ),
                (
                    question.answer4.clone(),
                    to_bool(question.is_correct_answer_4),
                ),
            ],
        },
        "Bv boss",
    );

    HttpResponse::Ok().json(response)
}

pub fn config(conf: &mut web::ServiceConfig) {
    let scope = web::scope("/api").service(post_question);

    conf.service(scope);
}
