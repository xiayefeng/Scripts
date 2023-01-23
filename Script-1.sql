USE atguigudb;

SELECT
    employee_id ,
    last_name ,
    salary * 12 AS "ANNNUAL SALARY"
FROM
    employees;

SELECT
    employee_id ,
    last_name ,
    salary * 12 * (1 + IFNULL(commission_pct, 0)) AS "ANNNUAL SALARY"
FROM
    employees;

SELECT
    DISTINCT job_id
FROM
    employees;

SELECT
    last_name,
    department_id
FROM
    employees
WHERE
    employee_id = 176;

DESCRIBE departments ;

DESC departments ;

SELECT
    *
FROM
    departments;

SELECT
    NULL IS NULL,
    ISNULL(NULL),
    ISNULL('a'),
    1 IS NULL,
    '' IS NULL;

SELECT
    employee_id,
    last_name,
    salary,
    commission_pct
FROM
    employees
WHERE
    commission_pct <=> NULL ;

SELECT
    employee_id,
    last_name,
    salary,
    commission_pct
FROM
    employees
WHERE
    commission_pct IS NULL ;

SELECT
    employee_id,
    last_name,
    salary,
    commission_pct
FROM
    employees
WHERE
    NOT commission_pct <=> NULL ;

SELECT
    employee_id,
    last_name,
    salary
FROM
    employees
WHERE
    salary BETWEEN 6000 AND 10000;

SELECT
    last_name
FROM
    employees
WHERE
    last_name LIKE '%a%';

SELECT
    last_name
FROM
    employees
WHERE
    last_name LIKE '_a%';

SELECT
    last_name,
    salary,
    department_id
FROM
    employees
WHERE
    department_id = 50
    AND salary > 6000;

SELECT
    last_name,
    salary,
    department_id
FROM
    employees
WHERE
    commission_pct <=> NULL ;

SELECT
    last_name,
    salary,
    commission_pct,
    department_id
FROM
    employees
WHERE
    NOT commission_pct <=> NULL ;

SELECT
    employee_id,
    LAST_name,
    salary
FROM
    employees
ORDER BY
    salary DESC ;

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

SELECT
    employee_id,
    last_name,
    department_id,
    salary
FROM
    employees
ORDER BY
    department_id DESC ,
    salary ASC;

SELECT
    employee_id,
    last_name
FROM
    employees
LIMIT 0,
20;

DESC employees;

DESC locations ;

DESC departments ;

SELECT
    employee_id,
    department_name
FROM
    employees,
    departments;

SELECT
    *
FROM
    employees;

SELECT
    2889 / 107
FROM
    DUAL;

SELECT
    *
FROM
    departments ;

SELECT
    employees.employee_id,
    departments.department_name,
    employees.department_id
FROM
    employees,
    departments
WHERE
    employees.department_id = departments.department_id ;

SELECT
    e.employee_id,
    d.department_name,
    e.department_id
FROM
    employees e,
    departments d
WHERE
    e.department_id = d.department_id ;

SELECT
    emp.employee_id ,
    emp.last_name ,
    dept.department_name ,
    locat.city
FROM
    employees emp,
    departments dept,
    locations locat
WHERE
    emp.department_id = dept.department_id
    AND dept.location_id = locat.location_id;

SELECT
    *
FROM
    job_grades;

SELECT
    e.last_name,
    e.salary,
    jg.grade_level
FROM
    employees e ,
    job_grades jg
WHERE
    e.salary BETWEEN jg.lowest_sal AND jg.highest_sal;

SELECT
    e.employee_id,
    e.last_name,
    e2.employee_id,
    e2.last_name
FROM
    employees e ,
    employees e2
WHERE
    e.manager_id = e2.employee_id;
# 外链接
/* SQL 92 ,mysql 不支持， oracle支持
 * SELECT e.employee_id, d.department_name,e.department_id 
FROM employees e, departments dÏ
WHERE e.department_id = d.department_id(+) ;
 */
# SQL99  join on 内连接
SELECT
    e.employee_id,
    d.department_name,
    e.department_id
FROM
    employees e
JOIN departments d
ON
    e.department_id = d.department_id;

SELECT
    e.employee_id,
    d.department_name,
    e.department_id
FROM
    employees e
INNER JOIN departments d
ON
    e.department_id = d.department_id;

SELECT
    emp.employee_id ,
    emp.last_name ,
    dept.department_name ,
    locat.city
FROM
    employees emp
JOIN departments dept ON
    emp.department_id = dept.department_id
JOIN locations locat
ON
    dept.location_id = locat.location_id;
# SQL99 join ... on ... 外连接
# 左外连接 （outer 可以省略）
SELECT
    e.employee_id,
    e.last_name ,
    d.department_name,
    e.department_id
FROM
    employees e
LEFT OUTER JOIN departments d
ON
    e.department_id = d.department_id;
# 右外连接 （outer 可以省略）
SELECT
    e.employee_id,
    e.last_name ,
    d.department_name,
    e.department_id
FROM
    employees e
RIGHT OUTER JOIN departments d
ON
    e.department_id = d.department_id;
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
SELECT
    e.employee_id,
    d.department_name,
    e.department_id
FROM
    employees e
INNER JOIN departments d
ON
    e.department_id = d.department_id;
#  左上图: 左外连接
SELECT
    e.employee_id,
    d.department_name,
    e.department_id
FROM
    employees e
LEFT OUTER JOIN departments d
ON
    e.department_id = d.department_id;
# 右上图：右外连接
SELECT
    e.employee_id,
    d.department_name,
    e.department_id
FROM
    employees e
RIGHT OUTER JOIN departments d
ON
    e.department_id = d.department_id;
# 左中图：
SELECT
    e.employee_id,
    d.department_name,
    e.department_id
FROM
    employees e
LEFT OUTER JOIN departments d
ON
    e.department_id = d.department_id
WHERE
    d.department_id IS NULL ;
# 右中图:
SELECT
    e.employee_id,
    d.department_name,
    e.department_id
FROM
    employees e
RIGHT OUTER JOIN departments d
ON
    e.department_id = d.department_id
WHERE
    e.department_id IS NULL;
# 左下图：满外连接
# 方式1: 左上图 union all 右中图
SELECT
    e.employee_id,
    d.department_name,
    e.department_id
FROM
    employees e
LEFT OUTER JOIN departments d
ON
    e.department_id = d.department_id
UNION ALL 
SELECT
    e.employee_id,
    d.department_name,
    e.department_id
FROM
    employees e
RIGHT OUTER JOIN departments d
ON
    e.department_id = d.department_id
WHERE
    e.department_id IS NULL;
# 方式2: 右上图 union all 左中图
SELECT
    e.employee_id,
    d.department_name,
    e.department_id
FROM
    employees e
RIGHT OUTER JOIN departments d
ON
    e.department_id = d.department_id
UNION ALL 
SELECT
    e.employee_id,
    d.department_name,
    e.department_id
FROM
    employees e
LEFT OUTER JOIN departments d
ON
    e.department_id = d.department_id
WHERE
    d.department_id IS NULL ;
# 右下图：
SELECT
    e.employee_id,
    d.department_name,
    e.department_id
FROM
    employees e
LEFT OUTER JOIN departments d
ON
    e.department_id = d.department_id
WHERE
    d.department_id IS NULL
UNION ALL 
SELECT
    e.employee_id,
    d.department_name,
    e.department_id
FROM
    employees e
RIGHT OUTER JOIN departments d
ON
    e.department_id = d.department_id
WHERE
    e.department_id IS NULL;

SELECT
    *
FROM
    employees;

SELECT
    COUNT(employee_id)
FROM
    employees;

SELECT
    COUNT(department_id)
FROM
    departments;

SELECT
    last_name,
    department_name
FROM
    employees
JOIN departments;

SELECT
    last_name,
    department_name
FROM
    employees,
    departments
WHERE
    employees.department_id = departments.department_id;

SELECT
    e.last_name,
    d.department_id,
    d.department_name
FROM
    employees e
LEFT JOIN departments d 
ON
    e.department_id = d.department_id;

DESC locations ;

DESC departments ;

DESC jobs ;

SELECT
    *
FROM
    employees e ;

SELECT
    e.job_id,
    d.location_id,
    e.department_id
FROM
    employees e ,
    departments d
WHERE
    e.department_id = d.department_id
    AND e.department_id = 90;

SELECT
    e.last_name,
    d.department_name,
    d.location_id,
    l.city,
    e.commission_pct ,
    e.salary
FROM
    employees e
LEFT JOIN departments d 
ON
    e.department_id = d.department_id
LEFT JOIN 
locations l ON
    d.location_id = l.location_id
WHERE
    e.commission_pct IS NOT NULL ;

SELECT
    *
FROM
    employees e
WHERE
    e.department_id = 90;

SELECT
    count('333')
FROM
    employees e
WHERE
    e.commission_pct IS NOT NULL ;

SELECT
    e.last_name,
    e.job_id,
    d.department_id,
    d.department_name,
    l.city
FROM
    employees e ,
    departments d ,
    locations l
WHERE
    e.department_id = d.department_id
    AND d.location_id = l.location_id
    AND l.city = 'Toronto'

SELECT
    *
FROM
    locations l ;

SELECT
    d.department_name,
    l.city,
    e.last_name,
    j.job_title,
    e.salary
FROM
    employees e
JOIN departments d ON
    e.department_id = d.department_id
JOIN jobs j ON
    j.job_id = e.job_id
JOIN locations l ON
    d.location_id = l.location_id
WHERE
    d.department_name = 'Executive'

SELECT
    e.last_name "emplouees",
    e.employee_id "Emp#",
    e2.last_name "manager" ,
    e2.employee_id "Mgr#"
FROM
    employees e
LEFT OUTER JOIN employees e2 
ON
    e.manager_id = e2.employee_id;

SELECT
    d.department_name,
    d.department_id
FROM
    departments d
LEFT OUTER JOIN employees e
ON
    e.department_id = d.department_id
WHERE
    e.department_id IS NULL ;

SELECT
    d.department_name,
    d.department_id
FROM
    employees e
RIGHT OUTER JOIN departments d
ON
    e.department_id = d.department_id
WHERE
    e.department_id IS NULL ;

SELECT
    l.city,
    l.location_id
FROM
    departments d
RIGHT OUTER JOIN 
locations l ON
    d.location_id = l.location_id
WHERE
    d.location_id IS NULL ;

SHOW DATABASES;

USE atguigudb;

SELECT
    l.city,
    l.location_id
FROM
    locations l
LEFT OUTER JOIN 
departments d ON
    l.location_id = d.location_id
WHERE
    d.location_id IS NULL;

SELECT
    *
FROM
    employees e
JOIN departments d 
ON
    e.department_id = d.department_id
WHERE
    d.department_name IN ('Sales', 'IT');

CREATE TABLE `t_dept` (
`id` INT(11) NOT NULL AUTO_INCREMENT,
`deptName` VARCHAR(30) DEFAULT NULL,
`address` VARCHAR(40) DEFAULT NULL,
PRIMARY KEY (id)
) ENGINE = INNODB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

SHOW tables;

DESC t_dept ;

CREATE TABLE `t_emp` (
`id` INT(11) NOT NULL AUTO_INCREMENT,
`name` VARCHAR(20) DEFAULT NULL,
`age` INT(3) DEFAULT NULL,
`deptId` INT(11) DEFAULT NULL,
empno int NOT NULL,
PRIMARY KEY (id),
KEY idx_dept_id (deptId)
#CONSTRAINT `fk_dept_id` FOREIGN KEY (`deptId`) REFERENCES `t_dept` (`id`)
) ENGINE = INNODB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

SELECT
    *
FROM
    t_dept td ;

SELECT
    *
FROM
    t_emp te ;

INSERT
    INTO
    t_dept(deptName,
    address)
VALUES('华山',
'华山');

INSERT
    INTO
    t_dept(deptName,
    address)
VALUES('丐帮',
'洛阳');

INSERT
    INTO
    t_dept(deptName,
    address)
VALUES('峨眉',
'峨眉山');

INSERT
    INTO
    t_dept(deptName,
    address)
VALUES('武当',
'武当山');

INSERT
    INTO
    t_dept(deptName,
    address)
VALUES('明教',
'光明顶');

INSERT
    INTO
    t_dept(deptName,
    address)
VALUES('少林',
'少林寺');

INSERT
    INTO
    t_emp(NAME,
    age,
    deptId,
    empno)
VALUES('风清扬',
90,
1,
100001);

INSERT
    INTO
    t_emp(NAME,
    age,
    deptId,
    empno)
VALUES('岳不群',
50,
1,
100002);

INSERT
    INTO
    t_emp(NAME,
    age,
    deptId,
    empno)
VALUES('令狐冲',
24,
1,
100003);

INSERT
    INTO
    t_emp(NAME,
    age,
    deptId,
    empno)
VALUES('洪七公',
70,
2,
100004);

INSERT
    INTO
    t_emp(NAME,
    age,
    deptId,
    empno)
VALUES('乔峰',
35,
2,
100005);

INSERT
    INTO
    t_emp(NAME,
    age,
    deptId,
    empno)
VALUES('灭绝师太',
70,
3,
100006);

INSERT
    INTO
    t_emp(NAME,
    age,
    deptId,
    empno)
VALUES('周芷若',
20,
3,
100007);

INSERT
    INTO
    t_emp(NAME,
    age,
    deptId,
    empno)
VALUES('张三丰',
100,
4,
100008);

INSERT
    INTO
    t_emp(NAME,
    age,
    deptId,
    empno)
VALUES('张无忌',
25,
5,
100009);

INSERT
    INTO
    t_emp(NAME,
    age,
    deptId,
    empno)
VALUES('韦小宝',
18,
NULL,
100010);

SELECT
    *
FROM
    t_emp te
LEFT OUTER JOIN 
t_dept td ON
    te.deptId = td.id
WHERE
    td.deptName IS NOT NULL ;

SELECT
    te.name,
    td.deptName
FROM
    t_emp te
LEFT OUTER JOIN 
t_dept td ON
    te.deptId = td.id;

SELECT
    deptName,
    name
FROM
    t_emp te
LEFT JOIN t_dept td 
ON
    te.deptId = td.id
WHERE
    te.deptId IS NULL ;

SELECT
    deptName
FROM
    t_emp te
RIGHT JOIN t_dept td 
ON
    td.id = te.deptId
WHERE
    deptId IS NULL ;

SHOW tables;

DESC t_emp;

SELECT
    name,
    deptName
FROM
    t_emp te
LEFT OUTER JOIN 
t_dept td ON
    te.deptId = td.id
UNION
SELECT
    name,
    deptName
FROM
    t_emp te
RIGHT OUTER JOIN 
t_dept td ON
    te.deptId = td.id;

SELECT
    te.name,
    td.deptName
FROM
    t_emp te
LEFT OUTER JOIN 
t_dept td ON
    te.deptId = td.id
WHERE
    td.id IS NULL
UNION ALL
SELECT
    name,
    deptName
FROM
    t_emp te
RIGHT OUTER JOIN 
t_dept td ON
    te.deptId = td.id
WHERE
    te.deptId IS NULL;
-- 2.1 基本函数
/*
 * ABS(x) 返回x的绝对值
   SIGN(X) 返回X的符号。正数返回1，负数返回-1，0返回0
   PI() 返回圆周率的值
   CEIL(x)，CEILING(x) 返回大于或等于某个值的最小整数
   FLOOR(x) 返回小于或等于某个值的最大整数
   LEAST(e1,e2,e3…) 返回列表中的最小值
   GREATEST(e1,e2,e3…) 返回列表中的最大值
   MOD(x,y) 返回X除以Y后的余数
   RAND() 返回0~1的随机值
   RAND(x) 返回0~1的随机值，其中x的值用作种子值，相同的X值会产生相同的随机数
   ROUND(x) 返回一个对x的值进行四舍五入后，最接近于X的整数
   ROUND(x,y) 返回一个对x的值进行四舍五入后最接近X的值，并保留到小数点后面Y位
   TRUNCATE(x,y) 返回数字x截断为y位小数的结果
   SQRT(x) 返回x的平方根。当X的值为负数时，返回NULL
 * 
 * 
 */

SELECT
    RADIANS(30),
    RADIANS(60),
    RADIANS(90),
    DEGREES(2 * PI()),
    DEGREES(RADIANS(90))
FROM
    DUAL;

/* 
 * RADIANS(x)：将角度转化为弧度，其中，参数x为角度值
 * DEGREES(x)：将弧度转化为角度，其中，参数x为弧度值
 * 
 * */

SELECT
    SIN(RADIANS(30)),
    DEGREES(ASIN(0.5)),
    TAN(RADIANS(45)),
    DEGREES(ATAN(1))
FROM
    DUAL;
#  指数和对数
SELECT
    POW(2, 5),
    POWER(2, 6),
    EXP(1)
FROM
    DUAL;

SELECT
    LN(EXP(2)),
    LOG10(10),
    LOG2(2)
FROM
    DUAL;
# 2.5 进制间的转换
/* 
BIN(x) 返回x的二进制编码
HEX(x) 返回x的十六进制编码
OCT(x) 返回x的八进制编码
CONV(x,f1,f2) 返回f1进制数变成f2进制数
*/

SELECT
    BIN(0x16a),
    HEX(16),
    oct(14),
    CONV(22, 10, 8)
FROM
    DUAL;
# 字符串函数
SELECT
    ASCII('ABC'),
    CHAR_LENGTH('hello'),
    CHAR_LENGTH('我们'),
    LENGTH('hello'),
    LENGTH('我梦')
FROM
    DUAL;

SELECT
    e.last_name ,
    CONCAT(e.last_name, ' up is ', e2.last_name)
FROM
    employees e
LEFT JOIN employees e2 
ON
    e.manager_id = e2.employee_id;

SELECT
    CONCAT_WS('-', 'hello', 'world', 'how', 'are', 'you')
FROM
    DUAL;

SELECT
    INSERT
    ('hello',
    2,
    3,
    'aaaa'),
    REPLACE ('hemmo, mm,ddd',
    'mm',
    'll')
FROM
    DUAL;

SELECT
    UPPER('hello'),
    LOWER('jjHHHkkdJ') ,
    LEFT ('hell0',
    2),
    RIGHT ('hello',
    2)
FROM
    DUAL;

SELECT
    LPAD('asdf', 5, '0') ,
    RPAD('assd', 5, '0')
FROM
    DUAL;

SELECT
    CURDATE(),
    CURTIME(),
    NOW(),
    SYSDATE(),
    SYSDATE()+ 0,
    UTC_DATE (),
    UTC_DATE ()+ 0,
    UTC_TIME (),
    UTC_TIME ()+ 0
FROM
    DUAL;

SELECT
    UNIX_TIMESTAMP(now());

SELECT
    UNIX_TIMESTAMP(CURDATE());

SELECT
    UNIX_TIMESTAMP(CURTIME());

SELECT
    FROM_UNIXTIME(1576380910);

SELECT
    YEAR(CURDATE()),
    MONTH(CURDATE()),
    DAY(CURDATE()),
    HOUR(CURTIME()),
    MINUTE(NOW()),
    SECOND(SYSDATE())
FROM
    DUAL;

SELECT
    MONTHNAME('2021-10-26'),
    DAYNAME('2021-10-26'),
    WEEKDAY(now()),
    QUARTER(CURDATE()),
    WEEK(CURDATE()),
    DAYOFYEAR(NOW()),
    DAYOFMONTH(NOW()),
    DAYOFWEEK(NOW())
FROM
    DUAL;

SELECT
    EXTRACT(MINUTE FROM NOW()),
    EXTRACT( WEEK FROM NOW()),
    EXTRACT( QUARTER FROM NOW()),
    EXTRACT( MINUTE_SECOND FROM NOW())
FROM
    DUAL;

SELECT
    ADDTIME(NOW(), 20),
    SUBTIME(NOW(), 30),
    SUBTIME(NOW(), '1:1:3'),
    DATEDIFF(NOW(), '2021-10-01'),
    TIMEDIFF(NOW(), '2021-10-25 22:10:10'),
    FROM_DAYS(366),
    TO_DAYS('0000-12-25'),
    LAST_DAY(NOW()),
    MAKEDATE(YEAR(NOW()), 12),
    MAKETIME(10, 21, 23),
    PERIOD_ADD(20200101010101,
10)
FROM
    DUAL;

SELECT
    last_name,
    salary,
    IF(salary >= 10000,
    '高工资',
    '低工资') "details"
FROM
    employees e;

SELECT
    e.last_name ,
    e.commission_pct ,
    IF (e.commission_pct IS NULL ,
    0,
    e.commission_pct) "details",
    e.salary * 12 * (1 + IF (e.commission_pct IS NULL ,
    0,
    e.commission_pct)) "annual_sal"
FROM
    employees e ;

SELECT
    e.last_name ,
    e.commission_pct ,
    IFNULL(e.commission_pct, 0) "details",
    e.salary * 12 * (1 + IFNULL(e.commission_pct, 0)) "annual_sal"
FROM
    employees e ;

SELECT
    e.last_name ,
    e.salary ,
    CASE
        WHEN e.salary >= 15000 THEN '高薪'
        WHEN e.salary >= 10000 THEN '中薪'
        WHEN e.salary >= 8000 THEN '底薪'
        ELSE '贫民'
    END "details"
FROM
    employees e ;

SELECT
    e.last_name ,
    e.department_id,
    e.salary ,
    e.employee_id ,
    CASE
        e.department_id WHEN 10 THEN salary * 1.1
        WHEN 20 THEN salary * 1.2
        WHEN 30 THEN salary * 1.3
        ELSE salary * 1.4
    END "details"
FROM
    employees e;

SELECT
    e.employee_id ,
    e.last_name ,
    e.department_id,
    e.salary ,
    CASE
        e.department_id WHEN 10 THEN salary * 1.1
        WHEN 20 THEN salary * 1.2
        WHEN 30 THEN salary * 1.3
    END "details"
FROM
    employees e
WHERE
    e.department_id IN(10, 20, 30);

SELECT
    md5('adfasfaf'),
    sha('adsfasfsaffff')
FROM
    DUAL;

SELECT
    VERSION(),
    DATABASE(),
    CONNECTION_ID(),
    SCHEMA(),
    USER (),
    CURRENT_USER(),
    CHARSET('abc'),
    COLLATION ('abc')
FROM
    DUAL;

SELECT
    FORMAT(123.123, 2)
FROM
    DUAL;

SELECT
    CONV(16, 10, 2),
    CONV(8888, 10, 16),
    CONV(16, 10, 8),
    CONV(NULL, 10, 2)
FROM
    DUAL;

SELECT
    NOW(),
    SYSDATE(),
    CURRENT_TIMESTAMP(),
    LOCALTIME(),
    LOCALTIMESTAMP()
FROM
    DUAL;

SELECT
    e.employee_id ,
    e.last_name ,
    e.salary ,
    e.salary * 1.2 "new salary"
FROM
    employees e ;

SELECT
    last_name,
    CHAR_LENGTH(last_name) "length"
FROM
    employees e
ORDER BY
    LEFT(last_name,
    1) ASC;

SELECT
    CONCAT(employee_id, last_name, salary) "OUT_PUT"
FROM
    employees e ;

SELECT
    *
FROM
    employees e ;

SELECT
    ROUND(DATEDIFF(CURDATE(), hire_date) / 365, 1) "years",
    DATEDIFF(CURDATE(), hire_date) "days"
FROM
    employees e
ORDER BY
    years DESC;

SELECT
    last_name,
    hire_date,
    department_id
FROM
    employees
WHERE
    YEAR(hire_date)>= 1997
    AND department_id IN (80, 90, 110)
    AND commission_pct IS NOT NULL;

SELECT
    last_name,
    hire_date,
    department_id
FROM
    employees
WHERE
    hire_date >= '1997-01-01'
    AND department_id IN (80, 90, 110)
    AND commission_pct IS NOT NULL;

SELECT
    last_name ,
    hire_date
FROM
    employees e
WHERE
    DATEDIFF(CURDATE(), hire_date) >= 10000;

SELECT
    CONCAT(last_name, ' earns ', salary, ' monthly but wants', salary * 3) "Dream Salary"
FROM
    employees e ;

SELECT
    last_name "Last_name",
    job_id "Job_id",
    CASE  
                           WHEN job_id = 'AD_PRES' THEN 'A'
        WHEN job_id = 'ST_MAN' THEN 'B'
        WHEN job_id = 'IT_PROG' THEN 'C'
        WHEN job_id = 'SA_REP' THEN 'D'
        WHEN job_id = 'ST_CLERK' THEN 'E'
        ELSE ''
    END "Grade"
FROM
    employees e ;

SELECT
    last_name "Last_name",
    job_id "Job_id",
    CASE
        job_id
                           WHEN 'AD_PRES' THEN 'A'
        WHEN 'ST_MAN' THEN 'B'
        WHEN 'IT_PROG' THEN 'C'
        WHEN 'SA_REP' THEN 'D'
        WHEN 'ST_CLERK' THEN 'E'
        ELSE ''
    END "Grade"
FROM
    employees e ;

SELECT
    AVG(salary),
    MAX(salary),
    MIN(salary),
    SUM(salary)
FROM
    employees
WHERE
    job_id LIKE '%REP%';

SELECT
    MIN(hire_date),
    MAX(hire_date)
FROM
    employees;

SELECT
    department_id,
    ROUND(AVG(salary), 2)
FROM
    employees
GROUP BY
    department_id ;

SELECT
    job_id,
    department_id,
    AVG(salary)
FROM
    employees e
GROUP BY
    department_id ,
    job_id ;

SELECT
    department_id,
    AVG(salary)
FROM
    employees
GROUP BY
    department_id WITH ROLLUP;

SELECT
    department_id,
    MAX(salary)
FROM
    employees e
GROUP BY
    department_id
HAVING
    MAX(salary) > 10000 ;

SELECT
    MAX(salary)
FROM
    employees e ;

SELECT
    department_id,
    MAX(salary)
FROM
    employees e
WHERE
    department_id IN (10, 20, 30, 40)
GROUP BY
    department_id
HAVING
    MAX(salary) > 10000 ;

SELECT
    department_id,
    MAX(salary)
FROM
    employees e
GROUP BY
    department_id
HAVING
    MAX(salary) > 10000
    AND department_id IN (10, 20, 30, 40) ;

SELECT
    AVG(salary),
    MAX(salary),
    MIN(salary),
    SUM(salary)
FROM
    employees e ;

SELECT
    job_id ,
    MAX(salary),
    MIN(salary),
    AVG(salary),
    SUM(salary)
FROM
    employees e
GROUP BY
    e.job_id ;

SELECT
    job_id,
    COUNT(*)
FROM
    employees e
GROUP BY
    job_id ;

SELECT
    MAX(salary) - MIN(salary)
FROM
    employees e ;

SELECT
    *
FROM
    employees e ;

SELECT
    e.manager_id,
    e2.last_name ,
    MIN(e.salary)
FROM
    employees e
JOIN employees e2
WHERE
    e.manager_id IS NOT NULL
    AND e2.employee_id = e.manager_id
GROUP BY
    e.manager_id
HAVING
    MIN(e.salary) >= 6000;

SELECT
    d.department_name ,
    d2.location_id,
    e.department_id ,
    COUNT(*),
    AVG(e.salary)
FROM
    employees e
RIGHT JOIN departments d ON
    e.department_id = d.department_id
JOIN departments d2 ON
    e.department_id = d2.department_id
GROUP BY
    d.department_id
ORDER BY
    AVG (e.salary) DESC ;

SELECT
    d.department_id ,
    d.location_id ,
    COUNT(e.employee_id) "employee_num",
    AVG(salary) "avg_salary"
FROM
    departments d
LEFT JOIN employees e 
ON
    d.department_id = e.department_id
GROUP BY
    d.department_id ,
    d.location_id
ORDER BY
    AVG (e.salary) DESC;

SELECT
    *
FROM
    employees e
WHERE
    e.department_id = 50;

SELECT
    *
FROM
    departments d ;

SELECT
    e.job_id,
    d.department_name,
    MIN(salary)
FROM
    departments d
LEFT JOIN employees e 
ON
    d.department_id = e.department_id
GROUP BY
    e.job_id,
    d.department_id;

SELECT
    salary,
    last_name
FROM
    employees e
WHERE
    salary > (
    SELECT
        salary
    FROM
        employees e2
    WHERE
        e2.last_name = 'Abel'
                );

SELECT
    *
FROM
    employees e
WHERE
    e.salary > (
    SELECT
        salary
    FROM
        employees e2
    WHERE
        e2.employee_id = 149
                 );

SELECT
    employee_id,
    manager_id,
    department_id
FROM
    employees e
WHERE
    manager_id = (
    SELECT
        manager_id
    FROM
        employees e2
    WHERE
        e2.employee_id = 141
)
    AND department_id = (
    SELECT
        department_id
    FROM
        employees e3
    WHERE
        e3.employee_id = 141
)
    AND e.employee_id != 141

SELECT
    employee_id,
    manager_id,
    department_id
FROM
    employees e
WHERE
    (manager_id,
    department_id) = (
    SELECT
        manager_id ,
        department_id
    FROM
        employees e2
    WHERE
        e2.employee_id = 141
)
    AND e.employee_id != 141

SELECT
    e.department_id,
    MIN(e.salary)
FROM
    employees e
WHERE
    e.department_id IS NOT NULL
GROUP BY
    department_id
HAVING
    MIN(e.salary) > (
    SELECT
        MIN(e2.salary)
    FROM
        employees e2
    WHERE
        e2.department_id = 50
)
    #  显示员工的　employee_id，last_name 和 location
    #  其中，若员工 department_id 与 location_id 为 1800 的 department_id 相同，则location 为'Canada', 其余则为'USA'
SELECT
    e.employee_id ,
    e.last_name,
    CASE
        e.department_id WHEN (
        SELECT
            d.department_id
        FROM
            departments d
        WHERE
            d.location_id = 1800)
                                                        THEN 'Canada'
        ELSE 'USA'
    END 
 "location"
FROM
    employees e 

SELECT
    employee_id,
    last_name,
    salary,
    department_id
FROM
    employees e
WHERE
    salary IN 
               (
    SELECT
        MIN(salary)
    FROM
        employees e2
    GROUP BY
        department_id
                );
# 题目：返回其它job_id中比job_id为‘IT_PROG’部门任一工资低的员工的员工号、姓名、job_id 以及salary  
SELECT
    employee_id,
    last_name,
    job_id,
    salary
FROM
    employees e
WHERE
    job_id <> 'IT_PROG'
    AND salary < ANY (
    SELECT
        salary
    FROM
        employees e2
    WHERE
        job_id = 'IT_PROG'
                    );
# 题目：返回其它job_id中比job_id为‘IT_PROG’部门所有工资都低的员工的员工号、姓名、job_id以及salary
SELECT
    employee_id,
    last_name,
    job_id,
    salary
FROM
    employees e
WHERE
    job_id <> 'IT_PROG'
    AND salary < ALL (
    SELECT
        salary
    FROM
        employees e2
    WHERE
        job_id = 'IT_PROG'
                    );
# 题目：查询平均工资最低的部门id
                   
SELECT
    department_id
FROM
    employees e2
GROUP BY
    department_id
HAVING
    AVG(salary) = (
    SELECT
        MIN(avg_sal) "min_avg_sal"
    FROM
        (
        SELECT
            AVG(salary) "avg_sal"
        FROM
            employees e
        GROUP BY
            department_id
) t_dept_avg_sal);

SELECT
    department_id
FROM
    employees e
GROUP BY
    department_id
HAVING
    AVG(salary) <= ALL (
    SELECT
        AVG(salary) "avg_sal"
    FROM
        employees e
    GROUP BY
        department_id
                           );
# 空值问题
SELECT
    last_name
FROM
    employees
WHERE
    employee_id NOT IN (
    SELECT
        manager_id
    FROM
        employees
                   );

SELECT
    last_name
FROM
    employees
WHERE
    employee_id NOT IN (
    SELECT
        manager_id
    FROM
        employees
    WHERE
        manager_id IS NOT NULL 
                  );
# 查询工资大于本部门平均工资的员工信息
SELECT
    last_name,
    salary,
    department_id
FROM
    employees e
WHERE
    salary > (
    SELECT
        AVG(salary)
    FROM
        employees e2
    WHERE
        department_id = e.department_id              
               );

SELECT
    e.last_name ,
    e.salary ,
    e.department_id
FROM
    employees e ,
    (
    SELECT
        department_id,
        AVG(salary) "avg_sal"
    FROM
        employees e2
    GROUP BY
        department_id) t_dept_avg_sal
WHERE
    e.department_id = t_dept_avg_sal.department_id
    AND e.salary > t_dept_avg_sal.avg_sal;
#题目：查询员工的id,salary,按照department_name 排序
SELECT
    employee_id,
    salary
FROM
    employees e
ORDER BY
    (
    SELECT
        department_name
    FROM
        departments d
    WHERE
        e.department_id = d.department_id);
# 题目：若employees表中employee_id与job_history表中employee_id相同的数目不小于2，输出这些相同id的员工的employee_id,last_name和其job_id       
  
SELECT
    employee_id,
    last_name,
    job_id
FROM
    employees e
WHERE
    2 <= (
    SELECT
        COUNT(*)
    FROM
        job_history jh
    WHERE
        jh.employee_id = e.employee_id);
# 题目：查询公司管理者的employee_id，last_name，job_id，department_id信息
SELECT
    DISTINCT e2.employee_id,
    e2.last_name ,
    e2.job_id ,
    e2.department_id
FROM
    employees e
JOIN employees e2 
ON
    e.manager_id = e2.employee_id;

SELECT
    employee_id,
    last_name,
    job_id,
    department_id
FROM
    employees e
WHERE
    e.employee_id IN(
    SELECT
        DISTINCT manager_id
    FROM
        employees e2);

SELECT
    employee_id,
    last_name,
    job_id,
    department_id
FROM
    employees e
WHERE
    EXISTS (
    SELECT
        *
    FROM
        employees e2
    WHERE
        e.employee_id = e2.manager_id);
# 题目：查询departments表中，不存在于employees表中的部门的department_id和department_name
SELECT
    d.department_id,
    d.department_name
FROM
    employees e
RIGHT JOIN departments d 
ON
    e.department_id = d.department_id
WHERE
    e.department_id IS NULL;

SELECT
    d.department_id ,
    d.department_name
FROM
    departments d
WHERE
    NOT EXISTS (
    SELECT
        *
    FROM
        employees e
    WHERE
        d.department_id = e.department_id);

SELECT
    last_name,
    salary
FROM
    employees e
WHERE
    e.department_id IN (
    SELECT
        department_id
    FROM
        employees e2
    WHERE
        e2.last_name = 'Zlotkey')
    AND last_name <> 'Zlotkey'

SELECT
    last_name,
    employee_id,
    salary
FROM
    employees e
WHERE
    e.salary > (
    SELECT
        AVG(salary)
    FROM
        employees e );

SELECT
    last_name,
    job_id,
    salary
FROM
    employees e
WHERE
    e.salary > ALL (
    SELECT
        salary
    FROM
        employees e2
    WHERE
        e2.job_id = 'SA_MAN');

SELECT
    employee_id,
    last_name,
    department_id
FROM
    employees e
WHERE
    department_id IN (
    SELECT
        DISTINCT department_id
    FROM
        employees e2
    WHERE
        e2.last_name LIKE '%u%');

SELECT
    employee_id,
    department_id
FROM
    employees e
WHERE
    e.department_id IN (
    SELECT
        department_id
    FROM
        departments d
    WHERE
        d.location_id = 1700);

SELECT
    last_name,
    salary
FROM
    employees e
WHERE
    manager_id IN (
    SELECT
        employee_id
    FROM
        employees e2
    WHERE
        e2.last_name = 'King');

SELECT
    last_name,
    salary
FROM
    employees e
WHERE
    e.salary = (
    SELECT
        MIN(salary)
    FROM
        employees e2);

SELECT
    department_id,
    department_name
FROM
    departments d
WHERE
    department_id IN (
    SELECT
        department_id
    FROM
        employees e2
    GROUP BY
        department_id
    HAVING
        AVG(salary) = (
        SELECT
            MIN(avg_sal) "min_avg_sal"
        FROM
            (
            SELECT
                AVG(salary) "avg_sal"
            FROM
                employees e
            GROUP BY
                department_id
 										) t_dept_avg_sal));

SELECT
    department_id
FROM
    employees e2
GROUP BY
    department_id
HAVING
    AVG(salary) = (
    SELECT
        MIN(t_dept_avg_sal.avg_sal)
    FROM
        (
        SELECT
            department_id,
            AVG(salary) "avg_sal"
        FROM
            employees e
        GROUP BY
            department_id ) t_dept_avg_sal
						);

SELECT
    *
FROM
    departments d
WHERE
    d.department_id = (
    SELECT
        department_id
    FROM
        employees e2
    GROUP BY
        department_id
    HAVING
        AVG(salary) <= ALL (
        SELECT
            AVG(salary)
        FROM
            employees e
        GROUP BY
            department_id 
											)	
					);

SELECT
    d.*,
    t_dept_avg_sal.avg_sal "avg_salary"
FROM
    departments d ,
    (
    SELECT
        e.department_id ,
        AVG(e.salary) "avg_sal"
    FROM
        employees e
    GROUP BY
        e.department_id
    ORDER BY
        avg_sal ASC
    LIMIT 0,
    1
) t_dept_avg_sal
WHERE
    d.department_id = t_dept_avg_sal.department_id;

SELECT
    *,
    (
    SELECT
        avg(salary)
    FROM
        employees e3
    WHERE
        e3.department_id = d.department_id) "avg_salary"
FROM
    departments d
WHERE
    d.department_id = (
    SELECT
        department_id
    FROM
        employees e2
    GROUP BY
        department_id
    HAVING
        AVG(salary) <= ALL (
        SELECT
            AVG(salary)
        FROM
            employees e
        GROUP BY
            department_id 
											)	
					);

SELECT
    *
FROM
    jobs j
WHERE
    j.job_id = (
    SELECT
        job_id
    FROM
        employees e
    GROUP BY
        job_id
    HAVING
        AVG(salary) >= ALL (
        SELECT
            AVG(salary)
        FROM
            employees e2
        GROUP BY
            e2.job_id )
				)
				
SELECT
    MAX(avg_sal) "max_avg_job"
FROM
    (
    SELECT
        AVG(salary) "avg_sal"
    FROM
        employees e
    GROUP BY
        e.job_id ) t_avg_job_sal	

SELECT
    *
FROM
    jobs j
WHERE
    j.job_id = (
    SELECT
        job_id
    FROM
        employees e
    GROUP BY
        job_id
    HAVING
        AVG(salary) = (
        SELECT
            MAX(avg_sal) "max_avg_job"
        FROM
            (
            SELECT
                AVG(salary) "avg_sal"
            FROM
                employees e
            GROUP BY
                e.job_id ) t_avg_job_sal)
				);

SELECT
    *
FROM
    jobs j
WHERE
    j.job_id = (
    SELECT
        job_id
    FROM
        employees e
    GROUP BY
        job_id
    HAVING
        AVG(salary) = (
        SELECT
            AVG(salary) "avg_sal"
        FROM
            employees e2
        GROUP BY
            e2.job_id
        ORDER BY
            avg_sal DESC
        LIMIT 0,
        1
					)
				)	

SELECT
    j.*
FROM
    jobs j ,
    (
    SELECT
        job_id ,
        AVG(salary) "avg_sal"
    FROM
        employees e2
    GROUP BY
        e2.job_id
    ORDER BY
        avg_sal DESC
    LIMIT 0,
    1 ) job_avg_sal
WHERE
    j.job_id = job_avg_sal.job_id					


SELECT
    DISTINCT e2.manager_id,
    e3.last_name ,
    e3.department_id,
    e3.email,
    e3.salary
FROM
    employees e2
JOIN employees e3 
ON
    e2.manager_id = e3.employee_id
WHERE
    e2.manager_id IS NOT NULL
    AND e2.department_id = (
    SELECT
        department_id
    FROM
        employees e2
    GROUP BY
        department_id
    HAVING
        AVG(salary) = (
        SELECT
            MAX(avg_sal)
        FROM
            (
            SELECT
                AVG(salary) "avg_sal"
            FROM
                employees e
            GROUP BY
                department_id ) t_dept_avg_sal
											)
					);

SELECT
    last_name ,
    department_id ,
    email ,
    salary
FROM
    employees e3
WHERE
    e3.employee_id IN (
    SELECT
        manager_id
    FROM
        employees e2 ,
        (
        SELECT
            department_id,
            AVG(salary) avg_sal
        FROM
            employees e
        GROUP BY
            department_id
        ORDER BY
            avg_sal DESC
        LIMIT 0,
        1) t_dept_avg_sal
    WHERE
        e2.department_id = t_dept_avg_sal.department_id
						);

SELECT
    department_id
FROM
    departments d
WHERE
    d.department_id <> (
    SELECT
        DISTINCT department_id
    FROM
        employees e
    WHERE
        job_id = 'ST_CLERK'
										)

SELECT
    department_id
FROM
    departments d
WHERE
    NOT EXISTS (
    SELECT
        *
    FROM
        employees e
    WHERE
        job_id = 'ST_CLERK'
        AND e.department_id = d.department_id 
								);

SELECT
    last_name
FROM
    employees e
WHERE
    NOT EXISTS (
    SELECT
        *
    FROM
        employees e2
    WHERE
        e.manager_id = e2.employee_id 
				)

SELECT
    e.employee_id,
    e.last_name,
    e.hire_date,
    e.salary
FROM
    employees e
WHERE
    EXISTS (
    SELECT
        *
    FROM
        employees e2
    WHERE
        e.manager_id = e2.employee_id
        AND e2.last_name = 'DE Haan'
)

SELECT
    department_name
FROM
    departments d
WHERE
    5 < (
    SELECT
        COUNT(*)
    FROM
        employees e
    WHERE
        e.department_id = d.department_id 
)

SELECT
    l.country_id
FROM
    locations l
WHERE
    2 < (
    SELECT
        COUNT(*)
    FROM
        departments d
    WHERE
        d.location_id = l.location_id)

DESC employees ;

SHOW CREATE TABLE employees ;

CREATE TABLE `employees` (
  `employee_id` int NOT NULL DEFAULT '0',
  `first_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(25) NOT NULL,
  `email` varchar(25) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `hire_date` date NOT NULL,
  `job_id` varchar(10) NOT NULL,
  `salary` double(8,
2) DEFAULT NULL,
  `commission_pct` double(2,
2) DEFAULT NULL,
  `manager_id` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE KEY `emp_email_uk` (`email`),
  UNIQUE KEY `emp_emp_id_pk` (`employee_id`),
  KEY `emp_dept_fk` (`department_id`),
  KEY `emp_job_fk` (`job_id`),
  KEY `emp_manager_fk` (`manager_id`),
  CONSTRAINT `emp_dept_fk` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`),
  CONSTRAINT `emp_job_fk` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`),
  CONSTRAINT `emp_manager_fk` FOREIGN KEY (`manager_id`) REFERENCES `employees` (`employee_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3

CREATE DATABASE test1;

CREATE DATABASE test2 CHARACTER SET
'utf8mb4';

SHOW CREATE DATABASE test1;

SHOW CREATE DATABASE test2;

CREATE DATABASE `test1` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */
/*!80016 DEFAULT ENCRYPTION='N' */
CREATE DATABASE `test2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */
/*!80016 DEFAULT ENCRYPTION='N' */

SELECT
    DATABASE()
FROM
    DUAL;

SHOW TABLES
FROM
mysql;

SHOW tables;

SHOW CREATE DATABASE test1;

ALTER DATABASE test1 CHARACTER SET
'utf8'

DROP DATABASE IF EXISTS test2;

DROP DATABASE test1;

SHOW DATABASES;

SELECT
    DATABASE()
FROM
    DUAL;

CREATE TABLE IF NOT EXISTS myemp3(
id int,
emp_name varchar(15),
hire_data date
);

DESC myemp1 ;

CREATE TABLE myemp2 AS
SELECT
    employee_id,
    last_name,
    salary
FROM
    employees e ;

SELECT
    *
FROM
    myemp2;

CREATE TABLE employees_blank 
AS
SELECT
    *
FROM
    employees e
WHERE
    1 = 2;

SELECT
    *
FROM
    employees_blank;

ALTER TABLE myemp1 
ADD salary double(10,
2);

DESC myemp1 ;

ALTER TABLE myemp1 
ADD phone_number varchar(20) FIRST;

ALTER TABLE myemp1 
ADD email varchar(50) AFTER emp_name;

ALTER TABLE myemp1 
MODIFY emp_name varchar(25) DEFAULT '';

ALTER TABLE myemp1 
CHANGE salary monthly_salary double(10,
2);

ALTER TABLE myemp1 
CHANGE email my_email varchar(48);

ALTER TABLE myemp1 
DROP COLUMN my_email;

RENAME TABLE myemp1 
TO myemp11;

ALTER TABLE myemp11 
RENAME TO myemp1;

DROP TABLE IF EXISTS myemp3;

CREATE TABLE myemp1
AS
SELECT
    *
FROM
    employees e ;

SELECT
    *
FROM
    myemp1;

TRUNCATE TABLE myemp1;

DELETE
FROM
    myemp1 ;

DELETE
FROM
    myemp1
WHERE
    employee_id = 198;

SELECT
    *
FROM
    myemp3 m ;

COMMIT;

SET
autocommit = FALSE ;

DELETE
FROM
    myemp2 ;

ROLLBACK;

CREATE DATABASE IF NOT EXISTS test01_office CHARACTER SET
'utf8';

USE test01_office;

SELECT
    DATABASE();

SELECT
    DATABASE();

CREATE TABLE IF NOT EXISTS dept01
(
id int(7) DEFAULT 1000000,
name varchar(25) DEFAULT ''
)

CREATE TABLE IF NOT EXISTS dept02 
AS
SELECT
    *
FROM
    atguigudb.departments d;

SELECT
    *
FROM
    dept02;

CREATE TABLE IF NOT EXISTS emp01
(
id int(7),
first_name varchar(25),
last_name varchar(25),
dept_id int(7)
)

ALTER TABLE emp01 
MODIFY last_name varchar(50);

DESC emp02;

CREATE TABLE IF NOT EXISTS emp02
AS
SELECT
    *
FROM
    atguigudb.employees e ;

DROP TABLE IF EXISTS emp01;

RENAME TABLE emp02
TO emp01;

ALTER TABLE emp02 RENAME emp01;

DESC emp01;

SELECT
    *
FROM
    emp01 e ;

ALTER TABLE emp01 
ADD COLUMN test_colunm varchar(100);

ALTER TABLE dept02  
ADD COLUMN test_colunm varchar(100);

ALTER TABLE emp01 
DROP COLUMN department_id;

DESC emp01 ;

ALTER TABLE emp01 
DROP COLUMN test_colunm;

CREATE DATABASE IF NOT EXISTS test02_market;

USE test02_market;

CREATE TABLE IF NOT EXISTS customers(
c_num int,
c_name varchar(50),
c_contact varchar(50),
c_city varchar(50),
c_birth date
);

DESC customers;

ALTER TABLE customers
MODIFY c_contact varchar(50) AFTER c_birth;

ALTER TABLE customers
MODIFY c_name varchar(70);

ALTER TABLE customers
CHANGE c_contact c_phone varchar(50);

ALTER TABLE customers
ADD c_gender char(1) AFTER c_name;

RENAME TABLE customers TO customers_info;

SHOW tables;

DESC customers_info;

ALTER TABLE customers_info
DROP COLUMN c_city;

CREATE DATABASE IF NOT EXISTS test03_company;

USE test03_company;

CREATE TABLE IF NOT EXISTS offices(
office_code int,
city varchar(30),
address varchar(50),
country varchar(50),
postal_code varchar(25)
);

CREATE TABLE IF NOT EXISTS employees(
empNum int,
last_name varchar(50),
first_name varchar(50),
mobile varchar(25),
code int,
job_title varchar(50),
birth date,
note varchar(255),
sex varchar(5)
);

SHOW tables;

DESC employees;

ALTER TABLE employees
MODIFY mobile varchar(25) AFTER code;

ALTER TABLE employees
CHANGE birth birthday date;

ALTER TABLE employees
MODIFY sex char(1);

ALTER TABLE employees
DROP COLUMN note;

ALTER TABLE employees
ADD COLUMN favoriate_activity varchar(100);

RENAME TABLE employees TO employees_info;

CREATE DATABASE IF NOT EXISTS test01_library;

USE test01_library;

SHOW tables;

CREATE TABLE IF NOT EXISTS test1(
a int,
b int,
c int GENERATED ALWAYS AS (a + b) VIRTUAL
)

INSERT
    INTO
    test1 (a,
    b)
VALUES (10,
20);

UPDATE
    test1
SET
    a = 100;

SELECT
    *
FROM
    test1;

CREATE TABLE IF NOT EXISTS books(
id int,
name varchar(50),
authors varchar(100),
price float,
pubdaate YEAR,
note varchar(100),
num int
)


INSERT
    INTO
    books
VALUES (1,
'TalofAAA',
'Dickes',
23,
'1995',
'novel',
11);

INSERT
    INTO
    books (id,
    name,
    authors,
    price,
    pubdate,
    note,
    num)
VALUES (2,
'EmmaT',
'Jane lura',
35,
'1993',
'joke',
22);

INSERT
    INTO
    books (id,
    name,
    authors,
    price,
    pubdate,
    note,
    num)
VALUES (3,
'Story of Jane',
'Jane Tim',
40,
'2001',
'novel',
0),
(5,
'Old land',
'Honore Blade',
30,
'2010',
'law',
0);

INSERT
    INTO
    books
VALUES (3,
'Story of Jane',
'Jane Tim',
40,
'2001',
'novel',
0),
(4,
'Lovey Day',
'George Byron',
20,
'2005',
'novel',
30),
(5,
'Old land',
'Honore Blade',
30,
'2010',
'law',
0),
(6,
'The battle',
'Upton Sara',
30,
'1999',
'medicine',
40),
(7,
'Rose Hood',
'Richard haggard',
28,
'2008',
'cartoon',
28)
;

SELECT
    DATABASE();

SHOW DATABASES;

UPDATE
    books
SET
    price = price + 5
WHERE
    note = 'novel'

UPDATE
    books
SET
    price = 40,
    note = 'drama'
WHERE
    name = 'EmmaT'
    
DELETE
FROM
    books
WHERE
    num = 0;

SELECT
    *
FROM
    books
WHERE
    name LIKE '%a%' ;

SELECT
    count(*) "book number",
    sum(num) "total"
FROM
    books
WHERE
    name LIKE '%a%';

SELECT
    *
FROM
    books;

SELECT
    *
FROM
    books
WHERE
    note = 'novel'
ORDER BY
    price DESC ;

SELECT
    *
FROM
    books
ORDER BY
    num DESC ,
    note ;

SELECT
    note,
    COUNT(*)
FROM
    books
GROUP BY
    note;

SELECT
    note,
    sum(num) "note_num"
FROM
    books
GROUP BY
    note
HAVING
    note_num > 30;

SELECT
    *
FROM
    books
LIMIT 5,
5;

SELECT
        note,
        sum(num) "note_num"
FROM
        books
GROUP BY
        note
ORDER BY
    note_num DESC
LIMIT 0,
1

SELECT
    *
FROM
    books;

SELECT
     name
FROM
    books
WHERE
    CHAR_LENGTH(REPLACE(name, ' ', ''))>= 10;

SELECT
    name,
    note
FROM
    books;

SELECT
    name "书名",
    note,
    CASE
        note WHEN 'novel' THEN '小说'
        WHEN 'law' THEN '法律'
        WHEN 'medicine' THEN '医药'
        WHEN 'cartoon' THEN '卡通'
        WHEN 'joke' THEN '笑话'
        ELSE note
    END "分类"
FROM
    books;

SELECT
    name "书名",
    num "库存",
    CASE
        WHEN num > 30 THEN '滞销'
        WHEN num > 0
        AND num < 10 THEN '畅销'
        WHEN num = 0 THEN '需要无货'
        ELSE '一般'
    END "状况"
FROM
    books;

SELECT
    IFNULL(note, '合计库存总数') "note" ,
    sum(num)
FROM
    books
GROUP BY
    note
WITH ROLLUP;

SELECT
    IFNULL(note, '合计总数') "note" ,
    COUNT(*)
FROM
    books
GROUP BY
    note
WITH ROLLUP;

SELECT
    *
FROM
    books
ORDER BY
    num DESC
LIMIT 0,
3

SELECT
    *
FROM
    books
WHERE
    pubdate = (
    SELECT
        MIN(pubdate)
    FROM
        books
);

SELECT
    *
FROM
    books
WHERE
    note = 'novel'
ORDER BY
    price DESC
LIMIT 0,
1;

SELECT
    *
FROM
    books
ORDER BY
    CHAR_LENGTH(REPLACE(name, ' ', '')) DESC
LIMIT 0,
1;

CREATE DATABASE IF NOT EXISTS dbtest11 CHARACTER SET
'utf8';

USE dbtest11;

CREATE TABLE my_employees(
id INT(10),
first_name VARCHAR(10),
last_name VARCHAR(10),
userid VARCHAR(10),
salary DOUBLE(10,
2)
);

CREATE TABLE users(
id INT,
userid VARCHAR(10),
department_id INT
);

DESC my_employees;

INSERT
    INTO
    my_employees (id,
    first_name,
    last_name,
    userid,
    salary)
VALUES (
1,
'patel',
'Ralph',
'Rpatel',
895),
(2,
'Dancs',
'Bttty',
'Badacs',
860),
(3,
'Biri',
'Ben',
'Bbiri',
1100),
(4,
'Newman',
'Chad',
'Cnewman',
750),
(5,
'Ropeburn',
'Audrey',
'Aropebur',
1550);

DESC users ;

INSERT
    INTO
    users (id,
    userid,
    department_id)
VALUES 
(1,
'Rpatel',
10),
(2,
'Bdancs',
10),
(3,
'Bbiri',
20),
(4,
'Cnewman',
30),
(5,
'Aropebur',
40);

UPDATE
    my_employees
SET
    last_name = 'drelxer'
WHERE
    id = 3;

UPDATE
    my_employees
SET
    salary = 1000
WHERE
    salary < 900;

SELECT
    *
FROM
    my_employees me ;

SELECT
    *
FROM
    users u ;

DELETE
FROM
    my_employees
WHERE
    userid = 'Bbiri'

DELETE
FROM
    users
WHERE
    userid = 'Bbiri'
    # 清空表
    TRUNCATE TABLE my_employees ;

SELECT
    DATABASE();

USE dbtest11;

CREATE TABLE IF NOT EXISTS pet(
name varchar(20),
owner varchar(20),
species varchar(20),
sex char(1),
birth YEAR,
death YEAR
)

INSERT
    INTO
    pet (name,
    owner,
    species,
    sex,
    birth,
    death)
VALUES ('Fluffy',
'harold',
'Cat',
'f',
2003,
2010),
('Claws',
'gwen',
'Cat',
'm',
2004,
NULL),
('Buffy',
'',
'Dog',
'f',
2009,
NULL),
('Fang',
'benny',
'Dog',
'm',
2000,
NULL),
('bowser',
'diane',
'Dog',
'm',
2003,
2009),
('Chirpy',
'',
'Bird',
'f',
2008,
NULL);

SELECT
    *
FROM
    pet;

ALTER TABLE pet 
ADD owner_birth date;

UPDATE
    pet
SET
    owner = 'kevin'
WHERE
    name = 'Claws'
    
UPDATE
    pet
SET
    owner = 'duck'
WHERE
    death IS NULL
    AND species = 'Dog'
    
SELECT
    name
FROM
    pet
WHERE
    owner = ''
    OR owner IS NULL ;

SELECT
    *
FROM
    pet
WHERE
    species = 'Cat'
    AND death IS NOT NULL;

DELETE
FROM
    pet
WHERE
    species = 'Dog'
    AND death IS NOT NULL;

DESC pet;

SELECT
    *
FROM
    pet;

CREATE TABLE IF NOT EXISTS employee (
id int,
name varchar(20),
sex char(1),
tel varchar(20),
addr varchar(50),
salary double(8,
2)
)

DESC employee;

INSERT
    INTO
    employee (id,
    name,
    sex,
    tel,
    addr,
    salary)
VALUES 
(10001,
'张一一',
'男',
'13456789000',
'山东青岛',
1001.58),
(10002,
'刘小红',
'女',
'13454319000',
'河北保定',
1201.21),
(10003,
'李四',
'男',
'0751-1234567',
'广东佛山',
1004.11),
(10004,
'刘小强',
'男',
'0755-5555555',
'广东深圳',
1501.23),
(10005,
'王艳',
'女',
'020-1232133',
'广东广州',
1405.16);

SELECT
    *
FROM
    employee;

SELECT
    *
FROM
    employee
WHERE
    salary >= 1200
    AND salary <= 1300;

SELECT
    *
FROM
    employee
WHERE
    name LIKE '刘%';

UPDATE
    employee
SET
    addr = '广东韶关'
WHERE
    name = '李四'
    
SELECT
    *
FROM
    employee
WHERE
    name LIKE '%小%';

SHOW variables LIKE 'character_%';

SELECT DATABASE();

CREATE TABLE test_int1(
f1 TINYINT,
f2 SMALLINT,
f3 MEDIUMINT,
f4 integer,
f5 bigint
)
DESC test_int1;

INSERT INTO test_int1 (f1)
VALUES (12),(-12),(-128),(127);

SELECT * FROM test_int1;

CREATE TABLE test_decimal1(
f1 decimal,
f2 decimal(5,2)
)
DESC test_decimal1;

INSERT INTO test_decimal1 (f1, f2)
VALUES (123.123, 123.456);

INSERT INTO test_decimal1(f2)
values(1234.34)

SELECT * FROM test_decimal1 ;

ALTER TABLE test_decimal1 MODIFY f1 decimal(5,2);

CREATE TABLE test_bit1(
f1 bit,
f2 bit(5),
f3 bit(64)
);

INSERT INTO test_bit1(f1)
values(1);

INSERT INTO test_bit1(f1)
values(2);

INSERT INTO test_bit1(f2)
VALUES(23);

SELECT * FROM test_bit1;

SELECT bin(f2), hex(f2) FROM test_bit1;

SELECT f2 + 0 FROM test_bit1;

CREATE TABLE test_datetime1(dt datetime);

INSERT INTO test_datetime1 VALUES
('2021-01-01 06:50:30')

INSERT INTO test_datetime1 VALUES
(current_timestamp()),(now());

SELECT * FROM test_datetime1 ;

CREATE TABLE test_timestamp1(ts timestamp);

INSERT INTO test_timestamp1
VALUES ('1999-01-01 03:04:50'), ('19990101030405'), ('99-01-01 03:04:05'),
('990101030405');

INSERT INTO test_timestamp1
VALUES ('2020@01@01@00@00@00'), ('20@01@01@00@00@00');

INSERT INTO test_timestamp1
VALUES (CURRENT_TIMESTAMP()), (NOW());

#Incorrect datetime value
INSERT INTO test_timestamp1
VALUES ('2038-01-20 03:14:07');

SELECT * FROM test_timestamp1 ;

CREATE TABLE temp_time(
d1 DATETIME,
d2 TIMESTAMP
);

INSERT INTO temp_time VALUES('2021-9-2 14:45:52','2021-9-2 14:45:52');

INSERT INTO temp_time VALUES(NOW(),NOW());

SELECT * FROM temp_time;

SET time_zone = '+8:00';

SELECT UNIX_TIMESTAMP();

CREATE TABLE test_enum(
season ENUM('春','夏','秋','冬','unknow')
);

INSERT INTO test_enum
VALUES('春'),('秋');

# 忽略大小写
INSERT INTO test_enum
VALUES('UNKNOW');

# 允许按照角标的方式获取指定索引位置的枚举值
INSERT INTO test_enum
VALUES('1'),(3);

SELECT * FROM test_enum;

INSERT INTO test_enum
VALUES('ab');

CREATE TABLE test_set(
s SET ('A', 'B', 'C')
);

INSERT INTO test_set (s) VALUES ('A'), ('A,B');

#插入重复的SET类型成员时，MySQL会自动删除重复的成员
INSERT INTO test_set (s) VALUES ('A,B,C,A');

#向SET类型的字段插入SET成员中不存在的值时，MySQL会抛出错误。
INSERT INTO test_set (s) VALUES ('A,B,C,D');

SELECT *
FROM test_set;

CREATE TABLE temp_mul(
gender ENUM('男','女'),
hobby SET('吃饭','睡觉','打豆豆','写代码')
);

INSERT INTO temp_mul VALUES('男','睡觉,打豆豆'); #成功

# Data truncated for column 'gender' at row 1
INSERT INTO temp_mul VALUES('男,女','睡觉,写代码'); #失败

# Data truncated for column 'gender' at row 1
INSERT INTO temp_mul VALUES('妖','睡觉,写代码');#失败

INSERT INTO temp_mul VALUES('男','睡觉,写代码,吃饭'); #成功

SELECT * FROM temp_mul;

CREATE TABLE test_binary1(
f1 BINARY,
f2 BINARY(3),
# f3 VARBINARY,
f4 VARBINARY(10)
);

INSERT INTO test_binary1(f1,f2)
VALUES('a','a');

INSERT INTO test_binary1(f1,f2)
VALUES('尚','尚');#失败

INSERT INTO test_binary1(f2,f4)
VALUES('ab','ab');

SELECT * FROM test_binary1;

CREATE TABLE test_json(
js json
);

INSERT INTO test_json (js)
VALUES ('{"name":"songhk", "age":18, "address":{"province":"beijing",
"city":"beijing"}}');

SELECT * FROM test_json ;

SELECT js -> '$.name' AS NAME,js -> '$.age' AS age ,js -> '$.address.province'
AS province, js -> '$.address.city' AS city FROM test_json;

SHOW DATABASES;

# 查看表中的约束
SELECT * FROM information_schema.table_constraints
WHERE table_name = 'employees'

CREATE DATABASE dbtest13;
USE dbtest13;

CREATE TABLE test1(
id int NOT NULL,
last_name varchar(15) NOT NULL,
email varchar(25),
salary decimal(10,2)
)

DESC test1;

INSERT INTO test1(id, last_name, email, salary)
values(1, 'Tom', 'tom@126.com', 3600);

SELECT * FROM test1;

CREATE TABLE test2(
id int,
last_name varchar(15),
email varchar(25),
salary decimal(10,2),

CONSTRAINT uk_test2_email unique(email)
)

DESC test2;

ALTER TABLE test2
MODIFY id int UNIQUE;

show index FROM test2;

ALTER TABLE test2
ADD CONSTRAINT uk_test2_last_name unique(last_name);

ALTER TABLE test2
DROP INDEX uk_test2_last_name;

CREATE TABLE test3(
id int PRIMARY KEY ,
last_name varchar(15),
email varchar(25),
salary decimal(10,2)
)

DESC test3;

CREATE TABLE test4(
id int,
last_name varchar(15),
email varchar(25) UNIQUE,
salary decimal(10,2),
CONSTRAINT pk_test4_id PRIMARY KEY(id)
)
DESC test4;

SELECT * FROM information_schema.table_constraints
WHERE table_name = 'test4'

show index FROM test4;

CREATE TABLE test5(
id int PRIMARY KEY AUTO_INCREMENT,
last_name varchar(20)
)
DESC test5;

INSERT INTO test5(last_name)
VALUES ('Tom2')

SELECT * FROM test5;

CREATE TABLE dept1(
dept_id int PRIMARY KEY,
dept_name varchar(15)
)

CREATE TABLE emp1(
emp_id int PRIMARY KEY AUTO_INCREMENT,
emp_name varchar(15),
department_id int,
CONSTRAINT fk_emp1_dept_id FOREIGN KEY (department_id) REFERENCES dept1(dept_id)
);

DESC dept1;

DESC emp1;

INSERT INTO dept1 (dept_id, dept_name)
VALUES (10, '生产部'),(20,'制造部')

INSERT INTO emp1
values(1001, 'Tom', 10)

SELECT * FROM dept1;
SELECT * FROM emp1 e;

CREATE DATABASE test04_emp;
USE test04_emp;

SELECT DATABASE(); 

CREATE TABLE emp2(
id int,
emp_name varchar(15)
)

CREATE TABLE dept2(
id int,
dept_name varchar(15)
)

ALTER TABLE emp2
MODIFY id int PRIMARY KEY;

DESC emp2;

ALTER TABLE dept2
ADD PRIMARY KEY(id); 

DESC dept2;

ALTER TABLE emp2
ADD COLUMN dept_id int;

ALTER TABLE emp2
ADD CONSTRAINT fk_emp2_dept2_id FOREIGN KEY (dept_id) REFERENCES dept2(id);

SELECT * FROM information_schema.table_constraints
WHERE table_name = 'emp2'

CREATE DATABASE IF NOT EXISTS test01_library;

USE test01_library;
SHOW tables;
DESC books;

ALTER TABLE books
MODIFY id int AUTO_INCREMENT;

ALTER TABLE books 
MODIFY name varchar(50) NOT NULL ;

ALTER TABLE books 
MODIFY authors varchar(100) NOT NULL ;

ALTER TABLE books 
MODIFY price float NOT NULL ;

ALTER TABLE books
MODIFY pubdate YEAR NOT NULL;

ALTER TABLE books 
MODIFY num int NOT NULL ;
SELECT * FROM books b ;

CREATE DATABASE test04_company;
USE test04_company;

SELECT DATABASE(); 
CREATE TABLE offices(
officeCode int PRIMARY KEY AUTO_INCREMENT,
city varchar(50) NOT NULL ,
address varchar(50),
country varchar(50) NOT NULL,
postalCode varchar(15) UNIQUE KEY
)
SHOW tables;
DESC offices;

CREATE TABLE employees(
employeeNumber int PRIMARY KEY AUTO_INCREMENT,
last_name varchar(50) NOT NULL,
first_name varchar(50) NOT NULL,
mobile varchar(25) UNIQUE KEY,
office_code int NOT NULL ,
job_title varchar(50) NOT NULL,
birth datetime NOT NULL,
note varchar(255),
sex varchar(5),
FOREIGN KEY (office_code) REFERENCES offices(officeCode)
)
DESC employees_info;

SELECT * FROM information_schema.table_constraints
WHERE table_name = 'employees'

ALTER TABLE employees MODIFY mobile varchar(25) AFTER office_code;

ALTER TABLE employees
CHANGE birth employee_birth datetime;

ALTER TABLE employees
MODIFY sex char(1) NOT NULL;

SELECT * FROM employees_info;

RENAME TABLE employees TO employees_info;

CREATE DATABASE IF NOT EXISTS test04_Market

SHOW DATABASES;

USE test04_Market

CREATE TABLE customers(
c_num int PRIMARY KEY AUTO_INCREMENT,
c_name varchar(50),
c_contact varchar(50),
c_city varchar(50),
c_birth datetime NOT NULL 
)

DESC customers_info;

ALTER TABLE customers 
MODIFY c_contact varchar(50) AFTER c_birth;

ALTER TABLE customers
MODIFY c_name varchar(70)

ALTER TABLE customers
CHANGE c_contact c_phone varchar(50);

ALTER TABLE customers
ADD COLUMN c_gender char(1)

ALTER TABLE customers
RENAME customers_info;

ALTER TABLE customers_info
DROP COLUMN c_city

CREATE TABLE orders(
o_num int PRIMARY KEY AUTO_INCREMENT,
o_date date,
c_id int,
CONSTRAINT fk_orders_customers_id FOREIGN KEY (c_id) REFERENCES customers_info(c_num)
)
DESC orders;

ALTER TABLE orders DROP FOREIGN KEY fk_orders_customers_id;

SHOW INDEX FROM orders;
ALTER TABLE orders
DROP INDEX fk_orders_customers_id;

SELECT * FROM information_schema.table_constraints
WHERE table_name = 'orders'

DROP TABLE customers_info;

SHOW tables;

CREATE TABLE pet(
name varchar(20) NOT NULL,
owner varchar(20),
species varchar(20) NOT NULL,
sex char(1) NOT NULL,
birth YEAR NOT NULL,
death YEAR 
)
DESC pet;

INSERT INTO pet(name, owner, species, sex, birth, death)
VALUES ('Fulffy','Harold', 'cat','f', 2003, 2010),
('Claws', 'Gwen', 'cat', 'm', 2004, null),
('Buffy', NULL, 'dog', 'f', 2009, null),
('Fang', 'Benny', 'dog', 'm', 2000,null),
('Bowser', 'Diane', 'dog', 'm', 2003, 2009),
('Chirpy', NULL, 'bird', 'f', 2008, null);

SELECT * FROM pet;

CREATE DATABASE test_company;
USE test_company;
CREATE TABLE IF NOT EXISTS department(
depid int PRIMARY KEY AUTO_INCREMENT,
depname varchar(30) NOT NULL ,
depinfo varchar(200)
)
DESC department;

CREATE TABLE IF NOT EXISTS emoloyee(
empid int PRIMARY KEY AUTO_INCREMENT,
name varchar(20) NOT NULL ,
sex char(1),
title varchar(20),
birthday datetime,
depid int,
CONSTRAINT fk_emoloyee_department_depid FOREIGN KEY (depid) REFERENCES department(depid) ON UPDATE CASCADE ON DELETE SET NULL
)
DESC emoloyee;
ALTER TABLE emoloyee
MODIFY sex char(1) DEFAULT '男'

CREATE TABLE salary(
empid int NOT NULL UNIQUE,
basesalary decimal(10,2),
titlesalary decimal(10,2) DEFAULT 0,
deduction decimal(10,2) DEFAULT 0
)
ALTER TABLE salary 
MODIFY empid int NULL UNIQUE 
DESC salary;
ALTER TABLE salary
ADD CONSTRAINT fk_salary_emoloyee_empid FOREIGN KEY (empid) REFERENCES emoloyee(empid) ON UPDATE CASCADE ON DELETE SET NULL 

SELECT * FROM information_schema.table_constraints
WHERE table_name = 'salary'

SHOW INDEX FROM salary;

ALTER TABLE salary
DROP INDEX empid_2

ALTER TABLE salary DROP FOREIGN KEY fk_salary_emoloyee_empid

ALTER TABLE salary
ADD CONSTRAINT fk_salary_emoloyee_empid FOREIGN KEY (empid) REFERENCES emoloyee(empid) ON UPDATE CASCADE ON DELETE CASCADE

ALTER TABLE salary
MODIFY empid int PRIMARY KEY;

DESC department;

INSERT INTO department(depid, depname, depinfo)
VALUES (111, '生产部', null),(222, '销售部', null),(333,'人事部','人力资源管理')

SELECT * FROM department d ;
INSERT INTO emoloyee (empid,name, sex, title,birthday, depid)
VALUES (1001, '张三','男','高级工程师','1975-1-1',111),
(1002, '李四', '女', '助工', '1985-1-1', 111),
(1003, '王五', '男', '工程师', '1987-11-11', 222),
(1004, '张六', '男', '工程师', '1999-1-1', 222)

SELECT * FROM emoloyee e ;

INSERT INTO salary (empid, basesalary, titlesalary, deduction)
VALUES (1001, 2200, 1100, 200),
(1002, 1200, 200, null),
(1003, 2900, 700, 200),
(1004, 1950, 700, 150)

SELECT * FROM salary s ;

SELECT e.empid, e.name, e.title, d.depname, (s.basesalary + s.titlesalary) AS salary, (s.basesalary + s.titlesalary - IFNULL(s.deduction, 0)) AS realSalary
FROM emoloyee e JOIN department d JOIN salary s  ON  e.depid =d.depid AND e.empid = s.empid 

SELECT e.name, s.basesalary FROM
emoloyee e JOIN department d JOIN salary s ON e.empid = s.empid AND d.depid = e.depid 
WHERE d.depname = '销售部';

DESC emoloyee ;

SELECT e.empid, e.name, e.sex,e.title, e.birthday,
e.depid, YEAR (NOW())-YEAR (e.birthday) AS age
FROM emoloyee e WHERE e.name LIKE '张%' AND YEAR (NOW())-YEAR (e.birthday) < 40;

SELECT e.empid, e.name, e.sex, e.title, e.birthday, e.depid, s.basesalary, s.titlesalary
FROM emoloyee e JOIN salary s ON e.empid = s.empid WHERE e.sex = '男'

SELECT e.name, e.title, d.depname
FROM department d JOIN emoloyee e JOIN salary s ON e.empid = s.empid AND e.depid  = d.depid WHERE s.basesalary  < 2000;

SELECT COUNT(*) FROM emoloyee e ; 
SELECT COUNT(*) FROM department d ; 

SELECT AVG(s.basesalary + s.titlesalary) AS 'avg_salary',
MAX(s.basesalary+s.titlesalary) AS 'highest_salary',
MIN(s.basesalary+s.titlesalary) AS 'min_salary'
FROM salary s ;

SELECT d.depid ,d.depname , AVG(s.basesalary + s.titlesalary) AS avg_salary
FROM department d JOIN salary s JOIN emoloyee e ON
e.empid = s.empid AND d.depid = e.depid GROUP BY e.depid 

SELECT d.depid ,d.depname , AVG(s.basesalary) AS avg_base_salary
FROM department d JOIN salary s JOIN emoloyee e ON
e.empid = s.empid AND d.depid = e.depid GROUP BY e.depid 
HAVING avg_base_salary < 2000; 

SELECT e.empid ,e.name, e.title ,s.basesalary, s.titlesalary, s.deduction 
FROM emoloyee e JOIN salary s ON 
e.empid = s.empid 
ORDER BY e.title ASC , s.basesalary ASC;

SELECT e.empid, e.name ,e.birthday ,(CASE 
WHEN YEAR(e.birthday) < 1980 THEN '老年'
WHEN YEAR(e.birthday) < 1990 THEN '中年'
ELSE '青年' END) AS 'age_group'
FROM emoloyee e ;

SELECT emp.*,depname
FROM emoloyee emp LEFT JOIN department dep
ON emp.`depid` = dep.`depid`;

SELECT dep.*,emp.*
FROM emoloyee emp RIGHT JOIN department dep
ON emp.`depid` = dep.`depid`;

SELECT COUNT(*) FROM emoloyee WHERE sex='男' AND title LIKE '%工程师%';

SELECT dep.depid, dep.depname ,sex,COUNT(*),AVG(basesalary)
FROM department dep INNER JOIN emoloyee e INNER JOIN salary
ON dep.depid = e.depid AND e.empid = salary.empid
GROUP BY dep.depid,sex;

CREATE DATABASE test_school;

USE test_school;

CREATE TABLE department(
dep_no int PRIMARY KEY ,
dep_name varchar(20) NOT NULL,
dep_note varchar(50)
)
CREATE TABLE teacher(
`number` int PRIMARY KEY ,
name varchar(30) NOT NULL,
sex varchar(4),
birth date,
dep_no int,
salary float,
address varchar(100),
CONSTRAINT fk_teacher_department_dep_no FOREIGN KEY (dep_no) REFERENCES department(dep_no)
)

DESC department;

INSERT INTO department(dep_no,dep_name, dep_note)
VALUES(
601, '软件技术系', '软件技术等专业'
),
(602, '网络技术系', '多媒体技术等专业'),
(603, '艺术设计系', '广告艺术设计等专业'),
(604, '管理工程系', '连锁经营管理等专业')

SELECT * FROM department;

INSERT INTO teacher(`number`,name, sex, birth, dep_no, salary, address)
VALUES (
2001, 'Tom', '女', '1970-01-10', 602, 4500, '四川省绵阳市'
),(
2002, 'Lucy', '男', '1983-12-18', 601, 2500, '北京市昌平区'
),
(2003, 'Mike', '男', '1990-06-01', 604, 1500, '重庆市渝中区'),
(2004, 'James', '女', '1980-10-20', 602, 3500, '四川省成都市'),
(2005, 'Jack', '男', '1975-05-30', 603, 1200, '重庆市南岸区')

SELECT * FROM teacher

DESC teacher

SELECT * FROM information_schema.table_constraints
WHERE table_name = 'teacher'

ALTER TABLE teacher DROP FOREIGN KEY fk_teacher_department_dep_no

SHOW INDEX FROM teacher

ALTER TABLE teacher DROP INDEX fk_teacher_department_dep_no

ALTER TABLE teacher ADD CONSTRAINT fk_teacher_department_dep_no FOREIGN KEY (dep_no)
REFERENCES department(dep_no) ON UPDATE CASCADE ON DELETE RESTRICT

SELECT t.`number` AS "教工号", d.dep_name AS "部门名称"
FROM teacher t JOIN department d ON d.dep_no = t.dep_no
WHERE t.address LIKE '%北京%'

SELECT t.`number` , t.name FROM 
teacher t WHERE t.salary =  (SELECT MAX(salary) FROM teacher)

SELECT t.`number`, t.name FROM teacher t ORDER BY t.salary DESC LIMIT 0,1; 

SELECT t.`number`, t.name FROM teacher t WHERE t.salary >= 2500 AND t.salary <= 4000;
SELECT t.`number`, t.name FROM teacher t WHERE t.salary BETWEEN 2500 AND 4000;

SELECT t.name, t.sex, t.salary FROM teacher t JOIN department d ON t.dep_no= d.dep_no WHERE d.dep_name = '网络技术系'

SELECT t.name, t.sex, t.salary FROM teacher t 
WHERE dep_no = (SELECT dep_no FROM department WHERE dep_name = '网络技术系')

CREATE DATABASE test_student;

USE test_student;

CREATE TABLE classes (
profession varchar(50),
class varchar(10),
name varchar(10),
sex varchar(1),
seat tinyint
)

ALTER TABLE classes MODIFY 
seat TINYINT UNSIGNED;

DESC classes;

INSERT INTO classes(profession, class, name, sex, seat)
VALUES (
'计算机网络', '1班', '张三', '男', 8
),
('软件工程', '2班','李四','男',12 ),
('计算机维护', '1班','王五','男', 9),
('计算机网络', '2班','LILY','女', 15),
('软件工程', '1班','小强','男', 20),
('计算机维护', '1班','CoCo','女', 18)

SELECT * FROM classes

CREATE TABLE score (name varchar(10), english TINYINT UNSIGNED, math TINYINT UNSIGNED, chinese TINYINT UNSIGNED)

DESC score;

INSERT INTO score (name, english, math, chinese)
VALUES 
('张三', 65, 75, 98),
('李四', 87, 45, 86),
('王五', 98, 85, 65),
('LILY',75 , 86, 87),
('小强', 85, 60, 58),
('CoCo', 96, 87, 70);

SELECT * FROM score;

CREATE TABLE records(
name varchar(10),
record varchar(4)
)

DESC records;

INSERT INTO records(name, record)
VALUES ('小强', '迟到'),
('小强', '事假'),
('李四', '旷课'),
('李四', '旷课'),
('李四', '迟到'),
('CoCo', '病假'),
('LILY', '事假')

SELECT * FROM records;

UPDATE  score
SET chinese = 88
WHERE name = '张三'

SELECT * FROM score

SELECT AVG(s.english) AS avg_en, AVG(s.math) AS avg_math, AVG(s.chinese) AS avg_chinese
FROM score s JOIN classes c ON c.name = s.name
WHERE c.profession = '计算机维护' AND c.class = '1班'

SELECT AVG(s.english) AS avg_en, AVG(s.math) AS avg_math, AVG(s.chinese) AS avg_chinese
FROM score s WHERE name IN (SELECT name FROM classes c WHERE c.profession = '计算机维护' AND c.class = '1班')

SELECT `name` FROM score WHERE english<60 OR math<60 OR chinese<60;

SELECT *
FROM score INNER JOIN
(SELECT `name`,COUNT(*) FROM records GROUP BY `name` HAVING COUNT(*)>2) temp
ON score.name = temp.name;

SELECT DATABASE(); 

SHOW tables;


SELECT * FROM score WHERE name IN (SELECT name FROM records r GROUP BY name HAVING COUNT(*) >2 )

CREATE DATABASE test_xuankedb;

USE test_xuankedb;

CREATE TABLE student(
sno int PRIMARY KEY ,
sname varchar(20),
ssex varchar(1),
sage TINYINT UNSIGNED ,
sdept varchar(30)
)

DESC student

DROP TABLE course

CREATE TABLE course(
cno int PRIMARY KEY ,
cname varchar(50),
cpno int,
ccredit TINYINT UNSIGNED
)

DESC course;

DROP TABLE sg;

CREATE TABLE sg(
sno int,
cno int,
grade TINYINT UNSIGNED,
CONSTRAINT pk_s_c PRIMARY KEY (sno, cno),
CONSTRAINT fk_stu_s_sno FOREIGN KEY (sno) REFERENCES student(sno),
CONSTRAINT fk_cou_s_sno FOREIGN KEY (cno) REFERENCES course(cno)
)

DESC SG;

ALTER TABLE student 
ADD COLUMN scome date;

SELECT s.Sno, s.Grade FROM 
SG s JOIN Course c ON s.Cno = c.Cpno 
WHERE c.Cpno = 3 ORDER BY s.Grade DESC ;

SELECT sno,grade FROM sg WHERE cno=3 ORDER BY grade DESC;

SELECT * FROM information_schema.table_constraints
WHERE table_name = 'sg'

SELECT MAX(grade),AVG(grade) FROM sg WHERE cno=1;

SELECT * FROM student WHERE sdept=(SELECT sdept FROM student WHERE sname='李洋') AND sname != '李洋';

UPDATE sg SET grade=0 WHERE sno IN (SELECT sno FROM student WHERE sdept='计算机系')

DELETE FROM student WHERE sno=05019;

DELETE FROM sg WHERE sno IN (SELECT sno FROM student WHERE sdept='计算机系');

# 清空表
TRUNCATE TABLE sg;  
DELETE FROM sg;

CREATE DATABASE test_library;

CREATE  TABLE press(
pressid int PRIMARY KEY,
pressname varchar(20),
address varchar(50)
)

CREATE TABLE sort(
sortno int,
scount int
)

CREATE TABLE book(
bid int,
bname varchar(50),
bsortno int,
pressid int
)

ALTER TABLE sort ADD COLUMN describes varchar(200);

DESC sort;

INSERT INTO press (pressid, pressname, address)
VALUES (100, '外研社', '上海'),
(101, '北大出版社', '北京'),
(102, '教育出版社', '北京')

SELECT * FROM press;

INSERT INTO sort(sortno, scount, describes)
VALUES (11, 50, '小说'),
(12, 300, '科幻'),
(13, 100, '神话')

SELECT * FROM sort;

DESC book;

INSERT INTO book(bid, bname, bsortno, pressid)
VALUES (1, '红与黑', 11, 100),
(2, '幻城', 12, 102),
(3,'希腊神话', 13, 102)

SELECT * FROM book;

SELECT * FROM book WHERE pressid = 100;

SELECT b.bid, b.bname, b.bsortno, b.pressid, p.pressname, p.address FROM 
book b JOIN press p ON b.pressid = p.pressid WHERE p.pressname = '外研社'











