USE atguigudb;
SELECT employee_id ,last_name , salary * 12 AS "ANNNUAL SALARY" FROM employees;
SELECT employee_id ,last_name , salary * 12 * (1 + IFNULL(commission_pct, 0)) AS "ANNNUAL SALARY" FROM employees;
SELECT DISTINCT job_id FROM employees;
SELECT last_name, department_id FROM employees WHERE employee_id = 176;

DESCRIBE departments ;
DESC departments ;
SELECT * FROM departments;

SELECT NULL IS NULL, ISNULL(NULL), ISNULL('a'), 1 IS NULL, '' IS NULL;

SELECT employee_id, last_name, salary, commission_pct FROM employees WHERE commission_pct <=> NULL ;

SELECT employee_id, last_name, salary, commission_pct FROM employees WHERE commission_pct IS NULL ;

SELECT employee_id, last_name, salary, commission_pct FROM employees WHERE NOT commission_pct <=> NULL ;

SELECT employee_id, last_name, salary FROM employees WHERE salary BETWEEN 6000 AND 10000;

SELECT last_name FROM employees WHERE last_name LIKE '%a%';

SELECT last_name FROM employees WHERE last_name LIKE '_a%';

SELECT last_name,salary, department_id FROM employees 
WHERE department_id = 50 AND salary  > 6000;

SELECT last_name,salary, department_id FROM employees 
WHERE commission_pct <=> NULL ;

SELECT last_name,salary,commission_pct, department_id FROM employees 
WHERE NOT commission_pct <=> NULL ;

SELECT employee_id, LAST_name, salary FROM employees ORDER BY salary DESC ;

SELECT
	employee_id,
	salary,
	salary * 12 annual_sal
FROM
	employees
ORDER BY
	annual_sal;

/* where  中不能使用别名
 * SELECT employee_id, salary, salary *12 annual_sal 
FROM employees
WHERE annual_sal > 81600;
*/

SELECT employee_id, last_name, department_id, salary
FROM employees
ORDER BY department_id DESC , salary ASC;

SELECT employee_id, last_name
FROM employees
LIMIT 0,20;

DESC employees;

DESC locations ;

DESC departments ;

SELECT employee_id, department_name FROM 
employees, departments;

SELECT * FROM employees;

SELECT 2889 / 107 FROM DUAL;

SELECT * FROM departments ;

SELECT employees.employee_id, departments.department_name,employees.department_id 
FROM 
employees, departments
WHERE employees.department_id = departments.department_id ;

SELECT e.employee_id, d.department_name,e.department_id 
FROM 
employees e, departments d
WHERE e.department_id = d.department_id ;

SELECT emp.employee_id , emp.last_name ,dept.department_name , locat.city 
FROM employees emp, departments dept, locations locat
WHERE emp.department_id = dept.department_id AND dept.location_id = locat.location_id;

SELECT * FROM job_grades;

SELECT e.last_name, e.salary, jg.grade_level
FROM employees e , job_grades jg 
WHERE e.salary BETWEEN jg.lowest_sal AND jg.highest_sal;

SELECT e.employee_id, e.last_name, e2.employee_id, e2.last_name
FROM employees e , employees e2 
WHERE e.manager_id = e2.employee_id;

# 外链接
/* SQL 92 ,mysql 不支持， oracle支持
 * SELECT e.employee_id, d.department_name,e.department_id 
FROM employees e, departments dÏ
WHERE e.department_id = d.department_id(+) ;
 */

# SQL99  join on 内连接
SELECT e.employee_id, d.department_name, e.department_id 
FROM employees e 
JOIN departments d
ON e.department_id = d.department_id;

SELECT e.employee_id, d.department_name, e.department_id 
FROM employees e 
INNER JOIN departments d
ON e.department_id = d.department_id;

SELECT emp.employee_id , emp.last_name ,dept.department_name , locat.city 
FROM employees emp JOIN  departments dept ON emp.department_id = dept.department_id JOIN  locations locat
ON  dept.location_id = locat.location_id;

# SQL99 join ... on ... 外连接
# 左外连接 （outer 可以省略）
SELECT e.employee_id, e.last_name , d.department_name, e.department_id 
FROM employees e 
LEFT OUTER JOIN departments d
ON e.department_id = d.department_id;

# 右外连接 （outer 可以省略）
SELECT e.employee_id, e.last_name , d.department_name, e.department_id 
FROM employees e 
RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id;

# 满外连接 full outer join  mysql 不支持，  oracle 支持
/*
 * SELECT e.employee_id, e.last_name , d.department_name, e.department_id 
FROM employees e 
FULL OUTER JOIN departments d
ON e.department_id = d.department_id;
*/

# union 和 union all 
# union 会执行去重操作
# union all 不会执行去重操作

# 9. 7种 union 的实现

# 中图
SELECT e.employee_id, d.department_name, e.department_id 
FROM employees e 
INNER JOIN departments d
ON e.department_id = d.department_id;

#  左上图: 左外连接
SELECT e.employee_id, d.department_name, e.department_id 
FROM employees e 
LEFT OUTER JOIN departments d
ON e.department_id = d.department_id;

# 右上图：右外连接
SELECT e.employee_id, d.department_name, e.department_id 
FROM employees e 
RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id;

# 左中图：
SELECT e.employee_id, d.department_name, e.department_id 
FROM employees e 
LEFT OUTER JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_id IS NULL ;

# 右中图:
SELECT e.employee_id, d.department_name, e.department_id 
FROM employees e 
RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id
WHERE e.department_id IS NULL;

# 左下图：满外连接
# 方式1: 左上图 union all 右中图
SELECT e.employee_id, d.department_name, e.department_id 
FROM employees e 
LEFT OUTER JOIN departments d
ON e.department_id = d.department_id
UNION ALL 
SELECT e.employee_id, d.department_name, e.department_id 
FROM employees e 
RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id
WHERE e.department_id IS NULL;

# 方式2: 右上图 union all 左中图
SELECT e.employee_id, d.department_name, e.department_id 
FROM employees e 
RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id
UNION ALL 
SELECT e.employee_id, d.department_name, e.department_id 
FROM employees e 
LEFT OUTER JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_id IS NULL ;

# 右下图：
SELECT e.employee_id, d.department_name, e.department_id 
FROM employees e 
LEFT OUTER JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_id IS NULL
UNION ALL 
SELECT e.employee_id, d.department_name, e.department_id 
FROM employees e 
RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id
WHERE e.department_id IS NULL;

SELECT * FROM employees;

SELECT COUNT(employee_id) FROM employees;

SELECT COUNT(department_id) FROM departments;

SELECT last_name,department_name FROM employees JOIN departments;

SELECT last_name, department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id;

SELECT e.last_name, d.department_id, d.department_name 
FROM employees e LEFT JOIN departments d 
ON e.department_id = d.department_id; 

DESC locations ;

DESC departments ;

DESC jobs ;

SELECT * FROM employees e ;

SELECT e.job_id, d.location_id, e.department_id 
FROM employees e , departments d 
WHERE e.department_id = d.department_id 
AND e.department_id = 90;

SELECT e.last_name, d.department_name, d.location_id, l.city, e.commission_pct ,e.salary 
FROM employees e LEFT JOIN departments d 
ON e.department_id = d.department_id LEFT JOIN 
locations l ON d.location_id = l.location_id
WHERE e.commission_pct IS NOT NULL ;

SELECT * FROM employees e 
WHERE e.department_id =90;

SELECT count('333') FROM employees e 
WHERE e.commission_pct IS NOT NULL ;

SELECT e.last_name, e.job_id, d.department_id, d.department_name, l.city
FROM employees e , departments d , locations l 
WHERE e.department_id = d.department_id AND d.location_id = l.location_id AND l.city = 'Toronto'

SELECT * FROM locations l ;

SELECT d.department_name, l.city, e.last_name, j.job_title,
e.salary FROM employees e JOIN departments d ON e.department_id = d.department_id 
JOIN jobs j ON j.job_id = e.job_id JOIN locations l ON d.location_id = l.location_id 
WHERE d.department_name = 'Executive'

SELECT  e.last_name "emplouees", e.employee_id "Emp#", e2.last_name "manager" , e2.employee_id  "Mgr#"
FROM employees e LEFT OUTER JOIN employees e2 
ON e.manager_id = e2.employee_id;

SELECT d.department_name, d.department_id FROM
departments d LEFT OUTER JOIN employees e
ON e.department_id = d.department_id
WHERE e.department_id IS NULL ;

SELECT d.department_name, d.department_id FROM
 employees e RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id
WHERE e.department_id IS NULL ;

SELECT l.city, l.location_id FROM 
departments d RIGHT OUTER JOIN 
locations l ON d.location_id = l.location_id
WHERE d.location_id IS NULL ;

SHOW DATABASES;
USE atguigudb;

SELECT l.city, l.location_id FROM 
locations l LEFT OUTER JOIN 
departments d ON l.location_id = d.location_id 
WHERE d.location_id IS NULL;

SELECT * FROM employees e 
JOIN departments d 
ON e.department_id = d.department_id 
WHERE d.department_name IN ('Sales','IT');

CREATE TABLE `t_dept` (
`id` INT(11) NOT NULL AUTO_INCREMENT,
`deptName` VARCHAR(30) DEFAULT NULL,
`address` VARCHAR(40) DEFAULT NULL,
PRIMARY KEY (id)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

SHOW tables;

DESC t_dept ;

CREATE TABLE `t_emp` (
`id` INT(11) NOT NULL AUTO_INCREMENT,
`name` VARCHAR(20) DEFAULT NULL,
`age` INT(3) DEFAULT NULL,
`deptId` INT(11) DEFAULT NULL,
empno int not null,
PRIMARY KEY (id),
KEY idx_dept_id (deptId)
#CONSTRAINT `fk_dept_id` FOREIGN KEY (`deptId`) REFERENCES `t_dept` (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

SELECT * FROM t_dept td ;

SELECT * FROM t_emp te ;

INSERT INTO t_dept(deptName,address) VALUES('华山','华山');
INSERT INTO t_dept(deptName,address) VALUES('丐帮','洛阳');
INSERT INTO t_dept(deptName,address) VALUES('峨眉','峨眉山');
INSERT INTO t_dept(deptName,address) VALUES('武当','武当山');
INSERT INTO t_dept(deptName,address) VALUES('明教','光明顶');
INSERT INTO t_dept(deptName,address) VALUES('少林','少林寺');
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('风清扬',90,1,100001);
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('岳不群',50,1,100002);
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('令狐冲',24,1,100003);
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('洪七公',70,2,100004);
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('乔峰',35,2,100005);
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('灭绝师太',70,3,100006);
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('周芷若',20,3,100007);
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('张三丰',100,4,100008);
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('张无忌',25,5,100009);
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('韦小宝',18,null,100010);

SELECT * FROM t_emp te
 LEFT OUTER JOIN 
t_dept td ON te.deptId = td.id 
WHERE td.deptName IS NOT NULL ;

SELECT te.name, td.deptName FROM 
t_emp te LEFT OUTER JOIN 
t_dept td ON te.deptId = td.id;

SELECT deptName, name FROM 
t_emp te LEFT JOIN t_dept td 
ON te.deptId = td.id 
WHERE te.deptId IS NULL ;

SELECT deptName FROM 
t_emp te RIGHT JOIN t_dept td 
ON td.id = te.deptId
WHERE deptId IS NULL ;

SHOW tables;
DESC t_emp;

SELECT name, deptName
FROM t_emp te LEFT OUTER JOIN 
t_dept td ON te.deptId = td.id 
UNION SELECT name, deptName
FROM t_emp te RIGHT OUTER JOIN 
t_dept td ON te.deptId = td.id;

SELECT te.name, td.deptName
FROM t_emp te LEFT OUTER JOIN 
t_dept td ON te.deptId = td.id 
WHERE td.id IS NULL
UNION ALL SELECT name, deptName
FROM t_emp te RIGHT OUTER JOIN 
t_dept td ON te.deptId = td.id 
WHERE te.deptId IS NULL;

SELECT RADIANS(30),RADIANS(60),RADIANS(90),DEGREES(2*PI()),DEGREES(RADIANS(90))
FROM DUAL;

/* 
 * RADIANS(x)：将角度转化为弧度，其中，参数x为角度值
 * DEGREES(x)：将弧度转化为角度，其中，参数x为弧度值
 * 
 * */

SELECT SIN(RADIANS(30)), DEGREES(ASIN(0.5)), TAN(RADIANS(45)), DEGREES(ATAN(1))  FROM DUAL;

#  指数和对数
SELECT POW(2,5), POWER(2,6), EXP(1) FROM DUAL; 

SELECT LN(EXP(1)), LOG10(10), LOG2(2) FROM DUAL; 




































