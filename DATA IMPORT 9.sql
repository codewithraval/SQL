create database OR1;
USE OR1;

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

SELECT * FROM sales3 LIMIT 5;

ALTER TABLE SALES3
ADD COLUMN OREDER_DATE_NEW12 DATE AFTER ORDER_DATE;

UPDATE SALES3
SET OREDER_DATE_NEW12 = STR_TO_DATE(ORDER_DATE,'%m/%d/%Y');

SELECT STR_TO_DATE(ORDER_DATE,'%Y-%M-%D') FROM SALES3;
SET @@SESSION.SQL_MODE = 'ALLOW_INVALID_DATES';


SELECT
    CASE
        WHEN order_date LIKE '%-%' THEN STR_TO_DATE(order_date, '%m-%d-%Y')
        WHEN order_date LIKE '%/%' THEN STR_TO_DATE(order_date, '%m/%d/%Y')
        ELSE NULL
    END AS normalized_order_date
FROM SALES3;

UPDATE SALES3
SET ORDER_DATE_NEW =
CASE
		WHEN order_date LIKE '%-%' THEN STR_TO_DATE(order_date, '%m-%d-%Y')
        WHEN order_date LIKE '%/%' THEN STR_TO_DATE(order_date, '%m/%d/%Y')
	    ELSE NULL
END;

SELECT STR_TO_DATE(ORDER_DATE,'%d/%m/%Y') FROM SALES3;

SELECT STR_TO_DATE(ORDER_DATE,'%d/%m/%Y') FROM sales3;

SELECT STR_TO_DATE(ORDER_DATE"JANUARY 01 2011","%M %D %Y") FROM SALES3;

ALTER TABLE SALES3
ADD COLUMN ORDER_DATE_NEW DATE  AFTER ORDER_DATE;

UPDATE SALES3
SET ORDER_DATE_NEW = STR_TO_DATE(ORDER_DATE,'%m/%d/%Y');

UPDATE sales3 
SET ORDER_DATE_NEW = STR_TO_DATE(ORDER_DATE,'%m/%d/%Y');

ALTER TABLE SALES3
ADD COLUMN SHIP_DATE_NEW DATE  AFTER SHIP_DATE;

UPDATE SALES3
SET SHIP_DATE_NEW = STR_TO_DATE(SHIP_DATE,'%m/%d/%Y');

SELECT * FROM SALES3 WHERE SHIP_DATE_NEW = '2011-01-15';
SELECT * FROM SALES3 WHERE SHIP_DATE_NEW > '2011-01-15';
SELECT * FROM SALES3 WHERE SHIP_DATE_NEW < '2011-01-15';
SELECT * FROM SALES3 WHERE SHIP_DATE_NEW BETWEEN '2011-01-15' AND '2011-08-30';

SELECT NOW();
SELECT curdate();
SELECT CURTIME();

SELECT * FROM SALES3 WHERE SHIP_DATE_NEW < DATE_SUB(NOW() , INTERVAL 1 WEEK);


SELECT DATE_SUB(NOW() , INTERVAL 1 WEEK);
SELECT DATE_SUB(NOW() , INTERVAL 30 DAY);
SELECT DATE_SUB(NOW() , INTERVAL 30 YEAR);
SELECT YEAR(NOW());

SELECT DAYNAME('2025-9-20 21:10:30');

ALTER TABLE SALES3
ADD COLUMN FLAG DATE AFTER SHIP_DATE;

UPDATE SALES3
SET FLAG = curdate();
SELECT * FROM SALES3;

ALTER TABLE SALES3
ADD COLUMN YEAR_NEW INT;

ALTER TABLE SALES3
ADD COLUMN MONTH_NEW INT;

ALTER TABLE SALES3
ADD COLUMN DAY_NEW INT;

UPDATE SALES3 SET MONTH_NEW = MONTH(ORDER_DATE_NEW);
UPDATE SALES3 SET DAY_NEW = DAY(ORDER_DATE_NEW);
UPDATE SALES3 SET YEAR_NEW = YEAR(ORDER_DATE_NEW);


SELECT YEAR,SUM(SALES) FROM SALES3 GROUP BY YEAR;
SELECT YEAR,MIN(SALES) FROM SALES3 GROUP BY YEAR;
SELECT YEAR,MAX(SALES) FROM SALES3 GROUP BY YEAR;
SELECT YEAR,AVG(SALES) FROM SALES3 GROUP BY YEAR;

ALTER TABLE SALES3
ADD COLUMN CTC INT;

UPDATE SALES3 SET CTC = SALES*DISCOUNT + SHIPPING_COST;
SELECT * FROM SALES3;

SELECT ORDER_ID,DISCOUNT,IF(DISCOUNT >= 0,'YES','NO') AS D_FLAGS FROM SALES3;

SELECT MAX(SALES) FROM SALES3;

SELECT *,
CASE 
    WHEN SALES > 600 THEN "EXPENSIVE"
    WHEN SALES > 300 AND SALES < 600 THEN " BUGET "
    WHEN SALES < 300 THEN "CHEAP "
    ELSE "VERY EXPENSIVE"
END AS 'BUGET'
FROM SALES3;

SELECT TOP 2 * FROM SALES3;-- PERFORM ON SERVER
SELECT TOP 50 PERCENTAGE * FROM SALES3;-- PERFORM ON SERVER

SELECT PRODUCT_NAME FROM SALES3 WHERE PRODUCT_NAME LIKE "A%" OR PRODUCT_NAME LIKE "T%";

##--------------------------------------------------------------------------------------------------------------------------

## 2. We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre with
## the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where the
## maximum number of purchases is shared return all Genres  

WITH CountryGenreSales AS (
    SELECT
        c.Country,
        g.Name AS GenreName,
        SUM(il.Quantity) AS TotalPurchases,
        ROW_NUMBER() OVER (PARTITION BY c.Country ORDER BY SUM(il.Quantity) DESC) AS rn,
                COUNT(*) OVER (PARTITION BY c.Country, SUM(il.Quantity)) as num_shared_max
    FROM Customer c
    JOIN Invoice i ON c.Customer_Id = i.Customer_Id
    JOIN Invoice_Line il ON i.Invoice_Id = il.Invoice_Id
    JOIN Track t ON il.Track_Id = t.Track_Id
    JOIN Genre g ON t.Genre_Id = g.Genre_Id
    GROUP BY c.Country, g.Name
),
MaxSalesPerCountry AS (
  SELECT Country, MAX(TotalPurchases) as MaxPurchases from CountryGenreSales
  GROUP BY Country
)
SELECT cgs.Country, cgs.Genre_Name
FROM CountryGenreSales cgs
JOIN MaxSalesPerCountry msp ON cgs.Country = msp.Country
WHERE cgs.TotalPurchases = msp.MaxPurchases;

## 3. Write a query that determines the customer that has spent the most on music for each country. Write a query that returns
## the country along with the top customer and how much they spent. For countries where the top amount spent is shared, 
## provide all customers who spent this amount 

WITH CustomerTotalSpending AS (
    SELECT
        c.Country,
        c.FirstName || ' ' || c.LastName AS CustomerName,
        SUM(i.Total) AS TotalSpent,
        ROW_NUMBER() OVER (PARTITION BY c.Country ORDER BY SUM(i.Total) DESC) AS rn,
        COUNT(*) OVER (PARTITION BY c.Country, SUM(i.Total)) as num_shared_max
    FROM Customer c
    JOIN Invoice i ON c.CustomerId = i.CustomerId
    GROUP BY c.Country, c.CustomerId
),
MaxSpendingPerCountry AS (
  SELECT Country, MAX(TotalSpent) as MaxSpending from CustomerTotalSpending
  GROUP BY Country
)
SELECT cts.Country, cts.CustomerName, cts.TotalSpent
FROM CustomerTotalSpending cts
JOIN MaxSpendingPerCountry msp ON cts.Country = msp.Country
WHERE cts.TotalSpent = msp.MaxSpending;