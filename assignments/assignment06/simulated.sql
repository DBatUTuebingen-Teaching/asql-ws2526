DROP TABLE IF EXISTS s;
DROP TABLE IF EXISTS t;

CREATE TABLE s (
  lst_id integer PRIMARY KEY,
  lst    text[]
);

INSERT INTO s VALUES
(1, ['a','b','c']),
(2, ['d','d']);

CREATE TABLE t (
  lst_id integer,
  idx    integer,
  val    text,
  PRIMARY KEY(lst_id, idx)
);

INSERT INTO t VALUES
(1,1,'a'),(1,2,'b'),(1,3,'c'),
(2,1,'d'),(2,2,'d');

-- a)
SELECT s.lst[1] AS val
FROM   s AS s
WHERE  s.lst_id = 1;

-- b)
SELECT s.lst_id,
       len(s.lst) AS len
FROM   s AS s;

-- c)
SELECT s.lst_id, a AS val
FROM   s             AS s,
       unnest(s.lst) AS _(a);

-- d)
SELECT s.lst_id,
       s.lst || ['e','f']
FROM   s AS s;

-- e)
TABLE s
  UNION ALL
SELECT new.id                 AS lst_id,
       list_append(s.lst,'g') AS lst
FROM s AS s,
 (
  SELECT MAX(s.lst_id) + 1
  FROM   s AS s
 ) AS new(id)
WHERE s.lst_id = 1;
