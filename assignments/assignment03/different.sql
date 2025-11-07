-- Q1
SELECT   r.a, count(*) AS c
FROM     r AS r
WHERE    r.b <> 3
GROUP BY r.a;

-- Q2
SELECT   r.a, count(*) AS c
FROM     r AS r
GROUP BY r.a
HAVING   bool_and(r.b <> 3);
