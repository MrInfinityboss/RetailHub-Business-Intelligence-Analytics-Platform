-- =====================================================
-- Enterprise Retail Data Warehouse
-- File: 03_performance_comparison.sql
-- Description:
-- Compare query performance before and after indexing
-- =====================================================

SET search_path TO retailhub;

---------------------------------------------------------
-- Before Index
---------------------------------------------------------

EXPLAIN ANALYZE

SELECT *

FROM customers

WHERE email='john@example.com';

---------------------------------------------------------
-- After Index
---------------------------------------------------------

CREATE INDEX IF NOT EXISTS idx_customer_email_demo

ON customers(email);

EXPLAIN ANALYZE

SELECT *

FROM customers

WHERE email='john@example.com';

---------------------------------------------------------
-- Product Search
---------------------------------------------------------

EXPLAIN ANALYZE

SELECT *

FROM products

WHERE product_name='Laptop';

---------------------------------------------------------
-- Create Product Index
---------------------------------------------------------

CREATE INDEX IF NOT EXISTS idx_product_name_demo

ON products(product_name);

---------------------------------------------------------
-- Re-run Query
---------------------------------------------------------

EXPLAIN ANALYZE

SELECT *

FROM products

WHERE product_name='Laptop';

---------------------------------------------------------
-- Orders Lookup
---------------------------------------------------------

EXPLAIN ANALYZE

SELECT *

FROM orders

WHERE customer_id=200;

---------------------------------------------------------
-- Create Index
---------------------------------------------------------

CREATE INDEX IF NOT EXISTS idx_customer_orders

ON orders(customer_id);

---------------------------------------------------------
-- Re-run
---------------------------------------------------------

EXPLAIN ANALYZE

SELECT *

FROM orders

WHERE customer_id=200;