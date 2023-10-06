SHOW DATABASES;
SHOW VARIABLES LIKE '%character%';

CREATE DATABASE dbtest1;

USE dbtest1;

CREATE TABLE emp1(id INT, lname VARCHAR(25));

SELECT * FROM emp1;

INSERT INTO emp1(id, lname) VALUES(1, '小明'), (2, '小康');

SHOW CREATE TABLE emp1;

SHOW CHARSET;

SHOW CREATE DATABASE dbtest1;

ALTER DATABASE dbtest1 DEFAULT CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

SHOW TABLE STATUS FROM dbtest1 LIKE '%emp1';

ALTER TABLE emp1 DEFAULT CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

SHOW VARIABLES LIKE '%lower_case_table_names%';

SELECT * FROM emp1;
SELECT @@global.sql_mode


