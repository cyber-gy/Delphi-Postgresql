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
COMMENT='������� ������ ���������';

COMMENT ON COLUMN "patients"."id" IS '����';
COMMENT ON COLUMN "patients"."surname" IS '�������';
COMMENT ON COLUMN "patients"."firstname" IS '���';
COMMENT ON COLUMN "patients"."middlename" IS '��������';
COMMENT ON COLUMN "patients"."birthdate" IS '���� ��������';
COMMENT ON COLUMN "patients"."created" IS '���� ������';

CREATE TABLE db_test1.certificates (
  id SERIAL PRIMARY KEY,
  id_patient INT NOT NULL REFERENCES patients (id) ON DELETE CASCADE,
  name VARCHAR(255) NULL,
  notes VARCHAR(2047) NULL
)
COMMENT='�������, �������� ���������';

COMMENT ON COLUMN "certificates"."id" IS '����';
COMMENT ON COLUMN "certificates"."id_patient" IS '������ �� ��������';
COMMENT ON COLUMN "certificates"."name" IS '��������';
COMMENT ON COLUMN "certificates"."notes" IS '����������';

CREATE INDEX idx_test1_patients_surname ON db_test1.patients (surname);
CREATE INDEX idx_test1_patients_birthdate ON db_test1.patients (birthdate);
CREATE INDEX idx_test1_patients_created ON db_test1.patients (created);

CREATE INDEX idx_test1_certificates_id_patient ON db_test1.certificates (id_patient);

INSERT INTO "db_test1"."patients" ("surname", "firstname", "middlename", "birthdate") VALUES 
('������', '����', NULL, '2018-09-29'),
('������', '����', '��������', '2010-01-09'),
('�������', '�����', '���������', '2008-02-21'),
('��������', '�������', '����������', '2000-07-19'),
('������', '����', '����������', '2011-04-22');

INSERT INTO "db_test1"."certificates" ("id_patient", "name", "notes") VALUES 
(1, '�������', '��� �����...'),
(1, '��������', '�� �������...'),
(2, '�������', '��� �����...')