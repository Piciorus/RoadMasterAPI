-- Add up migration script here

-- Add up migration script here

CREATE TABLE
    IF NOT EXISTS users (
        id VARCHAR(255) PRIMARY KEY NOT NULL,
        username VARCHAR(255) NOT NULL,
        email VARCHAR(255) NOT NULL,
        password VARCHAR(255) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

CREATE TABLE
    IF NOT EXISTS single_choice_questions (
        id VARCHAR(255) PRIMARY KEY NOT NULL,
        category VARCHAR(255) NOT NULL,
        text VARCHAR(255) NOT NULL,
        correct_answer VARCHAR(255) NOT NULL,
        wrong_answer1 VARCHAR(255) NOT NULL,
        wrong_answer2 VARCHAR(255) NOT NULL,
        wrong_answer3 VARCHAR(255) NOT NULL
    );

CREATE TABLE
    IF NOT EXISTS multiple_choice_questions (
        id VARCHAR(255) PRIMARY KEY NOT NULL,
        category VARCHAR(255) NOT NULL,
        text VARCHAR(255) NOT NULL,
        answer1 VARCHAR(255) NOT NULL,
        answer2 VARCHAR(255) NOT NULL,
        answer3 VARCHAR(255) NOT NULL,
        answer4 VARCHAR(255) NOT NULL,
        is_correct_answer_1 BOOLEAN NOT NULL,
        is_correct_answer_2 BOOLEAN NOT NULL,
        is_correct_answer_3 BOOLEAN NOT NULL,
        is_correct_answer_4 BOOLEAN NOT NULL
    );

CREATE TABLE
    IF NOT EXISTS results (
        id VARCHAR(255) PRIMARY KEY NOT NULL,
        user_id VARCHAR(255) NOT NULL,
        category VARCHAR(255) NOT NULL,
        nr_correct INT NOT NULL,
        nr_wrong INT NOT NULL,
        percentage_correct INT NOT NULL,
        date_test TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        result_test VARCHAR(255) NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(id)
    );
