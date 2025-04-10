CREATE DATABASE cust_data;
USE cust_data;
SHOW TABLES;

-- Q1 
SELECT 
    c.CUST_CODE,c.CUST_NAME,a.AGENT_NAME,c.OUTSTANDING_AMT
FROM 
    Customer c
JOIN 
    Agents a ON c.AGENT_CODE = a.AGENT_CODE;
    
-- Q2    
    SELECT 
    o.AGENT_CODE,a.AGENT_NAME,SUM(o.ORD_AMOUNT) AS total_order_amount
FROM 
    Orders o
JOIN 
    Agents a ON o.AGENT_CODE = a.AGENT_CODE
GROUP BY 
    o.AGENT_CODE, a.AGENT_NAME
HAVING 
    total_order_amount > 10000;
    
-- Q3
CREATE VIEW order_details_view AS
SELECT 
    o.ORD_NUM,o.ORD_DATE,c.CUST_NAME,a.AGENT_NAME
FROM 
    orders o
JOIN 
    customer c ON o.CUST_CODE = c.CUST_CODE
JOIN 
    agents a ON o.AGENT_CODE = a.AGENT_CODE;

SELECT * FROM order_details_view;

-- Q4
SELECT o.*
FROM orders o
JOIN customer c ON o.CUST_CODE = c.CUST_CODE
WHERE c.CUST_CITY = 'New York';

-- Q5
SELECT a.AGENT_CODE,a.AGENT_NAME,COUNT(o.ORD_NUM) AS Total_Orders
FROM agents a
LEFT JOIN orders o ON a.AGENT_CODE = o.AGENT_CODE
GROUP BY a.AGENT_CODE, a.AGENT_NAME
ORDER BY Total_Orders DESC;

-- Q6
SELECT c.CUST_CODE,c.CUST_NAME,c.CUST_CITY,c.WORKING_AREA,c.CUST_COUNTRY,c.PHONE_NO AS Customer_Phone,
    o.ORD_NUM,o.ORD_AMOUNT,o.ADVANCE_AMOUNT
FROM customer c
JOIN orders o ON c.CUST_CODE = o.CUST_CODE
WHERE o.ADVANCE_AMOUNT >= 0.5 * o.ORD_AMOUNT
ORDER BY c.CUST_NAME;

-- Q7
select CUST_CITY, count(CUST_CODE) as number_of_customers,
sum(OUTSTANDING_AMT) as total_outstanding_amount from customer
group by CUST_CITY;

-- Q8
select c.CUST_CODE, 
       c.CUST_NAME, 
       c.CUST_CITY, 
       o.ORD_NUM, 
       o.ORD_DATE, 
       o.ORD_AMOUNT
from customer c left join orders o on c.CUST_CODE = o.CUST_CODE order by c.CUST_CODE;

-- Q9
select cust_code,ORD_AMOUNT
from orders
where ORD_AMOUNT =(SELECT MAX(ORD_AMOUNT)FROM ORDERS);

-- Q10
SELECT CUST_CODE, SUM(ORD_AMOUNT) AS TOTAL_ORD_AMOUNT 
FROM orders 
WHERE CUST_CODE IN (SELECT CUST_CODE FROM orders GROUP BY CUST_CODE HAVING COUNT(*) > 2) 
GROUP BY CUST_CODE;

-- Q11
select * from orders
where MONTH(ord_date) = 5 AND YEAR(ord_date) = 2008;

-- Q12
 select  * from orders
where ord_amount > 1000 or ord_date < '2008-12-31';

-- Q13
SELECT o.*
FROM orders o
JOIN customer c ON o.CUST_CODE = c.CUST_CODE
WHERE c.CUST_CITY = 'New York' 
   OR o.ORD_AMOUNT > 5000;

-- Q14
SELECT a.AGENT_CODE,a.AGENT_NAME,COUNT(DISTINCT o.CUST_CODE) AS Total_Customers
FROM agents a
JOIN orders o ON a.AGENT_CODE = o.AGENT_CODE
GROUP BY a.AGENT_CODE, a.AGENT_NAME
HAVING COUNT(DISTINCT o.CUST_CODE) > 3
ORDER BY Total_Customers DESC;

-- Q15
SELECT CUST_CODE, CUST_NAME, PAYMENT_AMT, OUTSTANDING_AMT
FROM customer
WHERE PAYMENT_AMT > 0
  AND OUTSTANDING_AMT > 7000;
    
    

