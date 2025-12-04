-- SQL implementation of the ACM ICPC 2007 South American Regional Task
-- "Finding Seats"


-- Demonstrates:
-- - LATERAL
-- - text-to-array functions (string_split())
-- - unnest() WITH ORDINALITY
-- - WITH (CTEs)

WITH
input(cinema,K) AS (
  -- ACM ICPC problem instances (pick one)
  -- ➊
  -- ...XX
  -- .X.XX
  -- XX...
  -- VALUES (E'...XX\n.X.XX\nXX...', 5)
  -- ➋ (available in text file cinema.txt)
  -- ..X.X.
  -- .XXX..
  -- .XX.X.
  -- .XXX.X
  -- .XX.XX
  SELECT txt.content[:-2] AS cinema, 6 AS K  -- [:-2] removes trailing newline
  FROM   read_text('cinema.txt') AS txt
),
-- "Parse" ASCII seat map into table (row, col, taken?)
seats(row, col, "taken?") AS (
	SELECT  row.pos AS row, col.pos AS col, col.x = 'X' AS "taken?"
	FROM    input AS i,
	LATERAL unnest(string_split(i.cinema, E'\n')) WITH ORDINALITY AS row(xs,pos),
  LATERAL unnest(string_split(row.xs, ''))      WITH ORDINALITY AS col(x,pos)
),
rects(row, col, width, height) AS (
  SELECT nw.row, nw.col,
         se.col - nw.col + 1 AS width,
         se.row - nw.row + 1 AS height
  FROM   input AS i, seats AS nw, seats AS se
  WHERE  i.K <=
         (SELECT count(*) FILTER (WHERE NOT s."taken?")      -- # of free seats in the
          FROM   seats AS s                                  -- current rectangle of seats
          WHERE  s.row BETWEEN nw.row AND se.row             -- BETWEEN implies: nw.row ⩽ se.row
          AND    s.col BETWEEN nw.col AND se.col)            --                  nw.col ⩽ se.col
)
-- Extract a rectangle with minimal area
SELECT  arg_min(r, r.width * r.height) AS booking
FROM    rects AS r;
