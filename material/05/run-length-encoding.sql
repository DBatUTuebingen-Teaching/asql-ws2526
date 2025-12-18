-- Run-length encoding (compression) of pixel images


-- Sample input image
--
DROP TABLE IF EXISTS input;
CREATE TEMPORARY TABLE input (
  y      int,
  pixels text NOT NULL
);

-- pixels.txt contains a sample image:
-- ░▉▉░░░▉▉░░░▉░░░
-- ▉░░▉░▉░░▉░░▉░░░
-- ▉░░░░▉░░▉░░▉░░░
-- ░▉▉░░▉░░▉░░▉░░░
-- ░░░▉░▉░▉▉░░▉░░░
-- ▉░░▉░▉░░▉░░▉░░░
-- ░▉▉░░░▉▉░▉░▉▉▉▉
CREATE OR REPLACE MACRO image() AS '/Users/grust/AdvancedSQL/slides/Week05/live/pixels.txt';

INSERT INTO input(y,pixels)
  SELECT rows.y, rows.pixels
  FROM   unnest((SELECT string_split(txt.content[:-2], E'\n')
                 FROM   read_text(image()) AS txt))
           WITH ORDINALITY AS rows(pixels,y);

TABLE input
ORDER BY y;

-- (x,y,color) representation of image to encode
--
DROP TYPE IF EXISTS color CASCADE;
CREATE TYPE color AS ENUM ('undefined', '░', '▉');

DROP TABLE IF EXISTS original;
CREATE TABLE original (
  x     int   NOT NULL,
  y     int   NOT NULL,
  pixel color NOT NULL,
  PRIMARY KEY (x,y)
);

-- Load image from sample input
INSERT INTO original(x,y,pixel)
  SELECT col.x, row.y, col.pixel :: color
  FROM   input AS row,
         LATERAL unnest(string_split(row.pixels, '')) WITH ORDINALITY AS col(pixel,x);

-- 1 row ≡ 1 pixel
TABLE original
ORDER BY y, x;

-----------------------------------------------------------------------
-- Run-length encoding
--

DROP TABLE IF EXISTS encoding;
CREATE TEMPORARY TABLE encoding AS -- save result for later decoding

WITH
changes(x,y,pixel,"change?") AS (
  SELECT o.x, o.y, o.pixel,
         o.pixel <> lag(o.pixel, 1, 'undefined') OVER byrow AS "change?"
  FROM   original AS o
  WINDOW byrow AS (ORDER BY o.y, o.x)
                -- └───────┬───────┘
                -- scans image row-by-row
),
runs(x,y,pixel,run) AS (
  SELECT c.x, c.y, c.pixel,
         sum(c."change?" :: int) OVER byrow AS run
         --  └────────┬───────┘
         --  true → 1, false → 0
  FROM   changes AS c
  WINDOW byrow AS (ORDER BY c.y, c.x) -- default: RANGE FROM UNBOUNDED PRECEDING TO CURRENT ROW ⇒ SUM scan
),
encoding(run,length,pixel) AS (
  SELECT r.run, count(*) AS length, r.pixel
  FROM   runs AS r
  GROUP BY r.run, r.pixel
               -- └──┬──┘
               -- does not affect grouping due to FD run -> pixel (all pixels in a run have the same color)
  ORDER BY r.run
)
-- 1 row ≡ 1 run
TABLE encoding;

-----------------------------------------------------------------------
-- Decoding

DROP TABLE IF EXISTS decoding;
CREATE TEMPORARY TABLE decoding AS -- save result for comparison with original image

WITH dimension(width) AS (
  SELECT max(o.x) AS width
  FROM   original AS o
),
expansion(pos,pixel) AS (
  SELECT count(*) OVER (ORDER BY e.run, p.nth) - 1 AS pos, e.pixel  -- alternative: row_number()
  FROM   encoding AS e,
         LATERAL generate_series(1, e.length) AS p(nth)
),
decoding(x,y,pixel) AS (               -- ↓ integer division
  SELECT e.pos % d.width + 1 AS x, e.pos // d.width + 1 AS y, e.pixel
  FROM   expansion AS e, dimension AS d
  ORDER BY y, x
)
TABLE decoding;


-- If original and decoded image are identical,
-- this should yield no rows:
TABLE original EXCEPT TABLE decoding
  UNION
TABLE decoding EXCEPT TABLE original;


-- Output decoded image in 2D format:
SELECT d.y, string_agg(d.pixel :: text, '' ORDER BY d.x) AS pixels
FROM   decoding AS d
GROUP BY d.y
ORDER BY d.y;
