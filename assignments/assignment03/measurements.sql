DROP TABLE IF EXISTS measurements;

CREATE TABLE measurements (
  t      numeric,
  "m(t)" numeric
);

INSERT INTO measurements(t,"m(t)") VALUES
  (1,1.0),    (1,3.0),    (1,5.0), (1,5.0),
  (2.5,0.8),  (2.5,2.0),
  (4,0.5),
  (5.5,3.0),
  (8,2.0),    (8,6.0),    (8,8.0),
  (10.5,1.0), (10.5,3.0), (10.5,8.0);

TABLE measurements;

