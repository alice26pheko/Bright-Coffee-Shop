-- Databricks notebook source

--TABLE OVERVIEW
SELECT* FROM `workspace`.`default`.`coffee_shop`;

-- DATA INSPECTION
SELECT COUNT(*) FROM `workspace`.`default`.`coffee_shop`;

--To find different store locations, product categories, and product types
SELECT DISTINCT store_location, product_category, product_type
FROM `workspace`.`default`.`coffee_shop`;

--To get the operating time
SELECT store_id, store_location, MIN(transaction_date) AS earliest_time, MAX(transaction_date) AS latest_time
FROM `workspace`.`default`.`coffee_shop`
GROUP BY ALL;

--Understanding the min price and max price
SELECT min(unit_price) AS lowest_price, MAX(unit_price) AS highest_price
FROM `workspace`.`default`.`coffee_shop`;

--To get to the revenue for the past six months
SELECT SUM(unit_price* transaction_qty) AS total_revenue
FROM `workspace`.`default`.`coffee_shop`;


--Extracting the day, month and time

SELECT 
transaction_date,
transaction_id,
transaction_time,
transaction_qty,
store_location,
unit_price,
product_category,
product_type,
product_detail,
SUM(unit_price* transaction_qty) AS total_revenue,
count(transaction_id) AS totalsales,



date_format (transaction_date, 'EEEE') AS dayname,
    CASE WHEN date_format (transaction_date, 'EEEE') IN ('Saturday', 'Sunday') THEN 'Weekend'
    ELSE 'Weekday' END AS daytype, 
    
  

date_format (transaction_date, 'MMMM') AS monthname, 
CASE WHEN date_format (transaction_date, 'MMMM') IN ('January','February') THEN 'Summer'
    WHEN date_format (transaction_date, 'MMMM') IN ('March','April') THEN 'Automn'
    WHEN date_format (transaction_date, 'MMMM') IN ('May','June') THEN 'Winter'
    END AS seasons,

  CASE WHEN month(transaction_date) IN (1,2,3) THEN 'Q1'
    WHEN month(transaction_date) IN (4,5,6) THEN 'Q2'
   END as quarterly,

   CASE WHEN month(transaction_date) between 1 and 10 THEN 'Start month'
    WHEN month(transaction_date) between 11 and 20 THEN 'Mid month'
    ELSE 'End month'
    END AS monthcategoty,

      
    date_format (transaction_time, 'HH:mm:ss') AS purchasetime,
CASE WHEN date_format (transaction_time, 'HH:mm:ss') BETWEEN '00:00:00' AND '05:59:59' THEN 'Early Morning 12am -5am'
    WHEN date_format (transaction_time, 'HH:mm:ss') BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning 6am - 11am'
    WHEN date_format (transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon 12pm - 5pm'
    WHEN date_format (transaction_time, 'HH:mm:ss') BETWEEN '18:00:00' AND '21:59:59' THEN 'Evening 6pm - 9pm'
    ELSE 'Night 10pm - 11:59pm'
    END AS timeofday


FROM `workspace`.`default`.`coffee_shop`
GROUP BY ALL;
