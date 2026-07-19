-- =====================================================
-- Enterprise Retail Data Warehouse
-- File: 05_cte_queries.sql
-- Description:
-- Common Table Expression (CTE) Queries
-- Concepts:
-- Simple CTE
-- Multiple CTEs
-- Recursive CTE
-- Analytical CTEs
-- =====================================================

SET search_path TO retailhub;

-- =====================================================
-- Basic CTEs
-- =====================================================

-- 1. Products priced above average
WITH avg_price AS
(
    SELECT AVG(selling_price) avg_price
    FROM products
)
SELECT
    product_name,
    selling_price
FROM products, avg_price
WHERE selling_price > avg_price;

---------------------------------------------------------

-- 2. Customers spending above average
WITH customer_spending AS
(
    SELECT
        c.customer_id,
        CONCAT(c.first_name,' ',c.last_name) customer_name,
        SUM(p.amount) total_spent
    FROM customers c
    JOIN orders o ON c.customer_id=o.customer_id
    JOIN payments p ON o.order_id=p.order_id
    WHERE p.payment_status='Completed'
    GROUP BY c.customer_id,c.first_name,c.last_name
)
SELECT *
FROM customer_spending
WHERE total_spent >
(
    SELECT AVG(total_spent)
    FROM customer_spending
);

---------------------------------------------------------

-- 3. Monthly revenue
WITH monthly_sales AS
(
    SELECT
        DATE_TRUNC('month',payment_date) sales_month,
        SUM(amount) revenue
    FROM payments
    WHERE payment_status='Completed'
    GROUP BY DATE_TRUNC('month',payment_date)
)
SELECT *
FROM monthly_sales
ORDER BY sales_month;

---------------------------------------------------------

-- 4. Store revenue
WITH store_revenue AS
(
    SELECT
        s.store_name,
        SUM(p.amount) revenue
    FROM stores s
    JOIN orders o ON s.store_id=o.store_id
    JOIN payments p ON o.order_id=p.order_id
    WHERE p.payment_status='Completed'
    GROUP BY s.store_name
)
SELECT *
FROM store_revenue
ORDER BY revenue DESC;

---------------------------------------------------------

-- 5. Inventory needing restocking
WITH low_stock AS
(
    SELECT *
    FROM inventory
    WHERE stock_quantity<=reorder_level
)
SELECT
    ls.inventory_id,
    p.product_name,
    w.warehouse_name,
    ls.stock_quantity
FROM low_stock ls
JOIN products p ON ls.product_id=p.product_id
JOIN warehouses w ON ls.warehouse_id=w.warehouse_id;

-- =====================================================
-- Multiple CTEs
-- =====================================================

-- 6. Compare customer spending with average
WITH customer_spending AS
(
    SELECT
        c.customer_id,
        CONCAT(c.first_name,' ',c.last_name) customer_name,
        SUM(p.amount) total_spent
    FROM customers c
    JOIN orders o ON c.customer_id=o.customer_id
    JOIN payments p ON o.order_id=p.order_id
    WHERE payment_status='Completed'
    GROUP BY c.customer_id,c.first_name,c.last_name
),
average_spending AS
(
    SELECT AVG(total_spent) avg_spending
    FROM customer_spending
)
SELECT
    customer_name,
    total_spent
FROM customer_spending,average_spending
WHERE total_spent>avg_spending;

---------------------------------------------------------

-- 7. Category revenue and average revenue
WITH category_sales AS
(
    SELECT
        c.category_name,
        SUM((oi.quantity*oi.unit_price)-oi.discount+oi.tax) revenue
    FROM order_items oi
    JOIN products p ON oi.product_id=p.product_id
    JOIN categories c ON p.category_id=c.category_id
    GROUP BY c.category_name
),
overall_avg AS
(
    SELECT AVG(revenue) avg_revenue
    FROM category_sales
)
SELECT *
FROM category_sales,overall_avg
WHERE revenue>avg_revenue;

---------------------------------------------------------

-- 8. Top store and its revenue percentage
WITH store_sales AS
(
    SELECT
        s.store_name,
        SUM(p.amount) revenue
    FROM stores s
    JOIN orders o ON s.store_id=o.store_id
    JOIN payments p ON o.order_id=p.order_id
    WHERE payment_status='Completed'
    GROUP BY s.store_name
),
total_sales AS
(
    SELECT SUM(revenue) total_revenue
    FROM store_sales
)
SELECT
    store_name,
    revenue,
    ROUND(revenue*100/total_revenue,2) contribution_percentage
FROM store_sales,total_sales
ORDER BY revenue DESC;

---------------------------------------------------------

-- 9. Product profit analysis
WITH product_profit AS
(
    SELECT
        product_name,
        cost_price,
        selling_price,
        selling_price-cost_price profit
    FROM products
)
SELECT *
FROM product_profit
ORDER BY profit DESC;

---------------------------------------------------------

-- 10. Customers with completed shipments
WITH delivered_orders AS
(
    SELECT order_id
    FROM shipments
    WHERE delivery_status='Delivered'
)
SELECT DISTINCT
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) customer_name
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN delivered_orders d ON o.order_id=d.order_id;

-- =====================================================
-- Analytical CTEs
-- =====================================================

-- 11. Top 5 brands by revenue
WITH brand_sales AS
(
    SELECT
        b.brand_name,
        SUM((oi.quantity*oi.unit_price)-oi.discount+oi.tax) revenue
    FROM order_items oi
    JOIN products p ON oi.product_id=p.product_id
    JOIN brands b ON p.brand_id=b.brand_id
    GROUP BY b.brand_name
)
SELECT *
FROM brand_sales
ORDER BY revenue DESC
LIMIT 5;

---------------------------------------------------------

-- 12. Warehouse inventory value
WITH inventory_value AS
(
    SELECT
        w.warehouse_name,
        SUM(i.stock_quantity*p.cost_price) inventory_value
    FROM inventory i
    JOIN warehouses w ON i.warehouse_id=w.warehouse_id
    JOIN products p ON i.product_id=p.product_id
    GROUP BY w.warehouse_name
)
SELECT *
FROM inventory_value
ORDER BY inventory_value DESC;

---------------------------------------------------------

-- 13. Monthly customer registrations

WITH registrations AS
(
    SELECT
        DATE_TRUNC('month', registration_date) AS registration_month,
        COUNT(*) AS registrations
    FROM customers
    GROUP BY DATE_TRUNC('month', registration_date)
)

SELECT *
FROM registrations
ORDER BY registration_month;

---------------------------------------------------------

-- 14. Product sales summary
WITH sales_summary AS
(
    SELECT
        p.product_name,
        SUM(oi.quantity) total_quantity
    FROM products p
    JOIN order_items oi ON p.product_id=oi.product_id
    GROUP BY p.product_name
)
SELECT *
FROM sales_summary
ORDER BY total_quantity DESC;

-- =====================================================
-- Recursive CTE
-- =====================================================

-- 15. Generate numbers from 1 to 12
WITH RECURSIVE numbers AS
(
    SELECT 1 AS n

    UNION ALL

    SELECT n+1
    FROM numbers
    WHERE n<12
)
SELECT *
FROM numbers;