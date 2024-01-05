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

CREATE TABLE
    IF NOT EXISTS tips (
        id VARCHAR(255) PRIMARY KEY NOT NULL,
        text VARCHAR(255) NOT NULL
    );

INSERT INTO countries (id, name) VALUES ('1', 'Germania');
INSERT INTO countries (id, name) VALUES ('2', 'Franța');
INSERT INTO countries (id, name) VALUES ('3', 'Italia');
INSERT INTO countries (id, name) VALUES ('4', 'Spania');
INSERT INTO countries (id, name) VALUES ('5', 'Regatul Unit al Marii Britanii si Irlandei de Nord');
INSERT INTO countries (id, name) VALUES ('6', 'Japonia');
INSERT INTO countries (id, name) VALUES ('7', 'China');
INSERT INTO countries (id, name) VALUES ('8', 'Statele Unite ale Americii');
INSERT INTO countries (id, name) VALUES ('9', 'Canada');


INSERT INTO countries_info (id, country_id, text) VALUES ('1', '1', 'În Germania, se conduce pe partea dreaptă a drumului.');
INSERT INTO countries_info (id, country_id, text) VALUES ('2', '1', 'Limitele de viteză de pe Autostrada sunt recomandate, dar nu obligatorii.');
INSERT INTO countries_info (id, country_id, text) VALUES ('3', '1', 'Conducerea sub influența alcoolului este strict interzisă.');
INSERT INTO countries_info (id, country_id, text) VALUES ('4', '1', 'Centurile de siguranță sunt obligatorii pentru toți ocupanții.');
INSERT INTO countries_info (id, country_id, text) VALUES ('5', '1', 'Semnalele și indicatoarele de circulație trebuie respectate strict.');

INSERT INTO countries_info (id, country_id, text) VALUES ('6', '2', 'În Franța, se conduce pe partea dreaptă a drumului.');
INSERT INTO countries_info (id, country_id, text) VALUES ('7', '2', 'Amenzile pentru depășirea vitezei sunt substanțiale, în special în zonele rezidențiale.');
INSERT INTO countries_info (id, country_id, text) VALUES ('8', '2', 'Limita de alcoolem pentru șoferi este de 0,05% BAC.');
INSERT INTO countries_info (id, country_id, text) VALUES ('9', '2', 'Copiii sub 10 ani trebuie să folosească un sistem de reținere pentru copii.');
INSERT INTO countries_info (id, country_id, text) VALUES ('10', '2', 'Autostrăzile cu taxă sunt comune în Franța, iar plata este obligatorie la punctele de taxare.');

INSERT INTO countries_info (id, country_id, text) VALUES ('11', '3', 'În Italia, se conduce pe partea dreaptă a drumului.');
INSERT INTO countries_info (id, country_id, text) VALUES ('12', '3', 'ZTL (Zone cu trafic limitat) au acces restricționat în multe orașe.');
INSERT INTO countries_info (id, country_id, text) VALUES ('13', '3', 'Amenzile de circulație sunt plătite pe loc și pot fi substanțiale.');
INSERT INTO countries_info (id, country_id, text) VALUES ('14', '3', 'Șoferii trebuie să folosească luminile de întâlnire în afara zonelor urbane, chiar și în timpul zilei.');
INSERT INTO countries_info (id, country_id, text) VALUES ('15', '3', 'Motocicletele trebuie să folosească luminile de întâlnire tot timpul.');

INSERT INTO countries_info (id, country_id, text) VALUES ('16', '4', 'În Spania, se conduce pe partea dreaptă a drumului.');
INSERT INTO countries_info (id, country_id, text) VALUES ('17', '4', 'Parcarea în zonele albastre desemnate necesită un permis special.');
INSERT INTO countries_info (id, country_id, text) VALUES ('18', '4', 'Limita de alcoolem pentru șoferi este de 0,05% BAC.');
INSERT INTO countries_info (id, country_id, text) VALUES ('19', '4', 'Folosirea telefonului mobil fără sistem hands-free este interzisă.');
INSERT INTO countries_info (id, country_id, text) VALUES ('20', '4', 'Copiii sub 12 ani trebuie să folosească un sistem de reținere pentru copii.');

INSERT INTO countries_info (id, country_id, text) VALUES ('21', '5', 'În Marea Britanie, se conduce pe partea stângă a drumului.');
INSERT INTO countries_info (id, country_id, text) VALUES ('22', '5', 'Limitele de viteză sunt afișate în mile pe oră.');
INSERT INTO countries_info (id, country_id, text) VALUES ('23', '5', 'Centurile de siguranță sunt obligatorii pentru toți ocupanții.');
INSERT INTO countries_info (id, country_id, text) VALUES ('24', '5', 'Conducerea sub influența alcoolului sau a drogurilor este strict interzisă.');
INSERT INTO countries_info (id, country_id, text) VALUES ('25', '5', 'Utilizarea telefonului mobil în timpul conducții este ilegală.');

INSERT INTO countries_info (id, country_id, text) VALUES ('26', '6', 'În Japonia, se conduce pe partea stângă a drumului.');
INSERT INTO countries_info (id, country_id, text) VALUES ('27', '6', 'Supravegherea strictă a limitelor de viteză, în special în zonele urbane.');
INSERT INTO countries_info (id, country_id, text) VALUES ('28', '6', 'Amenzile pentru depășirea vitezei sunt mari, iar radarele sunt comune.');
INSERT INTO countries_info (id, country_id, text) VALUES ('29', '6', 'Farurile trebuie să fie aprinse în timpul condusului, chiar și în timpul zilei.');
INSERT INTO countries_info (id, country_id, text) VALUES ('30', '6', 'Semnalele de circulație folosesc o lumină albastră în loc de verde.');

INSERT INTO countries_info (id, country_id, text) VALUES ('31', '7', 'În China, se conduce pe partea dreaptă a drumului.');
INSERT INTO countries_info (id, country_id, text) VALUES ('32', '7', 'Supravegherea strictă a limitelor de viteză.');
INSERT INTO countries_info (id, country_id, text) VALUES ('33', '7', 'Conducerea sub influența alcoolului este strict interzisă.');
INSERT INTO countries_info (id, country_id, text) VALUES ('34', '7', 'Centurile de siguranță sunt obligatorii pentru toți ocupanții.');
INSERT INTO countries_info (id, country_id, text) VALUES ('35', '7', 'Regulile de trafic sunt strict aplicate.');

INSERT INTO countries_info (id, country_id, text) VALUES ('36', '8', 'În SUA, se conduce pe partea dreaptă a drumului.');
INSERT INTO countries_info (id, country_id, text) VALUES ('37', '8', 'Limitele de viteză variază în funcție de stat și tipul de drum.');
INSERT INTO countries_info (id, country_id, text) VALUES ('38', '8', 'Centurile de siguranță sunt obligatorii pentru toți ocupanții.');
INSERT INTO countries_info (id, country_id, text) VALUES ('39', '8', 'Conducerea sub influența alcoolului este strict interzisă.');
INSERT INTO countries_info (id, country_id, text) VALUES ('40', '8', 'Regulile de trafic sunt aplicate de autoritățile statale și locale.');

INSERT INTO countries_info (id, country_id, text) VALUES ('41', '9', 'În Canada, se conduce pe partea dreaptă a drumului.');
INSERT INTO countries_info (id, country_id, text) VALUES ('42', '9', 'Limitele de viteză variază în funcție de provincie și teritoriu.');
INSERT INTO countries_info (id, country_id, text) VALUES ('43', '9', 'Centurile de siguranță sunt obligatorii pentru toți ocupanții.');
INSERT INTO countries_info (id, country_id, text) VALUES ('44', '9', 'Conducerea sub influența alcoolului este strict interzisă.');
INSERT INTO countries_info (id, country_id, text) VALUES ('45', '9', 'Regulile de trafic sunt aplicate de autoritățile provinciale și municipale.');

INSERT INTO tips (id, text) VALUES
        ('1', 'Înainte de examenul practic, efectuează simulări de examen cu instructorul tău pentru a te familiariza cu procedurile.'),
        ('2', 'Încearcă să acumulezi experiență în conducerea pe drumuri naționale, judetene și locale pentru a fi pregătit pentru diverse situații.'),
        ('3', 'Exersează în mod regulat manevre de marsarier pentru a te simți confortabil în timpul examenului.'),
        ('4', 'Menține o distanță sigură între mașina ta și cele din față.'),
        ('5', 'Fii atent la detalii precum reglarea oglinzilor, folosirea centurii de siguranță și respectarea regulilor de prioritate.'),
        ('6', 'Învață despre funcțiile mașinii tale, inclusiv semnalele de avertizare și indicatorii de bord.'),
        ('7', 'Exersează conducerea în diferite condiții meteorologice și de trafic pentru a te simți pregătit pentru orice.'),
        ('8', 'Exerseaza manevrele pentru parcarea cu fata, cu spatele si din lateral.'),
        ('9', 'Verifică starea mașinii înainte de a porni (lumini, anvelope, frâne).'),
        ('10', 'Menține o atitudine calmă și încredere în abilitățile tale în timpul examenului.');




