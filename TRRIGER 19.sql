CREATE DATABASE TRIGGER_2;
USE TRIGGER_2;

create table course(
course_id int,
course_desc varchar(50),
course_mentor varchar(60),
course_price int,
course_discount int,
create_date date,
user_info varchar(50));

SELECT USER();
SELECT SYSDATE();

create table ref_course (
record_date date,
record_user varchar(50))

# before_insert


delimiter //
create trigger course_before_insert
before insert
on course for each row
begin
      declare user_val varchar(50);
      set new.create_date = sysdate();
      select user() into user_val;
      set new.user_info = user_val;
      insert into ref_course values (sysdate() , user_val);
end; //

insert into course (course_id,course_desc,course_mentor,course_price,course_discount)
value(101,'fsda','BHARGAV',1000,10);

SELECT * FROM ref_course;
SELECT * FROM course;

CREATE TABLE TEST1(
C1 VARCHAR (50),
C2 DATE,
C3 INT);

CREATE TABLE TEST2(
C1 VARCHAR (50),
C2 DATE,
C3 INT);

CREATE TABLE TEST3(
C1 VARCHAR (50),
C2 DATE,
C3 INT);

delimiter //
create trigger TEST_before_insert
before insert
on TEST1 for each row
begin
      INSERT INTO TEST2 VALUES ('BHARGAV',sysdate(),12345);
      INSERT INTO TEST3 VALUES ('BHARGAV',sysdate(),12345);

      
end; //


INSERT INTO TEST1 VALUES ("BHAVIK",SYSDATE(),1);


SELECT * FROM TEST1;
SELECT * FROM TEST2;
SELECT * FROM TEST3;


# AFTER INSERT

INSERT INTO TEST2 VALUES ("BHAVIK",SYSDATE(),1);
INSERT INTO TEST3 VALUES ("BHAVIK",SYSDATE(),1);

delimiter //
create trigger TO_UPADATE_OTHER_TABLE
AFTER insert
on TEST1 for each row
begin
      UPDATE TEST2 SET C1 = "BHAI" WHERE C1 = "BHAVIK";
      DELETE FROM TEST3 WHERE C1 = "BHAVIK";
      
end; //


INSERT INTO TEST1 VALUES ("HARSH",SYSDATE(),851199);

SELECT * FROM TEST1;
SELECT * FROM TEST2;
SELECT * FROM TEST3;


# AFTER DELETE

delimiter //
create trigger TO_DELETE_OTHER_TABLE
AFTER DELETE 
on TEST1 for each row
begin
      INSERT INTO TEST3 VALUES ("AFTER DELETE",SYSDATE(),99999);
      
end; //

DELETE FROM TEST1 WHERE C1="HARSH";

SELECT * FROM TEST1;
SELECT * FROM TEST2;
SELECT * FROM TEST3;

# BEFORE DELETE

delimiter //
create trigger TO_DELETE_OTHER_BEFORE
BEFORE DELETE 
on TEST1 for each row
begin
      INSERT INTO TEST3 VALUES ("BEFORE DELETE",SYSDATE(),9866999);
      
end; //

SELECT * FROM TEST1;
SELECT * FROM TEST2;
SELECT * FROM TEST3;

DELETE FROM TEST1 WHERE C1="HARSH";

DROP TRIGGER TO_DELETE_OTHER_BEFORE2;
delimiter //
create trigger TO_DELETE_OTHER_BEFORE2
BEFORE DELETE 
on TEST1 for each row
begin
      INSERT INTO TEST2(C1,C2,C3) VALUES (OLD.C1,OLD.C2,OLD.C3);
      
end; //

SELECT * FROM TEST1;
SELECT * FROM TEST2;
SELECT * FROM TEST3;

DELETE FROM TEST1 WHERE C3='1';

INSERT INTO TEST1 VALUES ("HARSH",SYSDATE(),851199);

# AFTER UPDATE

delimiter //
create trigger TO_UPDATE_OTHER
AFTER UPDATE
on TEST1 for each row
begin

      INSERT INTO TEST3(C1,C2,C3) VALUES ("X",SYSDATE(),789);
      
end; //

UPDATE TEST1 SET C1 = "BHARGAV" WHERE C1 = "HARSH";

SELECT * FROM TEST1;
SELECT * FROM TEST3;

# BEFORE DELETE

delimiter //
create trigger TO_BEFORE_OTHER
BEFORE UPDATE
on TEST1 for each row
begin

      INSERT INTO TEST2(C1,C2,C3) VALUES (NEW.C1,NEW.C2,NEW.C3);
      
end; //


UPDATE TEST1 SET C1 = "RAM" WHERE C1 = "HARSH";


SELECT * FROM TEST1;
SELECT * FROM TEST2;


CREATE TABLE EMPLOYEES(
ID INT AUTO_INCREMENT PRIMARY KEY,
NAME VARCHAR (100) NOT NULL,
AGE INT NOT NULL,
DEPARTMENT VARCHAR(50),
SALARY DECIMAL(10,2),
ROLE VARCHAR(50),
HIRE_DATE DATE );

INSERT INTO EMPLOYEES (NAME,AGE,DEPARTMENT,SALARY,ROLE,HIRE_DATE) VALUE ("BHARGAV",21,"IT",40000.00,"DATA ANALYSIS",SYSDATE())


SELECT * FROM EMPLOYEES;

delimiter //
create trigger before_insert
before insert
on EMPLOYEES for each row
begin
     IF NEW.SALARY < 0 THEN 
     SET NEW.SALARY = 0;
     END IF;
end //


INSERT INTO EMPLOYEES (NAME,AGE,DEPARTMENT,SALARY,ROLE,HIRE_DATE) VALUE ("BHAVIK",21,"IT",-40000.00,"DATA ANALYSIS",SYSDATE());



#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE BR (
NAME VARCHAR (300),
MAIL_ID VARCHAR (50),
PHONE_NUMBER INT,
ADDRESS VARCHAR (70),
USERS_SYS VARCHAR (50),
TIME_SYS VARCHAR (50),
SALARY DECIMAL (10,2),
INCENTIVE DECIMAL (10,2),
FINAL_SALARY DECIMAL (10,2));




DELIMITER //
CREATE TRIGGER enforce_name_and_calculate_salary
BEFORE INSERT ON BR
FOR EACH ROW
BEGIN
     declare user_val1 varchar(30);
     set new.TIME_SYS = sysdate();
     select user() into user_val1;
     set new.USERS_SYS = user_val1;
    IF LEFT(NEW.Name, 1) = 'S' THEN
SET NEW.Final_Salary = NEW.Salary + NEW.Incentive;
    END IF;    
END; //



INSERT INTO BR (Name, MAIL_ID, Phone_Number, Address, Salary, Incentive)
VALUES ('Sam', 'sam@example.com', '1234567890', '123 Main St', 50000, 5000);

INSERT INTO BR (Name, Mail_ID, Phone_Number, Address, Salary, Incentive)
VALUES ('John', 'john@example.com', '0987654321', '456 Elm St', 45000, 4500);

INSERT INTO BR (Name, Mail_ID, Phone_Number, Address, Salary, Incentive)
VALUES ('suhani', 'suhani@example.com', '8587654321', '456 Elm St', 45000, 5500);

 
# 2._---------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM BR;

CREATE TABLE B (
NAME VARCHAR (300),
MAIL_ID VARCHAR (50),
PHONE_NUMBER varchar (50),
ADDRESS VARCHAR (70),
USERS_SYS VARCHAR (50),
TIME_SYS VARCHAR (50),
SALARY DECIMAL (10,2),
INCENTIVE DECIMAL (10,2),
FINAL_SALARY DECIMAL (10,2));

delimiter //
create trigger TO_INSERT1_OTHER_TABLE
AFTER insert
on BR for each row
begin
      
      INSERT INTO B (NAME,MAIL_ID,PHONE_NUMBER,ADDRESS,USERS_SYS,TIME_SYS,SALARY,INCENTIVE,FINAL_SALARY)
      VALUES ("BHARGAV","bHrgv@gmail.com",8511991051,"BHAVNAGAR",USER(),SYSDATE(),50000,5000,55000);
      
end; //


INSERT INTO BR 
VALUES ('BHARGAV', 'bhrgv@example.com', '1511654321', '456 Elm St',USER(),SYSDATE(), 45000, 5000,50000);



SELECT * FROM BR;
SELECT * FROM B;

# 3,--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

delimiter //
create trigger TO_BEFORE_UPDATE
BEFORE UPDATE
on BR for each row
begin
      IF NEW.SALARY < OLD.SALARY * 1.05 THEN
      SET NEW.SALARY = OLD.SALARY * 1.05;
      END IF;
      
end; //

UPDATE BR SET SALARY = 35000 WHERE SALARY = 50000;

# 4.---------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE B1 (
B_ID INT,
OLD_SALARY DECIMAL (10,2),
NEW_SALARY DECIMAL (10,2),
B_DATE VARCHAR (100));

SELECT NOW();

delimiter //
create trigger TO_AFTER_UPDATE
after UPDATE
on BR for each row
begin
      INSERT INTO B1 (B_ID , OLD_SALARY,NEW_SALARY,B_DATE)
      VALUE (OLD.id,OLD.SALARY,NEW.SALARY,NOW());
      
end; //

UPDATE BR SET SALARY = 65000 WHERE SALARY = 45000;

select * from br;

select * FROM B1;
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------

delimiter //
create trigger TO_BEFORE_DELETE
BEFORE DELETE 
on BR for each row
begin
      IF OLD.NAME = "BHARGAV" THEN 
      SIGNAL SQLSTATE "65000"
      SET MESSAGE_TEXT = "CANNOTE DELETED CEO!";
      END IF;
end; //


#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

delimiter //
create trigger TO_AFTER_DELETE
AFTER DELETE 
on BR for each row
begin
      INSERT INTO B2 (B_ID ,ACTION,B_DATE)
      VALUE (OLD.id,"DELETE",NOW());
end; //

CREATE TABLE B2 (
B_ID INT,
ACTION VARCHAR (20),
B_DATE VARCHAR (50));
