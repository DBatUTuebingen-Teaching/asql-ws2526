DROP TABLE map;
CREATE TABLE map (
  x   integer NOT NULL PRIMARY KEY,  -- location
  alt integer NOT NULL               -- altidude at location
);
DELETE FROM map;

INSERT INTO map(x, alt) VALUES (  0, 200);
INSERT INTO map(x, alt) VALUES ( 10, 200);
INSERT INTO map(x, alt) VALUES ( 20, 200);
INSERT INTO map(x, alt) VALUES ( 30, 300);
INSERT INTO map(x, alt) VALUES ( 40, 400);
INSERT INTO map(x, alt) VALUES ( 50, 400);
INSERT INTO map(x, alt) VALUES ( 60, 400);
INSERT INTO map(x, alt) VALUES ( 70, 200);
INSERT INTO map(x, alt) VALUES ( 80, 400);
INSERT INTO map(x, alt) VALUES ( 90, 700);
INSERT INTO map(x, alt) VALUES (100, 800);
INSERT INTO map(x, alt) VALUES (110, 700);
INSERT INTO map(x, alt) VALUES (120, 500);

SELECT *
FROM map MATCH_RECOGNIZE (
  ORDER BY x
  MEASURES FIRST(x,1) AS x,               -- second row in match
           MATCH_NUMBER() AS feature,
           CLASSIFIER() as slope
  ONE ROW PER MATCH
  AFTER MATCH SKIP TO NEXT ROW
  PATTERN (((DOWN DOWN|DOWN EVEN|UP DOWN|EVEN DOWN) (UP UP|UP EVEN|UP DOWN|EVEN UP) | (UP UP|UP EVEN|DOWN UP|EVEN UP) (DOWN DOWN|DOWN EVEN|DOWN UP|EVEN DOWN)))
  DEFINE
        UP   AS UP.alt   > PREV(UP.alt),
        DOWN AS DOWN.alt < PREV(DOWN.alt),
        EVEN AS EVEN.alt = PREV(EVEN.alt)
) MR

-- Result:
--
-- X   | FEATURE | SLOPE
-- 50  | 1       | DOWN
-- 70  | 2       | UP
-- 100 | 3       | DOWN
