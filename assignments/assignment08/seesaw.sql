CREATE OR REPLACE TABLE seesaw (
  pos    int PRIMARY KEY,
  weight int NOT NULL
);

INSERT INTO seesaw (
  SELECT pos, floor(random()*10) AS weight
  FROM   generate_series(1,100) AS _(pos)
);
