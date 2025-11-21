INSTALL json;
LOAD json;

DROP TABLE IF EXISTS raw_data;
DROP TABLE IF EXISTS earthquakes;

CREATE TABLE raw_data (
  "data" json
);

INSERT INTO raw_data
SELECT a.data
FROM read_json('earthquakes.json',
               format = 'unstructured',
               records = false,
               columns = {data: 'json'}
              ) AS a;

CREATE TABLE earthquakes (
  title text,
  quake json
);

INSERT INTO earthquakes(title,quake)
SELECT j->'properties'->>'title' AS title, j AS quake
FROM raw_data r, LATERAL unnest(r.data->'$.features[*]') AS _(j);

CREATE MACRO haversine(lat_p1, lon_p1, lat_p2, lon_p2) AS
2 * 6371000 * asin(sqrt(sin(radians(lat_p2 - lat_p1) / 2) ^ 2 +
                        cos(radians(lat_p1)) *
                        cos(radians(lat_p2)) *
                        sin(radians(lon_p2 - lon_p1) / 2) ^ 2));
