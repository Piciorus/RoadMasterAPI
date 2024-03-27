use sqlx::{mysql::MySqlQueryResult, MySqlPool};

use crate::model::result::ResultResponse;

pub(crate) async fn fetch_results(
    db: &MySqlPool,
    user_id: &str,
) -> std::result::Result<Vec<ResultResponse>, sqlx::Error> {
    let history_result = sqlx::query_as!(
        ResultResponse,
        "SELECT category, nr_correct, result_test, date_test FROM results WHERE user_id = ?",
        user_id
    )
    .fetch_all(db)
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

            Ok(history_list)
        }
        Err(err) => Err(err),
    }
}

pub(crate) async fn insert_result(
    db: &MySqlPool,
    id: &str,
    user_id: &str,
    category: &str,
    nr_correct: i32,
    nr_wrong: i32,
    percentage_correct: i32,
    result_test: &str,
) -> Result<MySqlQueryResult, sqlx::Error> {
    sqlx::query(r#"INSERT INTO results (id, user_id, category, nr_correct, nr_wrong, percentage_correct, result_test)
                    VALUES (?, ?, ?, ?, ?, ?, ?)"#)
            .bind(id)
            .bind(user_id)
            .bind(category)
            .bind(nr_correct)
            .bind(nr_wrong)
            .bind(percentage_correct)
            .bind(result_test)
            .execute(db)
            .await
}
