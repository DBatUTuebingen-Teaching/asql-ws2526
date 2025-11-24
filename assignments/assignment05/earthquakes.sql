INSTALL json;
LOAD json;

DROP TABLE IF EXISTS raw_data;
DROP TABLE IF EXISTS earthquakes;

CREATE TABLE earthquakes (
  title text,
  quake json
);

-- Hint: You must either open DuckDB in the directory containing
-- earthquakes.json or change the path in read_json_objects.
INSERT INTO earthquakes(title,quake)
SELECT j->'properties'->>'title' AS title, j AS quake
FROM read_json_objects('earthquakes.json') AS _(j);

CREATE MACRO haversine(lat_p1, lon_p1, lat_p2, lon_p2) AS
2 * 6371000 * asin(sqrt(sin(radians(lat_p2 - lat_p1) / 2) ^ 2 +
                        cos(radians(lat_p1)) *
                        cos(radians(lat_p2)) *
                        sin(radians(lon_p2 - lon_p1) / 2) ^ 2));
