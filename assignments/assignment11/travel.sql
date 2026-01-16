DROP TABLE IF EXISTS cars;
DROP TABLE IF EXISTS roads;
DROP TABLE IF EXISTS cities CASCADE;

-- Each city has a name as its primary key and an indicator if a city provides refueling.
-- If "charger" is 1, the city provides a refueling station. Otherwise, it does not.
CREATE TABLE cities (
  city TEXT PRIMARY KEY,
  charger BOOLEAN
);

-- The roads connect two cities from the city "here" to the city "there" with a distance of "dist".
-- Each distance unit costs one unit of charge when traveled.
CREATE TABLE roads (
  here  TEXT REFERENCES cities(city),
  dist  INTEGER,
  there TEXT REFERENCES cities(city),
  PRIMARY KEY(here, dist, there)
);

CREATE TABLE cars (
  driver TEXT,
  "start" TEXT REFERENCES cities(city),
  "end"   TEXT REFERENCES cities(city),
  max_battery    INTEGER,
  PRIMARY KEY(driver,"start","end")
);

INSERT INTO cities VALUES
  ('Koeln',    TRUE ),
  ('K.-Lautern',  FALSE),
  ('Darmstadt',       TRUE ),
  ('Wuerzburg',       TRUE ),
  ('Mannheim',        FALSE),
  ('Heidelberg',      TRUE ),
  ('Karlsruhe',       FALSE),
  ('Freiburg',        TRUE ),
  ('Konstanz',        TRUE ),
  ('Tuebingen',       FALSE),
  ('Stuttgart',       TRUE ),
  ('Lindau', FALSE),
  ('Biberach',        TRUE ),
  ('Ulm',             TRUE ),
  ('Erlangen',        FALSE),
  ('Nuernberg',       TRUE ),
  ('Augsburg',        FALSE),
  ('Muenchen',        TRUE ),
  ('Rosenheim',       FALSE),
  ('Landshut',        FALSE),
  ('Passau',          FALSE),
  ('Laufen',          FALSE),
  ('Buggingen',       FALSE);

INSERT INTO roads VALUES
  ('Koeln',    40,  'K.-Lautern' ),
  ('Koeln',    160, 'Freiburg'       ),
  ('Koeln',    120, 'Karlsruhe'      ),
  ('K.-Lautern',  60,  'Darmstadt'      ),
  ('K.-Lautern',  30,  'Mannheim'       ),
  ('Mannheim',        30,  'Darmstadt'      ),
  ('Mannheim',        40,  'Heidelberg'     ),
  ('Darmstadt',       90,  'Wuerzburg'      ),
  ('Heidelberg',      90,  'Wuerzburg'      ),
  ('Heidelberg',      30,  'Karlsruhe'      ),
  ('Wuerzburg',       70,  'Erlangen'       ),
  ('Karlsruhe',       70,  'Stuttgart'      ),
  ('Buggingen',       10,  'Laufen'         ),
  ('Laufen',          20,  'Freiburg'       ),
  ('Freiburg',        120, 'Karlsruhe'      ),
  ('Freiburg',        130, 'Tuebingen'      ),
  ('Freiburg',        120, 'Stuttgart'      ),
  ('Freiburg',        100, 'Konstanz'       ),
  ('Konstanz',        30,  'Lindau'),
  ('Tuebingen',       120, 'Konstanz'       ),
  ('Tuebingen',       30,  'Stuttgart'      ),
  ('Stuttgart',       60,  'Ulm'            ),
  ('Lindau', 60,  'Biberach'       ),
  ('Biberach',        40,  'Ulm'            ),
  ('Ulm',             150, 'Erlangen'       ),
  ('Ulm',             40,  'Augsburg'       ),
  ('Erlangen',        120,  'Nuernberg'      ),
  ('Augsburg',        70,  'Nuernberg'      ),
  ('Augsburg',        50,  'Muenchen'       ),
  ('Nuernberg',       100, 'Landshut'       ),
  ('Nuernberg',       110, 'Muenchen'       ),
  ('Muenchen',        70,  'Rosenheim'      ),
  ('Muenchen',        40,  'Landshut'       ),
  ('Landshut',        90,  'Passau'         ),
  ('Landshut',        80,  'Passau'         ),
  ('Rosenheim',       110, 'Passau'         );

INSERT INTO cars VALUES
  ('Nils & Raphael', 'Koeln', 'Wuerzburg', 200),
  ('Nicolas', 'Freiburg',     'Lindau', 20),
  ('Timo', 'Landshut',     'Passau',    100),
  ('Maren', 'Buggingen',    'Tuebingen',    250),
  ('Simion', 'Freiburg',    'Ulm', 100);

