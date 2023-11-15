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
    IF NOT EXISTS questions (
        id VARCHAR(255) PRIMARY KEY NOT NULL,
        category VARCHAR(255) NOT NULL,
        text VARCHAR(255) NOT NULL,
        question_type VARCHAR(255) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

CREATE TABLE
    IF NOT EXISTS answers (
        id VARCHAR(255) PRIMARY KEY NOT NULL,
        question_id VARCHAR(255) NOT NULL,
        text VARCHAR(255) NOT NULL,
        answer_state INT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (question_id) REFERENCES questions(id)
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
