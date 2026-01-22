DROP TABLE IF EXISTS heat;

-- 2D heat map, heat at point (x,y): z(x,y)
CREATE TABLE heat (
  x int            CHECK (x >  0), -- 2D location (x,y)
  y int            CHECK (y >  0),
  h float NOT NULL CHECK (h >= 0), -- heat at (x,y)
  PRIMARY KEY (x,y)
);

-- Sample heat map (initial state)
INSERT INTO heat(x,y,h) VALUES
  (1,1,10), (2,1, 0), (3,1, 0),
  (1,2, 0), (2,2, 0), (3,2, 0),
  (1,3, 0), (2,3, 0), (3,3, 0);

-- c: conductivity (speed of the simulation ∈ (0,1))
CREATE OR REPLACE MACRO c() AS 0.1;

-- n: # of iteration steps
CREATE OR REPLACE MACRO n() AS 6;


CREATE OR REPLACE VIEW simulate AS (
  -- Your solution goes here!
);

-- Resulting heat map (aggregated only to render a 2D representation)
SELECT s.y, list(s.h :: numeric(4, 1) ORDER BY s.x) AS heatmap
FROM   simulate AS s
GROUP BY s.y
ORDER BY s.y;

-- for n() = 6, the result should look like this:
-- ┌───────┬─────────────────┐
-- │   y   │     heatmap     │
-- │ int32 │ decimal(4,1)[]  │
-- ├───────┼─────────────────┤
-- │     1 │ [0.9, 0.7, 0.2] │
-- │     2 │ [0.7, 0.5, 0.1] │
-- │     3 │ [0.2, 0.1, 0.0] │
-- └───────┴─────────────────┘
