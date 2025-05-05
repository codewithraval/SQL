create DATABASE UD;
USE UD;


CREATE TABLE sales3 (
order_id VARCHAR(15),
order_date VARCHAR(15) NOT NULL,
ship_date VARCHAR(15) NOT NULL,
ship_mode varchar (14) NOT NULL,
customer_name VARCHAR(22) NOT NULL,
segment VARCHAR (11) NOT NULL,
state VARCHAR(36) NOT NULL,
country VARCHAR(32) NOT NULL,
market VARCHAR(6) NOT NULL,
region VARCHAR(14) NOT NULL,
product_id VARCHAR(16) NOT NULL,
category VARCHAR(15) NOT NULL,
sub_category VARCHAR(11) NOT NULL,
product_name VARCHAR(127) NOT NULL,
sales DECIMAL(38,0) NOT NULL,
quantity DECIMAL(38,0) NOT NULL,
discount DECIMAL(38,3) NOT NULL,
profit DECIMAL(38,8) NOT NULL,
shipping_cost DECIMAL(38,2) NOT NULL,
order_priority VARCHAR(8) NOT NULL,
`YEAR` DECIMAL(38,0) NOT NULL
);


SET SESSION SQL_MODE = "";

load data infile
'C:/sales_data_final (1).csv'
into table sales3
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;


SELECT quantity,ADD_TO_COLUMN(quantity) FROM SALES3;

DELIMITER $$
CREATE FUNCTION ADD_TO_COLUMN (A INT)
RETURNS int
DETERMINISTIC
BEGIN
     DECLARE B INT;
     SET B = A + 20;
     RETURN B;
END;

SELECT ADD_TO_COLUMN(10);
CREATE TABLE TEST(
A INT);

INSERT INTO TEST VALUE(10)
INSERT INTO TEST VALUE(20)
INSERT INTO TEST VALUE(30)
INSERT INTO TEST VALUE(40)
INSERT INTO TEST VALUE(50)

SELECT A,ADD_TO_COLUMN(A) FROM TEST;

DELIMITER $$
CREATE FUNCTION FINAL_PROFITS (PROFIT INT , DISCOUNT INT )
RETURNS int 
DETERMINISTIC
BEGIN
     DECLARE FINAL_PROFIT INT;
     SET FINAL_PROFIT = PROFIT - DISCOUNT ;
     RETURN FINAL_PROFIT;
END;

SELECT DISCOUNT,PROFIT,FINAL_PROFITS(DISCOUNT,PROFIT) FROM SALES3;

DELIMITER $$
CREATE FUNCTION FINAL_PROFITS_REAL (PROFIT DECIMAL (20,4) , DISCOUNT DECIMAL (10,4) ,SALES DECIMAL(10,4) )
RETURNS int 
DETERMINISTIC
BEGIN
     DECLARE FINAL_PROFIT INT;
     SET FINAL_PROFIT = PROFIT - SALES * DISCOUNT ;
     RETURN FINAL_PROFIT;
END;

SELECT DISCOUNT,PROFIT,SALES,FINAL_PROFITS_REAL(DISCOUNT,PROFIT,SALES) AS "FINAL PROFIT" FROM SALES3;

SELECT * FROM SALES3;

DELIMITER $$
CREATE FUNCTION MARK_SALES (SALES INT)
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
     DECLARE FLAG_SALES VARCHAR(30);
     IF SALES <=100 THEN
     SET FLAG_SALES = "SUPER ADDORTABLE PRODUCT" ;
     ELSEIF SALES >100 AND SALES < 300 then
     SET FLAG_SALES = "AFFORTABLE" ;
     ELSEIF SALES > 300 AND SALES < 600 then
     SET FLAG_SALES = "MODRATE PRICE" ;
     ELSE
     SET FLAG_SALES = "EXPENSIVE";
     END IF ;
     RETURN FLAG_SALES;
END;

select sales,mark_sales(sales) from sales3;


CREATE TABLE LOOP_TABLE(VAL INT)

DELIMITER $$
CREATE PROCEDURE INSER_DATA()
BEGIN
SET @VAR = 10 ;
GENERATE_DATA : LOOP
INSERT INTO LOOP_TABLE VALUES (@VAR);
SET @VAR = @VAR + 1 ;
IF @VAR = 100 THEN 
 LEAVE GENERATE_DATA ;
 END IF ;
 END LOOP GENERATE_DATA ;
 END $$
 
 CALL INSER_DATA();
 
 SELECT * FROM LOOP_TABLE;
 
 create table employees(
 first_name varchar(50),
 last_name varchar (50),
 age int,
 department varchar (30),
 salary decimal (10,2));
 
 
 INSERT INTO employees (first_name, last_name, age, department, salary)
VALUES
('John', 'Doe', 30, 'HR', 50000.00),
('Jane', 'Smith', 27, 'IT', 60000.00),
('Mike', 'Brown', 35, 'Finance', 75000.00),
('Sara', 'Johnson', 29, 'Marketing', 55000.00),
('David', 'White', 40, 'Sales', 80000.00),
('Emily', 'Taylor', 32, 'IT', 62000.00),
('Brian', 'Adams', 45, 'Finance', 90000.00),
('Sophia', 'Clark', 26, 'HR', 48000.00),
('James', 'Lewis', 38, 'Marketing', 72000.00),
('Olivia', 'Walker', 29, 'IT', 64000.00),
('Ethan', 'Harris', 31, 'Finance', 78000.00),
('Ava', 'Martin', 27, 'Sales', 55000.00),
('William', 'Thompson', 35, 'IT', 70000.00),
('Mia', 'Anderson', 28, 'HR', 52000.00),
('Benjamin', 'Thomas', 37, 'Marketing', 75000.00),
('Charlotte', 'Robinson', 30, 'Finance', 81000.00);


select * fROM EMPLOYEES;

DELIMITER $$
CREATE FUNCTION FULL_NAME (C VARCHAR(100))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
     DECLARE C VARCHAR(100);
     SET C = FIRST_NAME + LAST_NAME;
     RETURN C;
END;

SELECT FIRST_NAME,LAST_NAME,FULL_NAME(FIRST_NAME,LAST_NAME) FROM EMPLOYEES;

DELIMITER $$
CREATE FUNCTION FULL_NAME2 (FIRST_NAME VARCHAR(100),LAST_NAME VARCHAR (50))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
     DECLARE FULL_NAME  VARCHAR(100);
     SELECT  CONCAT(FIRST_NAME,"  ", LAST_NAME)INTO FULL_NAME FROM EMPLOYEES;
     RETURN FULL_NAME;
END$$;
DELIMITER ;


SELECT FIRST_NAME,LAST_NAME,FULL_NAME3(FIRST_NAME,LAST_NAME) FROM EMPLOYEES;


DELIMITER $$
CREATE FUNCTION FULL_NAMES (FIRST_NAME VARCHAR(100),LAST_NAME VARCHAR (50))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
     DECLARE FULL_NAME  VARCHAR(100);
     SELECT FULL_NAME =  CONCAT(FIRST_NAME,'', LAST_NAME);
     RETURN FULL_NAME;
END$$;
DELIMITER ;



SELECT * FROM EMPLOYEES;


DELIMITER $$
CREATE FUNCTION YEAR_SALARY (MONTHLY_SALARY DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE MONTHLY_SALARY  decimal(10,2);
     SELECT MONTHLY_SALARY =   SALARY * 12 ;
     RETURN MONTHLY_SALARY;
    
END;

SELECT FIRST_NAME,LAST_NAME,YEAR_SALARY(SALARY) AS "FULL SALARY" FROM EMPLOYEES;

SELECT * FROM EMPLOYEES;

DELIMITER $$
CREATE FUNCTION MARK_AGE1 (AGE INT)
RETURNS VARCHAR (30)
DETERMINISTIC
BEGIN
     DECLARE MARK_AGE INT;
     IF MARK_AGE >10  THEN
     SET MARK_AGE = "CHILD" ;
     ELSEIF MARK_AGE >15 AND MARK_AGE < 20 then
     SET MARK_AGE = "BOY" ;
     ELSEIF MARK_AGE > 20 AND MARK_AGE < 30 then
     SET MARK_AGE = " ADULT" ;
	 ELSEIF MARK_AGE > 40 AND MARK_AGE < 50 then
     SET MARK_AGE = "  MATURE ADULT" ;
      ELSEIF MARK_AGE > 60 AND MARK_AGE < 70 then
     SET MARK_AGE = " SINOR CITIZEN" ;
     ELSE
     SET MARK_AGE = "OLD AGE";
     END IF ;
     RETURN AGE;
END;

CALL MARK_AGE1(60)

SELECT AGE,MARK_AGE1(AGE) AS E_AGE FROM EMPLOYEES;


DELIMITER && 
CREATE function age_category(emp_age int)
returns VARCHAR(30)
deterministic
begin
declare category VARCHAR(30);
IF emp_age < 25 then 
	SET category = "young";
elseif emp_age between 25 and 35 THEN 
	SET category = "Young adults";
elseif emp_age between 36 and 50 THEN
	SET category = "Middle-aged adults:";    
else
	SET category = "Senior adults" ;
END IF;
return category;
END;
&&
delimiter ;

drop function age_category;

select first_name, last_name, age, age_category(age) as age_category from employees;
select * from employees;


/by using if and else/
DELIMITER && 
CREATE function age_category_new(age int)
returns VARCHAR(30)
deterministic
begin
declare age_category VARCHAR(30);
IF age <= 30 then 
	SET age_category = "young";
elseif age > 31 AND age <= 35 THEN 
	SET age_category = "Young adults";
elseif age > 36 AND age <= 40 THEN 
	SET age_category = "Middle-aged adults";    
else
	SET age_category = "Senior adults" ;
END IF;
return FLAG_SALES;
END &&

select age_category(age) as age_category_column from employees;


select first_name,department from employees where department = (select department from employees group by department);

delimiter $$
create function get_department(emp_id int)
returns varchar (50)
deterministic
begin 
    declare dept varchar(50);
    select department into dept from employees where id = emp_id;
    return dept;
end$$
delimiter ;


select get_department(id),id from employees;



delimiter $$
create function get_salary3 (salary decimal(10,2))
returns decimal(10,2)
deterministic
begin 
    declare total_salary decimal(10,2);
    set total_salary = salary * 0.10;
    return total_salary;
end$$
delimiter ;

select first_name,get_salary3(salary) as bonas from employees;

delimiter $$
create function get_salary4 (salary decimal(10,2))
returns varchar (50)
deterministic
begin 
    declare eligible varchar (10);
    
    if salary > 70000 THEN 
        set eligible = "yes" ;
    else 
    set total_salary = "NO";
    end if;
    return eligible;
end$$
delimiter ;


SELECT * FROM EMPLOYEES;
SELECT LAST_NAME,get_salary4(SALARY) AS E_SALARY FROM EMPLOYEES;

DELIMITER $$
CREATE FUNCTION DEP_COUNT1 (DEPT_NAME VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE DEP_COUNT INT ;
     SELECT COUNT(*) INTO DEP_COUNT FROM EMPLOYEES WHERE DEPARTMENT = DEPT_NAME;
     RETURN DEP_COUNT;
    
END;

SELECT DEPARTMENT,DEP_COUNT1(DEPARTMENT) AS COUNT_EMP FROM EMPLOYEES;

SELECT AVG(SALARY),DEPARTMENT AS A 
FROM EMPLOYEES 
GROUP BY A;

DELIMITER $$
CREATE FUNCTION DEP_AVG2 (DEPT_NAME VARCHAR(50))
RETURNS DECIMAL (10,2)
DETERMINISTIC
BEGIN
    DECLARE AVG_SALARY DECIMAL (10,2) ;
     SELECT AVG(SALARY) INTO AVG_SALARY FROM EMPLOYEES WHERE DEPARTMENT = DEPT_NAME;
     RETURN AVG_SALARY;
    
END;

SELECT DEP_AVG2("IT")

DELIMITER $$
CREATE FUNCTION DEP_MAX (DEPT_NAME VARCHAR(50))
RETURNS DECIMAL (10,2)
DETERMINISTIC
BEGIN
    DECLARE AVG_SALARY DECIMAL (10,2) ;
     SELECT MAX(SALARY) INTO AVG_SALARY FROM EMPLOYEES WHERE DEPARTMENT = DEPT_NAME;
     RETURN AVG_SALARY;
    
END;

SELECT DEP_MAX("IT")


DELIMITER && 
CREATE function SAL_GREAD1(SALARY DECIMAL (10,2))
returns VARCHAR(30)
deterministic
begin
declare SAL_GRADE VARCHAR(30);
IF SALARY >= 90000 then 
	SET SAL_GRADE = "A";
elseif SALARY BETWEEN 75000 AND 89999 THEN 
	SET SAL_GRADE = "B";
elseif SALARY BETWEEN 60000 AND 74999 THEN 
	SET SAL_GRADE = "C";   
elseif SALARY BETWEEN 45000 AND 59999 THEN 
	SET SAL_GRADE = "D";   
else
	SET SAL_GRADE = "E" ;
END IF;
return SAL_GRADE;
END &&

SELECT SALARY,SAL_GREAD1(SALARY) AS SAL_GRADE FROM EMPLOYEES;