create database D1;
USE D1;

CREATE TABLE SCHOOl1 (
s_NAME VARCHAR(50),
Location VARCHAR (60),
PHONE_NO_Email_Address varchar(60));

SET SESSION SQL_MODE = "";

load data infile
'C:/Top-Schools-Delhi-Schools-Directory-Dummy (1).csv'
into table school1
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from school1;

ALTER TABLE SCHOOL1
ADD COLUMN PHONE_NO VARCHAR(30),
ADD COLUMN EMAIL_ADDRESS VARCHAR(100);  

UPDATE SCHOOL1
SET 
PHONE_NO = CASE
WHEN PHONE_NO_Email_Address NOT LIKE '%@%' THEN PHONE_NO_Email_Address
ELSE NULL
END,
EMAIL_ADDRESS = CASE 
    WHEN PHONE_NO_Email_Address LIKE '%@%' THEN PHONE_NO_Email_Address
    ELSE NULL
END;

SELECT s_NAME,Location,
GROUP_CONCAT(CASE WHEN PHONE_NO IS NOT NULL THEN PHONE_NO END) AS PHONE_NO,
GROUP_CONCAT(CASE WHEN EMAIL_ADDRESS IS NOT NULL THEN EMAIL_ADDRESS END) AS EMAIL_ADDRESS
FROM SCHOOL1
GROUP BY s_NAME,Location ;

