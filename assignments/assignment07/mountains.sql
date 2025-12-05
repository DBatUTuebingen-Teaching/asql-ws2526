DROP SEQUENCE IF EXISTS serial CASCADE;
DROP TABLE IF EXISTS mountains;

CREATE SEQUENCE serial START 1;

CREATE TABLE mountains (
  level int  DEFAULT nextval('serial') PRIMARY KEY,
  slice text
);

INSERT INTO mountains(slice) VALUES
  (' #  '),
  ('### '),
  ('####');
