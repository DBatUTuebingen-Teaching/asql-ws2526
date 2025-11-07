DROP TABLE IF EXISTS production;
CREATE TABLE production (
  item       char(20) NOT NULL,
  step       int      NOT NULL,
  completion timestamp,         -- NULL means incomplete
  PRIMARY KEY (item, step));

INSERT INTO production VALUES
('TIE'  , 1, '1977-03-02 04:12:00'),
('AT-AT', 1, '1978-01-03 14:12:00'),
('DS II', 1,  NULL),
('TIE'  , 2, '1977-12-29 05:55:00'),
('AT-AT', 2,  NULL),
('DS II', 2, '1979-05-26 20:05:00'),
('DS II', 3, '1979-04-04 17:12:00');
