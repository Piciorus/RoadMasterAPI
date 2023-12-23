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

CREATE TABLE
    IF NOT EXISTS countries (
        id VARCHAR(255) PRIMARY KEY NOT NULL,
        name VARCHAR(255) NOT NULL
    );

CREATE TABLE
    IF NOT EXISTS countries_info (
        id VARCHAR(255) PRIMARY KEY NOT NULL,
        country_id VARCHAR(255) NOT NULL,
        text VARCHAR(255) NOT NULL,
        FOREIGN KEY (country_id) REFERENCES countries(id)
    );


INSERT INTO countries (id, name) VALUES ('1', 'Germany');
INSERT INTO countries (id, name) VALUES ('2', 'France');
INSERT INTO countries (id, name) VALUES ('3', 'Italy');
INSERT INTO countries (id, name) VALUES ('4', 'Spain');
INSERT INTO countries (id, name) VALUES ('5', 'United Kingdom');
INSERT INTO countries (id, name) VALUES ('6', 'Japan');
INSERT INTO countries (id, name) VALUES ('7', 'China');
INSERT INTO countries (id, name) VALUES ('8', 'United States');
INSERT INTO countries (id, name) VALUES ('9', 'Canada');


INSERT INTO countries_info (id, country_id, text) VALUES ('1', '1', 'In Germany, you drive on the right side of the road.');
INSERT INTO countries_info (id, country_id, text) VALUES ('2', '1', 'Speed limits on the Autobahn are recommended but not mandatory.');
INSERT INTO countries_info (id, country_id, text) VALUES ('3', '1', 'Driving under the influence of alcohol is strictly prohibited.');
INSERT INTO countries_info (id, country_id, text) VALUES ('4', '1', 'Seat belts are mandatory for all occupants.');
INSERT INTO countries_info (id, country_id, text) VALUES ('5', '1', 'Traffic signals and signs must be strictly obeyed.');

INSERT INTO countries_info (id, country_id, text) VALUES ('6', '2', 'In France, you drive on the right side of the road.');
INSERT INTO countries_info (id, country_id, text) VALUES ('7', '2', 'Speeding fines are substantial, especially in residential areas.');
INSERT INTO countries_info (id, country_id, text) VALUES ('8', '2', 'Alcohol limit for drivers is 0.05% BAC.');
INSERT INTO countries_info (id, country_id, text) VALUES ('9', '2', 'Children under 10 must use a child restraint system.');
INSERT INTO countries_info (id, country_id, text) VALUES ('10', '2', 'Toll roads are common in France, and payment is required at toll booths.');

INSERT INTO countries_info (id, country_id, text) VALUES ('11', '3', 'In Italy, you drive on the right side of the road.');
INSERT INTO countries_info (id, country_id, text) VALUES ('12', '3', 'ZTL (Limited Traffic Zones) have restricted access in many cities.');
INSERT INTO countries_info (id, country_id, text) VALUES ('13', '3', 'Traffic fines are on-the-spot and can be substantial.');
INSERT INTO countries_info (id, country_id, text) VALUES ('14', '3', 'Drivers must use headlights outside urban areas, even during the day.');
INSERT INTO countries_info (id, country_id, text) VALUES ('15', '3', 'Motorcycles must use headlights at all times.');

INSERT INTO countries_info (id, country_id, text) VALUES ('16', '4', 'In Spain, you drive on the right side of the road.');
INSERT INTO countries_info (id, country_id, text) VALUES ('17', '4', 'Parking in designated Blue Zones requires a special permit.');
INSERT INTO countries_info (id, country_id, text) VALUES ('18', '4', 'Alcohol limit for drivers is 0.05% BAC.');
INSERT INTO countries_info (id, country_id, text) VALUES ('19', '4', 'Using a mobile phone without a hands-free system is prohibited.');
INSERT INTO countries_info (id, country_id, text) VALUES ('20', '4', 'Children under 12 must use a child restraint system.');

INSERT INTO countries_info (id, country_id, text) VALUES ('21', '5', 'In the UK, you drive on the left side of the road.');
INSERT INTO countries_info (id, country_id, text) VALUES ('22', '5', 'Speed limits are posted in miles per hour.');
INSERT INTO countries_info (id, country_id, text) VALUES ('23', '5', 'Seat belts are mandatory for all occupants.');
INSERT INTO countries_info (id, country_id, text) VALUES ('24', '5', 'Driving under the influence of alcohol or drugs is strictly prohibited.');
INSERT INTO countries_info (id, country_id, text) VALUES ('25', '5', 'Using a mobile phone while driving is illegal.');

INSERT INTO countries_info (id, country_id, text) VALUES ('26', '6', 'In Japan, you drive on the left side of the road.');
INSERT INTO countries_info (id, country_id, text) VALUES ('27', '6', 'Strict enforcement of speed limits, especially in urban areas.');
INSERT INTO countries_info (id, country_id, text) VALUES ('28', '6', 'Speeding fines are high, and radar traps are common.');
INSERT INTO countries_info (id, country_id, text) VALUES ('29', '6', 'Headlights must be on while driving, even during the day.');
INSERT INTO countries_info (id, country_id, text) VALUES ('30', '6', 'Traffic lights use a blue signal instead of green.');

INSERT INTO countries_info (id, country_id, text) VALUES ('31', '7', 'In China, you drive on the right side of the road.');
INSERT INTO countries_info (id, country_id, text) VALUES ('32', '7', 'Strict enforcement of speed limits.');
INSERT INTO countries_info (id, country_id, text) VALUES ('33', '7', 'Driving under the influence of alcohol is strictly prohibited.');
INSERT INTO countries_info (id, country_id, text) VALUES ('34', '7', 'Seat belts are mandatory for all occupants.');
INSERT INTO countries_info (id, country_id, text) VALUES ('35', '7', 'Traffic rules are strictly enforced.');

INSERT INTO countries_info (id, country_id, text) VALUES ('36', '8', 'In the U.S., you drive on the right side of the road.');
INSERT INTO countries_info (id, country_id, text) VALUES ('37', '8', 'Speed limits vary by state and road type.');
INSERT INTO countries_info (id, country_id, text) VALUES ('38', '8', 'Seat belts are mandatory for all occupants.');
INSERT INTO countries_info (id, country_id, text) VALUES ('39', '8', 'Driving under the influence of alcohol is strictly prohibited.');
INSERT INTO countries_info (id, country_id, text) VALUES ('40', '8', 'Traffic rules are enforced by state and local authorities.');

INSERT INTO countries_info (id, country_id, text) VALUES ('41', '9', 'In Canada, you drive on the right side of the road.');
INSERT INTO countries_info (id, country_id, text) VALUES ('42', '9', 'Speed limits vary by province and territory.');
INSERT INTO countries_info (id, country_id, text) VALUES ('43', '9', 'Seat belts are mandatory for all occupants.');
INSERT INTO countries_info (id, country_id, text) VALUES ('44', '9', 'Driving under the influence of alcohol is strictly prohibited.');
INSERT INTO countries_info (id, country_id, text) VALUES ('45', '9', 'Traffic rules are enforced by provincial and municipal authorities.');




