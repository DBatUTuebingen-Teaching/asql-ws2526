DROP TABLE IF EXISTS roads CASCADE;

CREATE TABLE roads (
  here  text,
  there text,
  dist  int,
  PRIMARY KEY(here, there)
);

INSERT INTO roads VALUES
  ('A', 'B', 12),
  ('A', 'C', 30),
  ('A', 'D', 42),
  ('B', 'C', 35),
  ('B', 'D', 34),
  ('C', 'D', 20);
