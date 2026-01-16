DROP TABLE IF EXISTS room;

CREATE TABLE room (
  x   int     CHECK(x > 0),
  y   int     CHECK(y > 0),
  dir char(1) NOT NULL
      CHECK (dir IN ('E','W','N','S','X')),
  PRIMARY KEY (x,y)
);

CREATE OR REPLACE MACRO width()  AS 4;
CREATE OR REPLACE MACRO height() AS 4;

INSERT INTO room(x, y, dir) VALUES
  (1, 1, 'E'), (3, 1, 'S'), (4, 1, 'S'),
  (1, 2, 'W'),
  (2, 3, 'S'), (3, 3, 'W'), (4, 3, 'X'),
  (2, 4, 'E'), (3, 4, 'X');

CREATE OR REPLACE MACRO generate_series(α,ω,step := 1) AS TABLE
  WITH RECURSIVE __series(generate_series) AS (
    SELECT α::int64 UNION ALL SELECT generate_series + step FROM __series WHERE generate_series < ω) TABLE __series;
