-- =====================================================
-- Enterprise Retail Data Warehouse
-- File: 01_explain_analyze.sql
-- Description:
-- Analyze execution plans using EXPLAIN ANALYZE
-- =====================================================

SET search_path TO retailhub;

---------------------------------------------------------
-- 1. Product Search
---------------------------------------------------------

EXPLAIN ANALYZE

SELECT *

FROM products

WHERE product_name='Laptop';

---------------------------------------------------------
-- 2. Customer Lookup
---------------------------------------------------------

EXPLAIN ANALYZE

SELECT *

FROM customers

WHERE email='john@example.com';

---------------------------------------------------------
-- 3. Orders for Customer
---------------------------------------------------------

EXPLAIN ANALYZE

SELECT *

FROM orders

WHERE customer_id=100;

---------------------------------------------------------
-- 4. Revenue Report
---------------------------------------------------------

EXPLAIN ANALYZE

SELECT

SUM(amount)

FROM payments

WHERE payment_status='Completed';

---------------------------------------------------------
-- 5. Product Sales Report
---------------------------------------------------------

EXPLAIN ANALYZE

SELECT

p.product_name,

SUM(oi.quantity)

FROM products p

JOIN order_items oi

ON p.product_id=oi.product_id

GROUP BY p.product_name;