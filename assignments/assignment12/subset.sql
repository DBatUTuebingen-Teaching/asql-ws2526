DROP TABLE IF EXISTS planes;
DROP TABLE IF EXISTS items;

CREATE TABLE planes(
  planeid   int PRIMARY KEY,
  allowance int NOT NULL
);

CREATE TABLE items(
  itemid int PRIMARY KEY,
  weight int NOT NULL
);

INSERT INTO planes VALUES
  (1, 25000),
  (2, 19000),
  (3, 27000);

INSERT INTO items VALUES
  ( 1,  7120), ( 2,  8150),
  ( 3,  8255), ( 4,  9051),
  ( 5,  1220), ( 6, 12558),
  ( 7, 13555), ( 8,  5221),
  ( 9,   812), (10,  6562);
