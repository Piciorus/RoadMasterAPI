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
        id VARCHAR(255) NOT NULL,
        category VARCHAR(255) NOT NULL,
        text VARCHAR(255) NOT NULL,
        answer1 VARCHAR(255) NOT NULL,
        answer2 VARCHAR(255) NOT NULL,
        answer3 VARCHAR(255) NOT NULL,
        answer4 VARCHAR(255) NOT NULL,
        is_correct_answer_1 BOOLEAN NOT NULL,
        is_correct_answer_2 BOOLEAN NOT NULL,
        is_correct_answer_3 BOOLEAN NOT NULL,
        is_correct_answer_4 BOOLEAN NOT NULL,
        PRIMARY KEY(id, category)
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


INSERT INTO multiple_choice_questions (id, category, text, answer1, answer2, answer3, answer4, is_correct_answer_1, is_correct_answer_2, is_correct_answer_3, is_correct_answer_4) VALUES
       ('1', 'A', 'Care este limita maximă de viteză în localitate?', '30 km/h', '50 km/h', '60 km/h', '70 km/h', TRUE, FALSE, FALSE, FALSE),
       ('2', 'A', 'Ce înseamnă acest semn rutier?', 'Cale fără ieșire', 'Acces interzis', 'Acces permis', 'Drum periculos', FALSE, FALSE, TRUE, FALSE),
       ('3', 'A', 'Cui trebuie să acordați prioritate în intersecția cu semnul STOP?', 'Celui care vine din dreapta', 'Celui care vine din stânga', 'Vehiculelor de pe sensul opus', 'Nimănui', TRUE, FALSE, FALSE, FALSE),
       ('4', 'A', 'Ce categorie de vehicule are obligația de a acorda prioritate de trecere?', 'Motocicletele', 'Autoturismele', 'Vehiculele care transportă persoane', 'Autovehiculele cu regim prioritar de circulație', FALSE, FALSE, FALSE, TRUE),
       ('5', 'A', 'Ce semnifică marcajul continuu dublu față de marcajul simplu?', 'Depășirea interzisă', 'Depășirea permisă', 'Depășirea cu viteză redusă', 'Depășirea este permisă doar pe timp de noapte', TRUE, FALSE, FALSE, FALSE),
       ('6', 'A', 'Ce înseamnă distanța de siguranță între vehicule?', 'Este distanța minimă obligatorie între două autovehicule', 'Este distanța pe care trebuie să o păstrați față de vehiculele care vin din spate', 'Este distanța optimă pentru a evita coliziunile în caz de frânare bruscă', 'Este distanța dintre roțile aceluiași autovehicul', FALSE, FALSE, TRUE, FALSE),
       ('7', 'A', 'Ce trebuie să faceți la semnalele polițistului rutier care dirijează circulația?', 'Ignorați semnalele și continuați deplasarea', 'Urmăriți direcțiile date de semnale', 'Reduceti viteza și vă continuați deplasarea', 'Opreșteți obligatoriu', FALSE, FALSE, TRUE, FALSE),
       ('8', 'A', 'Ce trebuie să faceți în timpul unei manevre de depășire?', 'Măriți viteza', 'Reduși viteza și păstrați o distanță de siguranță', 'Nu este necesar să reduceți viteza', 'Claxonați pentru a anunța intenția de depășire', FALSE, TRUE, FALSE, FALSE),
       ('9', 'A', 'Ce trebuie să faceți în caz de ploaie abundentă?', 'Măriți viteza', 'Folosiți luminile de întâlnire', 'Păstrați o distanță mai mică față de vehiculul din față', 'Reduceți viteza și creșteți distanța de siguranță', FALSE, FALSE, FALSE, TRUE),
       ('10', 'A', 'Cum trebuie să vă comportați în caz de derapaj al autovehiculului pe carosabilul acoperit cu zăpadă?', 'Folosiți frâna de mână', 'Rotiți volanul în sens opus derapajului', 'Acelerați pentru a ieși rapid din derapaj', 'Folosiți frâna principală', FALSE, TRUE, FALSE, FALSE),
       ('11', 'A', 'De ce trebuie să vă feriți atunci când mergeți cu bicicleta pe drumurile publice?', 'Pentru a economisi energie', 'Pentru a evita amenzi', 'Pentru a proteja mediul înconjurător', 'Pentru a preveni accidentele și a vă asigura vizibilitatea', FALSE, FALSE, FALSE, TRUE),
       ('12', 'A', 'Ce trebuie să faceți în cazul unei ambulanțe cu semnalele acustice și luminoase în funcțiune?', 'Ocoliți ambulanța', 'Reduceți viteza și dați prioritate', 'Ignorați ambulanța', 'Măriți viteza pentru a-i facilita accesul', FALSE, TRUE, FALSE, FALSE),
       ('13', 'A', 'Ce înseamnă acest semn adițional?', 'Staționare cu parcare interzisă', 'Zonă de parcare', 'Accesul interzis autovehiculelor cu motor', 'Oprirea interzisă', FALSE, FALSE, TRUE, FALSE),
       ('14', 'A', 'De ce este important să vă mențineți concentrarea asupra drumului?', 'Pentru a socializa cu pasagerii', 'Pentru a economisi combustibil', 'Pentru a evita amenzile', 'Pentru a preveni accidentele de circulație', FALSE, FALSE, FALSE, TRUE),
       ('15', 'A', 'Ce trebuie să faceți în cazul întâlnirii unui vehicul care circulă din sens opus și folosește faza lungă a farurilor?', 'Păstrați aceeași intensitate a farurilor', 'Comutați și dumneavoastră pe faza lungă a farurilor', 'Reduceți viteza și continuați cu farurile pe faza scurtă', 'Claxonați pentru a avertiza conducătorul vehiculului din față', FALSE, TRUE, FALSE, FALSE),
       ('16', 'A', 'Ce trebuie să faceți în caz de derapaj al autovehiculului pe carosabilul acoperit cu zăpadă?', 'Folosiți frâna de mână', 'Rotiți volanul în sens opus derapajului', 'Acelerați pentru a ieși rapid din derapaj', 'Folosiți frâna principală', FALSE, TRUE, FALSE, FALSE),
       ('17', 'A', 'Cum trebuie să vă comportați în caz de ploaie abundentă?', 'Măriți viteza', 'Folosiți luminile de întâlnire', 'Păstrați o distanță mai mică față de vehiculul din față', 'Reduceți viteza și creșteți distanța de siguranță', FALSE, FALSE, FALSE, TRUE),
       ('18', 'A', 'De ce este important să vă mențineți concentrarea asupra drumului?', 'Pentru a socializa cu pasagerii', 'Pentru a economisi combustibil', 'Pentru a evita amenzile', 'Pentru a preveni accidentele de circulație', FALSE, FALSE, FALSE, TRUE),
       ('19', 'A', 'Ce trebuie să faceți la semnalele polițistului rutier care dirijează circulația?', 'Ignorați semnalele și continuați deplasarea', 'Urmăriți direcțiile date de semnale', 'Reduceti viteza și vă continuați deplasarea', 'Opreșteți obligatoriu', FALSE, FALSE, TRUE, FALSE),
       ('20', 'A', 'Ce trebuie să faceți în timpul unei manevre de depășire?', 'Măriți viteza', 'Reduși viteza și păstrați o distanță de siguranță', 'Nu este necesar să reduceți viteza', 'Claxonați pentru a anunța intenția de depășire', FALSE, TRUE, FALSE, FALSE),
       ('21', 'A', 'Cum trebuie să vă comportați în caz de derapaj al autovehiculului pe carosabilul acoperit cu zăpadă?', 'Folosiți frâna de mână', 'Rotiți volanul în sens opus derapajului', 'Acelerați pentru a ieși rapid din derapaj', 'Folosiți frâna principală', FALSE, TRUE, FALSE, FALSE),
       ('22', 'A', 'De ce trebuie să vă feriți atunci când mergeți cu bicicleta pe drumurile publice?', 'Pentru a economisi energie', 'Pentru a evita amenzi', 'Pentru a proteja mediul înconjurător', 'Pentru a preveni accidentele și a vă asigura vizibilitatea', FALSE, FALSE, FALSE, TRUE),
       ('23', 'A', 'Ce înseamnă acest semn adițional?', 'Staționare cu parcare interzisă', 'Zonă de parcare', 'Accesul interzis autovehiculelor cu motor', 'Oprirea interzisă', FALSE, FALSE, TRUE, FALSE),
       ('24', 'A', 'De ce este important să vă mențineți concentrarea asupra drumului?', 'Pentru a socializa cu pasagerii', 'Pentru a economisi combustibil', 'Pentru a evita amenzile', 'Pentru a preveni accidentele de circulație', FALSE, FALSE, FALSE, TRUE),
       ('25', 'A', 'Ce trebuie să faceți la semnalele polițistului rutier care dirijează circulația?', 'Ignorați semnalele și continuați deplasarea', 'Urmăriți direcțiile date de semnale', 'Reduceti viteza și vă continuați deplasarea', 'Opreșteți obligatoriu', FALSE, FALSE, TRUE, FALSE),
       ('26', 'A', 'Ce trebuie să faceți în timpul unei manevre de depășire?', 'Măriți viteza', 'Reduși viteza și păstrați o distanță de siguranță', 'Nu este necesar să reduceți viteza', 'Claxonați pentru a anunța intenția de depășire', FALSE, TRUE, FALSE, FALSE);
INSERT INTO multiple_choice_questions (id, category, text, answer1, answer2, answer3, answer4, is_correct_answer_1, is_correct_answer_2, is_correct_answer_3, is_correct_answer_4) VALUES
       ('1', 'B', 'Care este limita maximă de viteză în localitate?', '30 km/h', '50 km/h', '60 km/h', '70 km/h', TRUE, FALSE, FALSE, FALSE),
       ('2', 'B', 'Ce înseamnă acest semn rutier?', 'Cale fără ieșire', 'Acces interzis', 'Acces permis', 'Drum periculos', FALSE, FALSE, TRUE, FALSE),
       ('3', 'B', 'Cui trebuie să acordați prioritate în intersecția cu semnul STOP?', 'Celui care vine din dreapta', 'Celui care vine din stânga', 'Vehiculelor de pe sensul opus', 'Nimănui', TRUE, FALSE, FALSE, FALSE),
       ('4', 'B', 'Ce categorie de vehicule are obligația de a acorda prioritate de trecere?', 'Motocicletele', 'Autoturismele', 'Vehiculele care transportă persoane', 'Autovehiculele cu regim prioritar de circulație', FALSE, FALSE, FALSE, TRUE),
       ('5', 'B', 'Ce semnifică marcajul continuu dublu față de marcajul simplu?', 'Depășirea interzisă', 'Depășirea permisă', 'Depășirea cu viteză redusă', 'Depășirea este permisă doar pe timp de noapte', TRUE, FALSE, FALSE, FALSE),
       ('6', 'B', 'Ce înseamnă distanța de siguranță între vehicule?', 'Este distanța minimă obligatorie între două autovehicule', 'Este distanța pe care trebuie să o păstrați față de vehiculele care vin din spate', 'Este distanța optimă pentru a evita coliziunile în caz de frânare bruscă', 'Este distanța dintre roțile aceluiași autovehicul', FALSE, FALSE, TRUE, FALSE),
       ('7', 'B', 'Ce trebuie să faceți la semnalele polițistului rutier care dirijează circulația?', 'Ignorați semnalele și continuați deplasarea', 'Urmăriți direcțiile date de semnale', 'Reduceti viteza și vă continuați deplasarea', 'Opreșteți obligatoriu', FALSE, FALSE, TRUE, FALSE),
       ('8', 'B', 'Ce trebuie să faceți în timpul unei manevre de depășire?', 'Măriți viteza', 'Reduși viteza și păstrați o distanță de siguranță', 'Nu este necesar să reduceți viteza', 'Claxonați pentru a anunța intenția de depășire', FALSE, TRUE, FALSE, FALSE),
       ('9', 'B', 'Ce trebuie să faceți în caz de ploaie abundentă?', 'Măriți viteza', 'Folosiți luminile de întâlnire', 'Păstrați o distanță mai mică față de vehiculul din față', 'Reduceți viteza și creșteți distanța de siguranță', FALSE, FALSE, FALSE, TRUE),
       ('10', 'B', 'Cum trebuie să vă comportați în caz de derapaj al autovehiculului pe carosabilul acoperit cu zăpadă?', 'Folosiți frâna de mână', 'Rotiți volanul în sens opus derapajului', 'Acelerați pentru a ieși rapid din derapaj', 'Folosiți frâna principală', FALSE, TRUE, FALSE, FALSE),
       ('11', 'B', 'De ce trebuie să vă feriți atunci când mergeți cu bicicleta pe drumurile publice?', 'Pentru a economisi energie', 'Pentru a evita amenzi', 'Pentru a proteja mediul înconjurător', 'Pentru a preveni accidentele și a vă asigura vizibilitatea', FALSE, FALSE, FALSE, TRUE),
       ('12', 'B', 'Ce trebuie să faceți în cazul unei ambulanțe cu semnalele acustice și luminoase în funcțiune?', 'Ocoliți ambulanța', 'Reduceți viteza și dați prioritate', 'Ignorați ambulanța', 'Măriți viteza pentru a-i facilita accesul', FALSE, TRUE, FALSE, FALSE),
       ('13', 'B', 'Ce înseamnă acest semn adițional?', 'Staționare cu parcare interzisă', 'Zonă de parcare', 'Accesul interzis autovehiculelor cu motor', 'Oprirea interzisă', FALSE, FALSE, TRUE, FALSE),
       ('14', 'B', 'De ce este important să vă mențineți concentrarea asupra drumului?', 'Pentru a socializa cu pasagerii', 'Pentru a economisi combustibil', 'Pentru a evita amenzile', 'Pentru a preveni accidentele de circulație', FALSE, FALSE, FALSE, TRUE),
       ('15', 'B', 'Ce trebuie să faceți în cazul întâlnirii unui vehicul care circulă din sens opus și folosește faza lungă a farurilor?', 'Păstrați aceeași intensitate a farurilor', 'Comutați și dumneavoastră pe faza lungă a farurilor', 'Reduceți viteza și continuați cu farurile pe faza scurtă', 'Claxonați pentru a avertiza conducătorul vehiculului din față', FALSE, TRUE, FALSE, FALSE),
       ('16', 'B', 'Ce trebuie să faceți în caz de derapaj al autovehiculului pe carosabilul acoperit cu zăpadă?', 'Folosiți frâna de mână', 'Rotiți volanul în sens opus derapajului', 'Acelerați pentru a ieși rapid din derapaj', 'Folosiți frâna principală', FALSE, TRUE, FALSE, FALSE),
       ('17', 'B', 'Cum trebuie să vă comportați în caz de ploaie abundentă?', 'Măriți viteza', 'Folosiți luminile de întâlnire', 'Păstrați o distanță mai mică față de vehiculul din față', 'Reduceți viteza și creșteți distanța de siguranță', FALSE, FALSE, FALSE, TRUE),
       ('18', 'B', 'De ce este important să vă mențineți concentrarea asupra drumului?', 'Pentru a socializa cu pasagerii', 'Pentru a economisi combustibil', 'Pentru a evita amenzile', 'Pentru a preveni accidentele de circulație', FALSE, FALSE, FALSE, TRUE),
       ('19', 'B', 'Ce trebuie să faceți la semnalele polițistului rutier care dirijează circulația?', 'Ignorați semnalele și continuați deplasarea', 'Urmăriți direcțiile date de semnale', 'Reduceti viteza și vă continuați deplasarea', 'Opreșteți obligatoriu', FALSE, FALSE, TRUE, FALSE),
       ('20', 'B', 'Ce trebuie să faceți în timpul unei manevre de depășire?', 'Măriți viteza', 'Reduși viteza și păstrați o distanță de siguranță', 'Nu este necesar să reduceți viteza', 'Claxonați pentru a anunța intenția de depășire', FALSE, TRUE, FALSE, FALSE),
       ('21', 'B', 'Cum trebuie să vă comportați în caz de derapaj al autovehiculului pe carosabilul acoperit cu zăpadă?', 'Folosiți frâna de mână', 'Rotiți volanul în sens opus derapajului', 'Acelerați pentru a ieși rapid din derapaj', 'Folosiți frâna principală', FALSE, TRUE, FALSE, FALSE),
       ('22', 'B', 'De ce trebuie să vă feriți atunci când mergeți cu bicicleta pe drumurile publice?', 'Pentru a economisi energie', 'Pentru a evita amenzi', 'Pentru a proteja mediul înconjurător', 'Pentru a preveni accidentele și a vă asigura vizibilitatea', FALSE, FALSE, FALSE, TRUE),
       ('23', 'B', 'Ce înseamnă acest semn adițional?', 'Staționare cu parcare interzisă', 'Zonă de parcare', 'Accesul interzis autovehiculelor cu motor', 'Oprirea interzisă', FALSE, FALSE, TRUE, FALSE),
       ('24', 'B', 'De ce este important să vă mențineți concentrarea asupra drumului?', 'Pentru a socializa cu pasagerii', 'Pentru a economisi combustibil', 'Pentru a evita amenzile', 'Pentru a preveni accidentele de circulație', FALSE, FALSE, FALSE, TRUE),
       ('25', 'B', 'Ce trebuie să faceți la semnalele polițistului rutier care dirijează circulația?', 'Ignorați semnalele și continuați deplasarea', 'Urmăriți direcțiile date de semnale', 'Reduceti viteza și vă continuați deplasarea', 'Opreșteți obligatoriu', FALSE, FALSE, TRUE, FALSE),
       ('26', 'B', 'Ce trebuie să faceți în timpul unei manevre de depășire?', 'Măriți viteza', 'Reduși viteza și păstrați o distanță de siguranță', 'Nu este necesar să reduceți viteza', 'Claxonați pentru a anunța intenția de depășire', FALSE, TRUE, FALSE, FALSE);
INSERT INTO multiple_choice_questions (id, category, text, answer1, answer2, answer3, answer4, is_correct_answer_1, is_correct_answer_2, is_correct_answer_3, is_correct_answer_4) VALUES
       ('1', 'C', 'Care este limita maximă de viteză în localitate?', '30 km/h', '50 km/h', '60 km/h', '70 km/h', TRUE, FALSE, FALSE, FALSE),
       ('2', 'C', 'Ce înseamnă acest semn rutier?', 'Cale fără ieșire', 'Acces interzis', 'Acces permis', 'Drum periculos', FALSE, FALSE, TRUE, FALSE),
       ('3', 'C', 'Cui trebuie să acordați prioritate în intersecția cu semnul STOP?', 'Celui care vine din dreapta', 'Celui care vine din stânga', 'Vehiculelor de pe sensul opus', 'Nimănui', TRUE, FALSE, FALSE, FALSE),
       ('4', 'C', 'Ce categorie de vehicule are obligația de a acorda prioritate de trecere?', 'Motocicletele', 'Autoturismele', 'Vehiculele care transportă persoane', 'Autovehiculele cu regim prioritar de circulație', FALSE, FALSE, FALSE, TRUE),
       ('5', 'C', 'Ce semnifică marcajul continuu dublu față de marcajul simplu?', 'Depășirea interzisă', 'Depășirea permisă', 'Depășirea cu viteză redusă', 'Depășirea este permisă doar pe timp de noapte', TRUE, FALSE, FALSE, FALSE),
       ('6', 'C', 'Ce înseamnă distanța de siguranță între vehicule?', 'Este distanța minimă obligatorie între două autovehicule', 'Este distanța pe care trebuie să o păstrați față de vehiculele care vin din spate', 'Este distanța optimă pentru a evita coliziunile în caz de frânare bruscă', 'Este distanța dintre roțile aceluiași autovehicul', FALSE, FALSE, TRUE, FALSE),
       ('7', 'C', 'Ce trebuie să faceți la semnalele polițistului rutier care dirijează circulația?', 'Ignorați semnalele și continuați deplasarea', 'Urmăriți direcțiile date de semnale', 'Reduceti viteza și vă continuați deplasarea', 'Opreșteți obligatoriu', FALSE, FALSE, TRUE, FALSE),
       ('8', 'C', 'Ce trebuie să faceți în timpul unei manevre de depășire?', 'Măriți viteza', 'Reduși viteza și păstrați o distanță de siguranță', 'Nu este necesar să reduceți viteza', 'Claxonați pentru a anunța intenția de depășire', FALSE, TRUE, FALSE, FALSE),
       ('9', 'C', 'Ce trebuie să faceți în caz de ploaie abundentă?', 'Măriți viteza', 'Folosiți luminile de întâlnire', 'Păstrați o distanță mai mică față de vehiculul din față', 'Reduceți viteza și creșteți distanța de siguranță', FALSE, FALSE, FALSE, TRUE),
       ('10', 'C', 'Cum trebuie să vă comportați în caz de derapaj al autovehiculului pe carosabilul acoperit cu zăpadă?', 'Folosiți frâna de mână', 'Rotiți volanul în sens opus derapajului', 'Acelerați pentru a ieși rapid din derapaj', 'Folosiți frâna principală', FALSE, TRUE, FALSE, FALSE),
       ('11', 'C', 'De ce trebuie să vă feriți atunci când mergeți cu bicicleta pe drumurile publice?', 'Pentru a economisi energie', 'Pentru a evita amenzi', 'Pentru a proteja mediul înconjurător', 'Pentru a preveni accidentele și a vă asigura vizibilitatea', FALSE, FALSE, FALSE, TRUE),
       ('12', 'C', 'Ce trebuie să faceți în cazul unei ambulanțe cu semnalele acustice și luminoase în funcțiune?', 'Ocoliți ambulanța', 'Reduceți viteza și dați prioritate', 'Ignorați ambulanța', 'Măriți viteza pentru a-i facilita accesul', FALSE, TRUE, FALSE, FALSE),
       ('13', 'C', 'Ce înseamnă acest semn adițional?', 'Staționare cu parcare interzisă', 'Zonă de parcare', 'Accesul interzis autovehiculelor cu motor', 'Oprirea interzisă', FALSE, FALSE, TRUE, FALSE),
       ('14', 'C', 'De ce este important să vă mențineți concentrarea asupra drumului?', 'Pentru a socializa cu pasagerii', 'Pentru a economisi combustibil', 'Pentru a evita amenzile', 'Pentru a preveni accidentele de circulație', FALSE, FALSE, FALSE, TRUE),
       ('15', 'C', 'Ce trebuie să faceți în cazul întâlnirii unui vehicul care circulă din sens opus și folosește faza lungă a farurilor?', 'Păstrați aceeași intensitate a farurilor', 'Comutați și dumneavoastră pe faza lungă a farurilor', 'Reduceți viteza și continuați cu farurile pe faza scurtă', 'Claxonați pentru a avertiza conducătorul vehiculului din față', FALSE, TRUE, FALSE, FALSE),
       ('16', 'C', 'Ce trebuie să faceți în caz de derapaj al autovehiculului pe carosabilul acoperit cu zăpadă?', 'Folosiți frâna de mână', 'Rotiți volanul în sens opus derapajului', 'Acelerați pentru a ieși rapid din derapaj', 'Folosiți frâna principală', FALSE, TRUE, FALSE, FALSE),
       ('17', 'C', 'Cum trebuie să vă comportați în caz de ploaie abundentă?', 'Măriți viteza', 'Folosiți luminile de întâlnire', 'Păstrați o distanță mai mică față de vehiculul din față', 'Reduceți viteza și creșteți distanța de siguranță', FALSE, FALSE, FALSE, TRUE),
       ('18', 'C', 'De ce este important să vă mențineți concentrarea asupra drumului?', 'Pentru a socializa cu pasagerii', 'Pentru a economisi combustibil', 'Pentru a evita amenzile', 'Pentru a preveni accidentele de circulație', FALSE, FALSE, FALSE, TRUE),
       ('19', 'C', 'Ce trebuie să faceți la semnalele polițistului rutier care dirijează circulația?', 'Ignorați semnalele și continuați deplasarea', 'Urmăriți direcțiile date de semnale', 'Reduceti viteza și vă continuați deplasarea', 'Opreșteți obligatoriu', FALSE, FALSE, TRUE, FALSE),
       ('20', 'C', 'Ce trebuie să faceți în timpul unei manevre de depășire?', 'Măriți viteza', 'Reduși viteza și păstrați o distanță de siguranță', 'Nu este necesar să reduceți viteza', 'Claxonați pentru a anunța intenția de depășire', FALSE, TRUE, FALSE, FALSE),
       ('21', 'C', 'Cum trebuie să vă comportați în caz de derapaj al autovehiculului pe carosabilul acoperit cu zăpadă?', 'Folosiți frâna de mână', 'Rotiți volanul în sens opus derapajului', 'Acelerați pentru a ieși rapid din derapaj', 'Folosiți frâna principală', FALSE, TRUE, FALSE, FALSE),
       ('22', 'C', 'De ce trebuie să vă feriți atunci când mergeți cu bicicleta pe drumurile publice?', 'Pentru a economisi energie', 'Pentru a evita amenzi', 'Pentru a proteja mediul înconjurător', 'Pentru a preveni accidentele și a vă asigura vizibilitatea', FALSE, FALSE, FALSE, TRUE),
       ('23', 'C', 'Ce înseamnă acest semn adițional?', 'Staționare cu parcare interzisă', 'Zonă de parcare', 'Accesul interzis autovehiculelor cu motor', 'Oprirea interzisă', FALSE, FALSE, TRUE, FALSE),
       ('24', 'C', 'De ce este important să vă mențineți concentrarea asupra drumului?', 'Pentru a socializa cu pasagerii', 'Pentru a economisi combustibil', 'Pentru a evita amenzile', 'Pentru a preveni accidentele de circulație', FALSE, FALSE, FALSE, TRUE),
       ('25', 'C', 'Ce trebuie să faceți la semnalele polițistului rutier care dirijează circulația?', 'Ignorați semnalele și continuați deplasarea', 'Urmăriți direcțiile date de semnale', 'Reduceti viteza și vă continuați deplasarea', 'Opreșteți obligatoriu', FALSE, FALSE, TRUE, FALSE),
       ('26', 'C', 'Ce trebuie să faceți în timpul unei manevre de depășire?', 'Măriți viteza', 'Reduși viteza și păstrați o distanță de siguranță', 'Nu este necesar să reduceți viteza', 'Claxonați pentru a anunța intenția de depășire', FALSE, TRUE, FALSE, FALSE);
INSERT INTO multiple_choice_questions (id, category, text, answer1, answer2, answer3, answer4, is_correct_answer_1, is_correct_answer_2, is_correct_answer_3, is_correct_answer_4) VALUES
       ('1', 'D', 'Care este limita maximă de viteză în localitate?', '30 km/h', '50 km/h', '60 km/h', '70 km/h', TRUE, FALSE, FALSE, FALSE),
       ('2', 'D', 'Ce înseamnă acest semn rutier?', 'Cale fără ieșire', 'Acces interzis', 'Acces permis', 'Drum periculos', FALSE, FALSE, TRUE, FALSE),
       ('3', 'D', 'Cui trebuie să acordați prioritate în intersecția cu semnul STOP?', 'Celui care vine din dreapta', 'Celui care vine din stânga', 'Vehiculelor de pe sensul opus', 'Nimănui', TRUE, FALSE, FALSE, FALSE),
       ('4', 'D', 'Ce categorie de vehicule are obligația de a acorda prioritate de trecere?', 'Motocicletele', 'Autoturismele', 'Vehiculele care transportă persoane', 'Autovehiculele cu regim prioritar de circulație', FALSE, FALSE, FALSE, TRUE),
       ('5', 'D', 'Ce semnifică marcajul continuu dublu față de marcajul simplu?', 'Depășirea interzisă', 'Depășirea permisă', 'Depășirea cu viteză redusă', 'Depășirea este permisă doar pe timp de noapte', TRUE, FALSE, FALSE, FALSE),
       ('6', 'D', 'Ce înseamnă distanța de siguranță între vehicule?', 'Este distanța minimă obligatorie între două autovehicule', 'Este distanța pe care trebuie să o păstrați față de vehiculele care vin din spate', 'Este distanța optimă pentru a evita coliziunile în caz de frânare bruscă', 'Este distanța dintre roțile aceluiași autovehicul', FALSE, FALSE, TRUE, FALSE),
       ('7', 'D', 'Ce trebuie să faceți la semnalele polițistului rutier care dirijează circulația?', 'Ignorați semnalele și continuați deplasarea', 'Urmăriți direcțiile date de semnale', 'Reduceti viteza și vă continuați deplasarea', 'Opreșteți obligatoriu', FALSE, FALSE, TRUE, FALSE),
       ('8', 'D', 'Ce trebuie să faceți în timpul unei manevre de depășire?', 'Măriți viteza', 'Reduși viteza și păstrați o distanță de siguranță', 'Nu este necesar să reduceți viteza', 'Claxonați pentru a anunța intenția de depășire', FALSE, TRUE, FALSE, FALSE),
       ('9', 'D', 'Ce trebuie să faceți în caz de ploaie abundentă?', 'Măriți viteza', 'Folosiți luminile de întâlnire', 'Păstrați o distanță mai mică față de vehiculul din față', 'Reduceți viteza și creșteți distanța de siguranță', FALSE, FALSE, FALSE, TRUE),
       ('10', 'D', 'Cum trebuie să vă comportați în caz de derapaj al autovehiculului pe carosabilul acoperit cu zăpadă?', 'Folosiți frâna de mână', 'Rotiți volanul în sens opus derapajului', 'Acelerați pentru a ieși rapid din derapaj', 'Folosiți frâna principală', FALSE, TRUE, FALSE, FALSE),
       ('11', 'D', 'De ce trebuie să vă feriți atunci când mergeți cu bicicleta pe drumurile publice?', 'Pentru a economisi energie', 'Pentru a evita amenzi', 'Pentru a proteja mediul înconjurător', 'Pentru a preveni accidentele și a vă asigura vizibilitatea', FALSE, FALSE, FALSE, TRUE),
       ('12', 'D', 'Ce trebuie să faceți în cazul unei ambulanțe cu semnalele acustice și luminoase în funcțiune?', 'Ocoliți ambulanța', 'Reduceți viteza și dați prioritate', 'Ignorați ambulanța', 'Măriți viteza pentru a-i facilita accesul', FALSE, TRUE, FALSE, FALSE),
       ('13', 'D', 'Ce înseamnă acest semn adițional?', 'Staționare cu parcare interzisă', 'Zonă de parcare', 'Accesul interzis autovehiculelor cu motor', 'Oprirea interzisă', FALSE, FALSE, TRUE, FALSE),
       ('14', 'D', 'De ce este important să vă mențineți concentrarea asupra drumului?', 'Pentru a socializa cu pasagerii', 'Pentru a economisi combustibil', 'Pentru a evita amenzile', 'Pentru a preveni accidentele de circulație', FALSE, FALSE, FALSE, TRUE),
       ('15', 'D', 'Ce trebuie să faceți în cazul întâlnirii unui vehicul care circulă din sens opus și folosește faza lungă a farurilor?', 'Păstrați aceeași intensitate a farurilor', 'Comutați și dumneavoastră pe faza lungă a farurilor', 'Reduceți viteza și continuați cu farurile pe faza scurtă', 'Claxonați pentru a avertiza conducătorul vehiculului din față', FALSE, TRUE, FALSE, FALSE),
       ('16', 'D', 'Ce trebuie să faceți în caz de derapaj al autovehiculului pe carosabilul acoperit cu zăpadă?', 'Folosiți frâna de mână', 'Rotiți volanul în sens opus derapajului', 'Acelerați pentru a ieși rapid din derapaj', 'Folosiți frâna principală', FALSE, TRUE, FALSE, FALSE),
       ('17', 'D', 'Cum trebuie să vă comportați în caz de ploaie abundentă?', 'Măriți viteza', 'Folosiți luminile de întâlnire', 'Păstrați o distanță mai mică față de vehiculul din față', 'Reduceți viteza și creșteți distanța de siguranță', FALSE, FALSE, FALSE, TRUE),
       ('18', 'D', 'De ce este important să vă mențineți concentrarea asupra drumului?', 'Pentru a socializa cu pasagerii', 'Pentru a economisi combustibil', 'Pentru a evita amenzile', 'Pentru a preveni accidentele de circulație', FALSE, FALSE, FALSE, TRUE),
       ('19', 'D', 'Ce trebuie să faceți la semnalele polițistului rutier care dirijează circulația?', 'Ignorați semnalele și continuați deplasarea', 'Urmăriți direcțiile date de semnale', 'Reduceti viteza și vă continuați deplasarea', 'Opreșteți obligatoriu', FALSE, FALSE, TRUE, FALSE),
       ('20', 'D', 'Ce trebuie să faceți în timpul unei manevre de depășire?', 'Măriți viteza', 'Reduși viteza și păstrați o distanță de siguranță', 'Nu este necesar să reduceți viteza', 'Claxonați pentru a anunța intenția de depășire', FALSE, TRUE, FALSE, FALSE),
       ('21', 'D', 'Cum trebuie să vă comportați în caz de derapaj al autovehiculului pe carosabilul acoperit cu zăpadă?', 'Folosiți frâna de mână', 'Rotiți volanul în sens opus derapajului', 'Acelerați pentru a ieși rapid din derapaj', 'Folosiți frâna principală', FALSE, TRUE, FALSE, FALSE),
       ('22', 'D', 'De ce trebuie să vă feriți atunci când mergeți cu bicicleta pe drumurile publice?', 'Pentru a economisi energie', 'Pentru a evita amenzi', 'Pentru a proteja mediul înconjurător', 'Pentru a preveni accidentele și a vă asigura vizibilitatea', FALSE, FALSE, FALSE, TRUE),
       ('23', 'D', 'Ce înseamnă acest semn adițional?', 'Staționare cu parcare interzisă', 'Zonă de parcare', 'Accesul interzis autovehiculelor cu motor', 'Oprirea interzisă', FALSE, FALSE, TRUE, FALSE),
       ('24', 'D', 'De ce este important să vă mențineți concentrarea asupra drumului?', 'Pentru a socializa cu pasagerii', 'Pentru a economisi combustibil', 'Pentru a evita amenzile', 'Pentru a preveni accidentele de circulație', FALSE, FALSE, FALSE, TRUE),
       ('25', 'D', 'Ce trebuie să faceți la semnalele polițistului rutier care dirijează circulația?', 'Ignorați semnalele și continuați deplasarea', 'Urmăriți direcțiile date de semnale', 'Reduceti viteza și vă continuați deplasarea', 'Opreșteți obligatoriu', FALSE, FALSE, TRUE, FALSE),
       ('26', 'D', 'Ce trebuie să faceți în timpul unei manevre de depășire?', 'Măriți viteza', 'Reduși viteza și păstrați o distanță de siguranță', 'Nu este necesar să reduceți viteza', 'Claxonați pentru a anunța intenția de depășire', FALSE, TRUE, FALSE, FALSE);