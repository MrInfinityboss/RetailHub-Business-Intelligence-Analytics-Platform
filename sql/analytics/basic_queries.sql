-- =====================================================
-- Enterprise Retail Data Warehouse
-- File: 01_basic_queries.sql
-- Description:
-- Basic SQL queries for data exploration and reporting.
-- =====================================================

SET search_path TO retailhub;

-- =====================================================
-- Product Analysis
-- =====================================================

-- 1. Display all products
SELECT * FROM products;

-- 2. Display product names with selling prices
SELECT product_name, selling_price
FROM products;

-- 3. Display active products
SELECT product_id, product_name, status
FROM products
WHERE status = 'Active';

-- 4. Display products with selling price greater than ₹1000
SELECT product_name, selling_price
FROM products
WHERE selling_price > 1000;

-- 5. Top 10 most expensive products
SELECT product_name, selling_price
FROM products
ORDER BY selling_price DESC
LIMIT 10;

-- =====================================================
-- Customer Analysis
-- =====================================================

-- 6. Display all customers
SELECT *
FROM customers;

-- 7. Customers belonging to Gold membership
SELECT customer_id,
       first_name,
       last_name,
       membership_level
FROM customers
WHERE membership_level = 'Gold';

-- 8. Customers from Delhi
SELECT *
FROM customers
WHERE city = 'Delhi';

-- 9. Count total customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- 10. Display customer names with city and state
SELECT first_name,
       last_name,
       city,
       state
FROM customers;

-- =====================================================
-- Order Analysis
-- =====================================================

-- 11. Display all completed orders
SELECT *
FROM orders
WHERE order_status = 'Completed';

-- 12. Display latest 20 orders
SELECT *
FROM orders
ORDER BY order_date DESC
LIMIT 20;

-- 13. Count total orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- 14. Display orders placed through Online channel
SELECT *
FROM orders
WHERE sales_channel = 'Online';

-- 15. Display unique sales channels
SELECT DISTINCT sales_channel
FROM orders;

-- =====================================================
-- Inventory Analysis
-- =====================================================

-- 16. Products below reorder level
SELECT inventory_id,
       warehouse_id,
       product_id,
       stock_quantity,
       reorder_level
FROM inventory
WHERE stock_quantity < reorder_level;

-- 17. Display current inventory
SELECT *
FROM inventory;

-- 18. Total warehouses
SELECT COUNT(*) AS total_warehouses
FROM warehouses;

-- =====================================================
-- Employee Analysis
-- =====================================================

-- 19. Employees working in Sales department
SELECT *
FROM employees
WHERE department = 'Sales';

-- 20. Display employee names and designations
SELECT employee_name,
       designation
FROM employees;

-- =====================================================
-- Aggregate Functions
-- =====================================================

-- 21. Average selling price
SELECT ROUND(AVG(selling_price),2) AS average_selling_price
FROM products;

-- 22. Highest selling price
SELECT MAX(selling_price) AS highest_selling_price
FROM products;

-- 23. Lowest selling price
SELECT MIN(selling_price) AS lowest_selling_price
FROM products;

-- 24. Total completed payment amount
SELECT SUM(amount) AS total_revenue
FROM payments
WHERE payment_status = 'Completed';

-- 25. Average customer rating
SELECT ROUND(AVG(rating),2) AS average_customer_rating
FROM reviews;