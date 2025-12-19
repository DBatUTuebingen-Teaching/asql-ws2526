DROP TYPE IF EXISTS waypoint CASCADE;
DROP MACRO IF EXISTS distance;
DROP SEQUENCE IF EXISTS serial;
DROP TABLE IF EXISTS tour;

CREATE TYPE waypoint AS STRUCT (
  lat float,
  lon float
);

CREATE SEQUENCE serial START 1;

CREATE TABLE tour (
  id        int      PRIMARY KEY,
  waypoint  waypoint,
  elevation float
);

-- Cycling tour from Rottenburg to WSI
-- (tour data exported from GPSies.com, export format "SQL Inserts Track")
INSERT INTO tour(id, waypoint, elevation)
SELECT id, (lat, lon)::waypoint, elevation
FROM 'tour.csv';

-- earth distance of points p1 and p2
CREATE OR REPLACE MACRO distance(p1, p2) AS
(6378000.0 * -- earth radius [m]
  acos(cos(radians(p1.lat)) * cos(radians(p1.lon)) * cos(radians(p2.lat)) * cos(radians(p2.lon)) +
       cos(radians(p1.lat)) * sin(radians(p1.lon)) * cos(radians(p2.lat)) * sin(radians(p2.lon)) +
       sin(radians(p1.lat)) * sin(radians(p2.lat))
      )) :: numeric(10,2);
