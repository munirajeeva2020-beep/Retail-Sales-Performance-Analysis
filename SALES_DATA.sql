create database sales_data;
use sales_data;
select*from categories;
select*from customers;
select*from order_items;
select*from orders;
select*from products;
select*from staffs;
select*from stocks;
select*from stores;

-- INNER JOIN

SELECT 
    od.order_id,
    od.order_date,
    pd.product_name,
    oi.quantity,
    oi.list_price,
    oi.discount,
    oi.sales
FROM orders od
INNER JOIN order_items oi
    ON od.order_id = oi.order_id
INNER JOIN products pd
    ON oi.product_id = pd.product_id;
    SELECT * FROM orders;
    
    -- Total Sales by Store
    
select store_id,
SUM(oi.sales) as total_sales
from orders od
inner join order_items oi
ON od.order_id=oi.order_id
group by od.store_id;

-- Top 5 Selling Products

SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM order_items oi
INNER JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- 6 Customer Purchase Summary

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity) AS total_items,
    SUM(oi.sales) AS total_revenue
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.customer_id, customer_name;

-- 7 Segment Customers by Total Spend

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(oi.sales) AS total_spend,
    CASE
        WHEN SUM(oi.sales) < 5000 THEN 'Low'
        WHEN SUM(oi.sales) BETWEEN 5000 AND 10000 THEN 'Medium'
        ELSE 'High'
    END AS spending_category
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.customer_id, customer_name;

-- 8 Staff Performance Analysis

SELECT
    s.staff_id,
    CONCAT(s.first_name, ' ', s.last_name) AS staff_name,
    SUM(oi.sales) AS total_revenue
FROM staffs s
INNER JOIN orders o
ON s.staff_id = o.staff_id
INNER JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY s.staff_id, staff_name;

-- 9 Stock Alert Query

SELECT
    s.store_id,
    p.product_name,
    s.quantity
FROM stocks s
INNER JOIN products p
ON s.product_id = p.product_id
WHERE s.quantity < 10;

-- 10 Create Customer Segmentation Table

CREATE TABLE customer_segments (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    total_spend DECIMAL(10,2),
    segment VARCHAR(20)
);

SELECT * FROM customer_segments;

SELECT USER();
SELECT CURRENT_USER();

SELECT name
FROM sys.sql_logins;

