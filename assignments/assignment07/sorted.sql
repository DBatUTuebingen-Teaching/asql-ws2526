DROP SEQUENCE IF EXISTS serial CASCADE;
DROP TABLE IF EXISTS lists;

CREATE SEQUENCE serial START 1;

CREATE TABLE lists (
  id  int   DEFAULT nextval('serial') PRIMARY KEY,
  lst int[] CHECK (len(lst) > 0)
);

INSERT INTO lists(lst) VALUES
  ([1,2,3,5,6]),
  ([4,3]),
  ([7,6,9]),
  ([2,2]);
