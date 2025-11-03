DROP TABLE IF EXISTS A;
CREATE TABLE A (
  row int,
  col int,
  val int,
  PRIMARY KEY(row, col));

DROP TABLE IF EXISTS B;
-- does not copy keys, contraints etc.
CREATE TABLE B AS TABLE A LIMIT 0;
-- add keys/constraints manually:
ALTER TABLE B
ADD PRIMARY KEY (row, col);

-- (a)
INSERT INTO A VALUES
(1,1,1), (1,2,2),
(2,1,3), (2,2,4);

INSERT INTO B VALUES
(1,1,1), (1,2,2), (1,3,1),
(2,1,2), (2,2,1), (2,3,2);


-- (b)
DELETE FROM A;
DELETE FROM B;

INSERT INTO A VALUES
(1,1,1), (1,2,3),
                  (2,3,7);

INSERT INTO B VALUES
(1,1,1),          (1,3,8 ),
(2,1,1), (2,2,1), (2,3,10),
(3,1,3), (3,2,6);
