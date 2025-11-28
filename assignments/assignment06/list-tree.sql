DROP TABLE IF EXISTS trees;

CREATE TABLE trees (
  tree    int       PRIMARY KEY,
  parents int[]     NOT NULL,
  labels  numeric[] NOT NULL
);

INSERT INTO trees VALUES
(1, [NULL,1,2,2,1,5],
    [3.3,1.4,5.0,1.3,1.6,1.5]),
(2, [3,3,NULL,3,2],
    [0.4,0.4,0.2,0.1,7.0]);
