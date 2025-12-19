DROP TABLE IF EXISTS bars;

CREATE TABLE bars (
  x int,
  h int
);

INSERT INTO bars(x,h) VALUES
  ( 0, 2),
  ( 1, 6),
  ( 2, 3),
  ( 3, 5),
  ( 4, 2),
  ( 5, 8),
  ( 6, 1),
  ( 7, 4),
  ( 8, 2),
  ( 9, 2),
  (10, 5),
  (11, 3),
  (12, 5),
  (13, 7),
  (14, 4),
  (15, 1);

-- visualization in SQL
SELECT b.x, bar(b.h, 0, m, 2*m) AS h
FROM   bars AS b, (SELECT MAX(h) FROM bars) AS _(m),
ORDER BY b.x;
