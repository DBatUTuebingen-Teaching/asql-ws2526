DROP TABLE IF EXISTS parts;
DROP TABLE IF EXISTS products;

CREATE TABLE products (
  id   int  PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE parts (
  prod  int NOT NULL REFERENCES products(id),
  sub   int NOT NULL REFERENCES products(id),
  quant int CHECK (quant > 0)
);

INSERT INTO products VALUES
(1, 'mainboard'),
(2, 'GPU'),
(3, 'memory'),
(4, 'HDD'),
(5, 'SSD'),
(6, 'CPU'),
(7, 'core'),
(8, 'fan'),
(9, 'blade');

INSERT INTO parts VALUES
(1,2,2),(1,3,4),(1,4,1), (1,5,2),(1,6,1),
(2,8,3),
(4,7,8),(4,8,2),
(8,9,4);