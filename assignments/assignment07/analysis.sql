DROP TYPE IF EXISTS result;
DROP TABLE IF EXISTS analysis;

-- Define result as type alias for numeric(3,1).
CREATE TYPE result AS numeric(3,1);

CREATE TABLE analysis (
  dataset char(1) NOT NULL,
  x       numeric NOT NULL,
  y       numeric NOT NULL
);

COPY analysis FROM 'analysis-data.csv' WITH (FORMAT csv, HEADER TRUE);
