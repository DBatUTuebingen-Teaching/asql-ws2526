CREATE OR REPLACE TABLE input(
  stp  INT PRIMARY KEY,
  dir  INT NOT NULL CHECK (abs(dir) = 1),
  clks INT NOT NULL CHECK (clks >= 0)
);

INSERT INTO input
  -- /!\ Your solution for (a) here!
  ;
