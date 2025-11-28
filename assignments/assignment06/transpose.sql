DROP TABLE IF EXISTS matrices;

CREATE TABLE matrices (
  id     int       PRIMARY KEY,
  matrix text[][]  NOT NULL
);

INSERT INTO matrices(id, matrix) VALUES
(1, [['1','2','3'],
     ['4','5','6']]),
(2, [['l','k','j','i'],
     ['h','g','f','e'],
     ['d','c','b','a']]);
