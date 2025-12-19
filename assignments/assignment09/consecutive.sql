DROP TABLE IF EXISTS work;

CREATE TABLE work (
  emp_id integer,
  login  date
);

INSERT INTO work VALUES
(2,'2016-04-06'), (4,'2016-04-06'),
(2,'2016-04-06'), (4,'2016-04-07'),
(2,'2016-04-07'), (5,'2016-04-07'),
(2,'2016-04-10'), (5,'2016-04-08'),
(2,'2016-04-11'), (5,'2016-04-09');
