--CREATE ROLE Test1 WITH LOGIN PASSWORD '1';
--CREATE DATABASE pg_test1 OWNER Test1;
CREATE SCHEMA db_test1;

CREATE TABLE db_test1.patients (
  id SERIAL NOT NULL PRIMARY KEY,
  surname VARCHAR(255) NOT NULL,
  firstname VARCHAR(255) NOT NULL,
  middlename VARCHAR(255) NULL,
  birthdate DATE NOT NULL CONSTRAINT validate_birthdate CHECK(birthdate < (created + 1) AND birthdate > (created - INTERVAL '150 YEAR')),
  created DATE NOT NULL DEFAULT Now()
)
COMMENT='Учётные данные пациентов';

COMMENT ON COLUMN "patients"."id" IS 'Ключ';
COMMENT ON COLUMN "patients"."surname" IS 'Фамилия';
COMMENT ON COLUMN "patients"."firstname" IS 'Имя';
COMMENT ON COLUMN "patients"."middlename" IS 'Отчество';
COMMENT ON COLUMN "patients"."birthdate" IS 'Дата рождения';
COMMENT ON COLUMN "patients"."created" IS 'Дата записи';

CREATE TABLE db_test1.certificates (
  id SERIAL PRIMARY KEY,
  id_patient INT NOT NULL REFERENCES patients (id) ON DELETE CASCADE,
  name VARCHAR(255) NULL,
  notes VARCHAR(2047) NULL
)
COMMENT='Справки, выданные пациентам';

COMMENT ON COLUMN "certificates"."id" IS 'Ключ';
COMMENT ON COLUMN "certificates"."id_patient" IS 'Ссылка на пациента';
COMMENT ON COLUMN "certificates"."name" IS 'Название';
COMMENT ON COLUMN "certificates"."notes" IS 'Содержание';

CREATE INDEX idx_test1_patients_surname ON db_test1.patients (surname);
CREATE INDEX idx_test1_patients_birthdate ON db_test1.patients (birthdate);
CREATE INDEX idx_test1_patients_created ON db_test1.patients (created);

CREATE INDEX idx_test1_certificates_id_patient ON db_test1.certificates (id_patient);

INSERT INTO "db_test1"."patients" ("surname", "firstname", "middlename", "birthdate") VALUES 
('Иванов', 'Иван', NULL, '2018-09-29'),
('Петров', 'Петр', 'Петрович', '2010-01-09'),
('Сидоров', 'Сидор', 'Сидорович', '2008-02-21'),
('Васечкин', 'Василий', 'Игнатьевич', '2000-07-19'),
('Смолин', 'Семён', 'Викторович', '2011-04-22');

INSERT INTO "db_test1"."certificates" ("id_patient", "name", "notes") VALUES 
(1, 'Справка', 'Для Ивана...'),
(1, 'Поправка', 'по справке...'),
(2, 'Справка', 'Для Петра...');

CREATE FUNCTION PatientsSearchBySurnameBirthdate(IN i_surname VARCHAR, IN i_date_first DATE DEFAULT NULL, IN i_date_last DATE DEFAULT NULL) RETURNS refcursor AS '
DECLARE
    ref refcursor;
BEGIN
  OPEN ref FOR 
    WITH d_range AS (
      SELECT MAX(p.birthdate) AS d_max, MIN(p.birthdate) AS d_min
      FROM db_test1.patients p
    )
    SELECT p.id, p.surname, p.firstname, p.middlename, p.birthdate, p.created
    FROM db_test1.patients p
    CROSS JOIN d_range r
    WHERE p.surname LIKE ''%''|| COALESCE(i_surname, p.surname) ||''%''
    AND p.birthdate BETWEEN COALESCE(i_date_first, r.d_min) AND  COALESCE(i_date_last, r.d_max);
  RETURN ref;
END;
' LANGUAGE plpgsql;

CREATE FUNCTION PatientsSearchBySurnameCreated(IN i_surname VARCHAR, IN i_date_first DATE DEFAULT NULL, IN i_date_last DATE DEFAULT NULL) RETURNS refcursor AS '
DECLARE
    ref refcursor;
BEGIN
  OPEN ref FOR 
    WITH d_range AS (
      SELECT MAX(p.created) AS d_max, MIN(p.created) AS d_min
      FROM db_test1.patients p
    )
    SELECT p.id, p.surname, p.firstname, p.middlename, p.birthdate, p.created
    FROM db_test1.patients p
    CROSS JOIN d_range r
    WHERE p.surname LIKE ''%''|| COALESCE(i_surname, p.surname) ||''%''
    AND p.created BETWEEN COALESCE(i_date_first, r.d_min) AND  COALESCE(i_date_last, r.d_max);
  RETURN ref;
END;
' LANGUAGE plpgsql;

CREATE FUNCTION PatientsSearchBySurnameLastCreated(IN i_surname VARCHAR, IN i_count INT DEFAULT 10) RETURNS refcursor AS '
DECLARE
    ref refcursor;
BEGIN
  OPEN ref FOR 
    SELECT p.id, p.surname, p.firstname, p.middlename, p.birthdate, p.created
    FROM db_test1.patients p
    WHERE p.surname LIKE ''%''|| COALESCE(i_surname, p.surname) ||''%''
    ORDER BY p.created DESC
    FETCH FIRST i_count ROWS ONLY;
  RETURN ref;
END;
' LANGUAGE plpgsql;

CREATE FUNCTION GetPatientsAll() RETURNS refcursor AS '
DECLARE
    ref refcursor;
BEGIN
  OPEN ref FOR 
    SELECT p.id, p.surname, p.firstname, p.middlename, p.birthdate, p.created
    FROM db_test1.patients p;
  RETURN ref;
END;
' LANGUAGE plpgsql;

CREATE FUNCTION GetCertificates(i_id_patient INT) RETURNS refcursor AS '
DECLARE
    ref refcursor;
BEGIN
  OPEN ref FOR 
    SELECT c.id, c.id_patient, c.name, c.notes
    FROM db_test1.certificates c
    WHERE c.id_patient = i_id_patient;
  RETURN ref;
END;
' LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION db_test1.SetCertificate(
  INOUT i_id INTEGER, 
  IN i_id_patient INTEGER, 
  IN i_name VARCHAR,
  IN i_notes VARCHAR)
RETURNS INTEGER
AS ' 
BEGIN
  IF COALESCE(i_id, 0) = 0 THEN
    INSERT INTO db_test1.certificates (id_patient, name, notes)
    VALUES(i_id_patient, i_name, i_notes)
    RETURNING id INTO i_id;
  ELSE
    UPDATE db_test1.certificates c
    SET id_patient = i_id_patient, NAME = i_name, notes = i_notes
    WHERE c.id = i_id;
  END IF;
  RETURN;
END' LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION db_test1.DelCertificate(IN i_id INTEGER)
RETURNS INTEGER
AS ' 
BEGIN
  DELETE FROM db_test1.certificates c
  WHERE c.id = i_id;
  RETURN i_id;
END' LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION db_test1.SetPatient(
  INOUT i_id INTEGER, 
  IN i_surname VARCHAR,
  IN i_firstname VARCHAR,
  IN i_middlename VARCHAR,
  IN i_birthdate DATE,
  IN i_created DATE)
RETURNS INTEGER
AS ' 
BEGIN
  IF COALESCE(i_id, 0) = 0 THEN
    INSERT INTO db_test1.patients (surname, firstname, middlename, birthdate, created)
    VALUES(i_surname, i_firstname, i_middlename, i_birthdate, i_created)
    RETURNING id INTO i_id;
  ELSE
    UPDATE db_test1.patients
    SET surname = i_surname, 
      firstname = i_firstname, 
      middlename = i_middlename, 
      birthdate = i_birthdate, 
      created = i_created
    WHERE id = i_id;
  END IF;
  RETURN;
END' LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION db_test1.DelPatient(IN i_id INTEGER)
RETURNS INTEGER
AS ' 
BEGIN
  DELETE FROM db_test1.patients p
  WHERE p.id = i_id;
  RETURN i_id;
END' LANGUAGE plpgsql;