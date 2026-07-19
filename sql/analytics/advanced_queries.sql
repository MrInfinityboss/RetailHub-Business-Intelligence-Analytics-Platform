-- =====================================================
-- Enterprise Retail Data Warehouse
-- File: 03_advanced_queries.sql
-- Description:
-- Advanced SQL queries using subqueries, correlated
-- subqueries, derived tables, complex aggregations,
-- EXISTS, ANY, ALL and business analytics.
-- =====================================================

SET search_path TO retailhub;

-- =====================================================
-- Revenue & Sales Analysis
-- =====================================================

-- 1. Top 10 highest revenue generating customers
SELECT
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    SUM(p.amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN payments p ON o.order_id=p.order_id
WHERE p.payment_status='Completed'
GROUP BY c.customer_id,c.first_name,c.last_name
ORDER BY total_spent DESC
LIMIT 10;

---------------------------------------------------------

-- 2. Top 10 best-selling products by revenue
SELECT
    pr.product_name,
    SUM((oi.unit_price * oi.quantity)-oi.discount+oi.tax) AS revenue
FROM order_items oi
JOIN products pr
ON oi.product_id=pr.product_id
GROUP BY pr.product_name
ORDER BY revenue DESC
LIMIT 10;

---------------------------------------------------------

-- 3. Top performing stores based on revenue
SELECT
    s.store_name,
    SUM(p.amount) revenue
FROM stores s
JOIN orders o
ON s.store_id=o.store_id
JOIN payments p
ON o.order_id=p.order_id
WHERE p.payment_status='Completed'
GROUP BY s.store_name
ORDER BY revenue DESC;

---------------------------------------------------------

-- 4. Categories generating highest revenue
SELECT
    c.category_name,
    SUM((oi.unit_price*oi.quantity)-oi.discount+oi.tax) revenue
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
JOIN categories c
ON p.category_id=c.category_id
GROUP BY c.category_name
ORDER BY revenue DESC;

---------------------------------------------------------

-- 5. Brand-wise revenue
SELECT
    b.brand_name,
    SUM((oi.unit_price*oi.quantity)-oi.discount+oi.tax) revenue
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
JOIN brands b
ON p.brand_id=b.brand_id
GROUP BY b.brand_name
ORDER BY revenue DESC;

-- =====================================================
-- Subqueries
-- =====================================================

-- 6. Products priced above average selling price
SELECT
    product_name,
    selling_price
FROM products
WHERE selling_price >
(
SELECT AVG(selling_price)
FROM products
);

---------------------------------------------------------

-- 7. Customers who spent more than average customer spending
SELECT *
FROM
(
SELECT
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) customer_name,
    SUM(p.amount) total_spent
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN payments p
ON o.order_id=p.order_id
WHERE p.payment_status='Completed'
GROUP BY c.customer_id,c.first_name,c.last_name
)t
WHERE total_spent >
(
SELECT AVG(total_spent)
FROM
(
SELECT SUM(amount) total_spent
FROM payments
WHERE payment_status='Completed'
GROUP BY order_id
)x
);

---------------------------------------------------------

-- 8. Products never ordered
SELECT
    product_id,
    product_name
FROM products
WHERE product_id NOT IN
(
SELECT DISTINCT product_id
FROM order_items
);

---------------------------------------------------------

-- 9. Customers who never placed an order
SELECT
    customer_id,
    first_name,
    last_name
FROM customers
WHERE customer_id NOT IN
(
SELECT DISTINCT customer_id
FROM orders
);

---------------------------------------------------------

-- 10. Stores without any orders
SELECT
    store_name
FROM stores
WHERE store_id NOT IN
(
SELECT DISTINCT store_id
FROM orders
);

-- =====================================================
-- Correlated Subqueries
-- =====================================================

-- 11. Most expensive product within each category
SELECT
    p1.product_name,
    p1.selling_price,
    c.category_name
FROM products p1
JOIN categories c
ON p1.category_id=c.category_id
WHERE selling_price=
(
SELECT MAX(p2.selling_price)
FROM products p2
WHERE p2.category_id=p1.category_id
);

---------------------------------------------------------

-- 12. Highest paid employee in each department
SELECT
    employee_name,
    department,
    salary
FROM employees e1
WHERE salary=
(
SELECT MAX(salary)
FROM employees e2
WHERE e1.department=e2.department
);

---------------------------------------------------------

-- 13. Warehouse having maximum stock
SELECT
    warehouse_name
FROM warehouses
WHERE warehouse_id=
(
SELECT warehouse_id
FROM inventory
GROUP BY warehouse_id
ORDER BY SUM(stock_quantity) DESC
LIMIT 1
);

-- =====================================================
-- EXISTS
-- =====================================================

-- 14. Customers having at least one completed payment
SELECT
    customer_id,
    first_name,
    last_name
FROM customers c
WHERE EXISTS
(
SELECT 1
FROM orders o
JOIN payments p
ON o.order_id=p.order_id
WHERE c.customer_id=o.customer_id
AND p.payment_status='Completed'
);

---------------------------------------------------------

-- 15. Products available in inventory
SELECT
    product_name
FROM products p
WHERE EXISTS
(
SELECT 1
FROM inventory i
WHERE p.product_id=i.product_id
);

-- =====================================================
-- Complex Aggregation
-- =====================================================

-- 16. Revenue contribution (%) by each category
SELECT
    c.category_name,
    ROUND(
    SUM((oi.unit_price*oi.quantity)-oi.discount+oi.tax)
    /
    (
    SELECT SUM((unit_price*quantity)-discount+tax)
    FROM order_items
    )*100
    ,2) contribution_percentage
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
JOIN categories c
ON p.category_id=c.category_id
GROUP BY c.category_name
ORDER BY contribution_percentage DESC;

---------------------------------------------------------

-- 17. Average revenue generated per customer
SELECT
    ROUND(SUM(amount) / COUNT(DISTINCT o.customer_id), 2) AS average_revenue_per_customer
FROM payments p
JOIN orders o
ON p.order_id = o.order_id
WHERE p.payment_status = 'Completed';

---------------------------------------------------------

-- 18. Average products per order
SELECT
ROUND(AVG(product_count),2)
FROM
(
SELECT
order_id,
SUM(quantity) product_count
FROM order_items
GROUP BY order_id
)x;

---------------------------------------------------------

-- 19. Average delivery duration
SELECT
ROUND(
AVG(delivery_date-ship_date),2
)
AS average_delivery_days
FROM shipments
WHERE delivery_date IS NOT NULL;

---------------------------------------------------------

-- 20. Return percentage
SELECT
ROUND(
COUNT(*)*100.0/
(
SELECT COUNT(*)
FROM order_items
)
,2)
AS return_percentage
FROM returns;

-- =====================================================
-- Business Insights
-- =====================================================

-- 21. Supplier supplying maximum products
SELECT
supplier_name,
COUNT(*) total_products
FROM suppliers s
JOIN products p
ON s.supplier_id=p.supplier_id
GROUP BY supplier_name
ORDER BY total_products DESC
LIMIT 1;

---------------------------------------------------------

-- 22. Brand with highest average selling price
SELECT
brand_name,
ROUND(AVG(selling_price),2) avg_price
FROM brands b
JOIN products p
ON b.brand_id=p.brand_id
GROUP BY brand_name
ORDER BY avg_price DESC;

---------------------------------------------------------

-- 23. Customer with highest loyalty points earned
SELECT
c.customer_id,
CONCAT(c.first_name,' ',c.last_name) customer_name,
SUM(points_earned) total_points
FROM loyalty_transactions lt
JOIN customers c
ON lt.customer_id=c.customer_id
GROUP BY c.customer_id,c.first_name,c.last_name
ORDER BY total_points DESC
LIMIT 1;

---------------------------------------------------------

-- 24. Promotion used most frequently
SELECT
promotion_id,
COUNT(*) usage_count
FROM coupon_usage
GROUP BY promotion_id
ORDER BY usage_count DESC
LIMIT 1;

---------------------------------------------------------

-- 25. Warehouse managing the highest inventory value
SELECT
w.warehouse_name,
SUM(i.stock_quantity*p.cost_price) inventory_value
FROM inventory i
JOIN warehouses w
ON i.warehouse_id=w.warehouse_id
JOIN products p
ON i.product_id=p.product_id
GROUP BY w.warehouse_name
ORDER BY inventory_value DESC;