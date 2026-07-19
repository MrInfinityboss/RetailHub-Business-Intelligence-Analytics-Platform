-- =====================================================
-- Enterprise Retail Data Warehouse
-- File: 06_business_questions.sql
-- Description:
-- Real-world business questions answered using SQL.
-- =====================================================

SET search_path TO retailhub;

-- =====================================================
-- Sales Performance
-- =====================================================

-- 1. Which stores generated the highest revenue?
SELECT
    s.store_name,
    ROUND(SUM(p.amount),2) AS total_revenue
FROM stores s
JOIN orders o ON s.store_id = o.store_id
JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_status = 'Completed'
GROUP BY s.store_name
ORDER BY total_revenue DESC;

---------------------------------------------------------

-- 2. Which sales channel generated the most revenue?
SELECT
    o.sales_channel,
    ROUND(SUM(p.amount),2) AS revenue
FROM orders o
JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_status = 'Completed'
GROUP BY o.sales_channel
ORDER BY revenue DESC;

---------------------------------------------------------

-- 3. What are the top 10 revenue-generating products?
SELECT
    pr.product_name,
    ROUND(SUM((oi.quantity * oi.unit_price) - oi.discount + oi.tax),2) AS revenue
FROM order_items oi
JOIN products pr ON oi.product_id = pr.product_id
GROUP BY pr.product_name
ORDER BY revenue DESC
LIMIT 10;

---------------------------------------------------------

-- 4. Which categories contribute the most revenue?
SELECT
    c.category_name,
    ROUND(SUM((oi.quantity * oi.unit_price) - oi.discount + oi.tax),2) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY revenue DESC;

---------------------------------------------------------

-- 5. What is the monthly revenue trend?
SELECT
    DATE_TRUNC('month', p.payment_date) AS month,
    ROUND(SUM(p.amount),2) AS revenue
FROM payments p
WHERE p.payment_status = 'Completed'
GROUP BY DATE_TRUNC('month', p.payment_date)
ORDER BY month;

-- =====================================================
-- Customer Insights
-- =====================================================

-- 6. Who are the top 10 customers by spending?
SELECT
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    ROUND(SUM(p.amount),2) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_status = 'Completed'
GROUP BY c.customer_id,c.first_name,c.last_name
ORDER BY total_spent DESC
LIMIT 10;

---------------------------------------------------------

-- 7. Which membership level generates the highest revenue?
SELECT
    c.membership_level,
    ROUND(SUM(p.amount),2) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_status = 'Completed'
GROUP BY c.membership_level
ORDER BY revenue DESC;

---------------------------------------------------------

-- 8. Which cities have the highest number of customers?
SELECT
    city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;

---------------------------------------------------------

-- 9. Which customers have never placed an order?
SELECT
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

---------------------------------------------------------

-- 10. Which customers earned the most loyalty points?
SELECT
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    SUM(lt.points_earned) AS total_points
FROM loyalty_transactions lt
JOIN customers c
ON lt.customer_id = c.customer_id
GROUP BY c.customer_id,c.first_name,c.last_name
ORDER BY total_points DESC
LIMIT 10;

-- =====================================================
-- Inventory & Operations
-- =====================================================

-- 11. Which products need immediate restocking?
SELECT
    p.product_name,
    w.warehouse_name,
    i.stock_quantity,
    i.reorder_level
FROM inventory i
JOIN products p ON i.product_id = p.product_id
JOIN warehouses w ON i.warehouse_id = w.warehouse_id
WHERE i.stock_quantity <= i.reorder_level
ORDER BY i.stock_quantity;

---------------------------------------------------------

-- 12. Which warehouse has the highest inventory value?
SELECT
    w.warehouse_name,
    ROUND(SUM(i.stock_quantity * pr.cost_price),2) AS inventory_value
FROM inventory i
JOIN warehouses w ON i.warehouse_id = w.warehouse_id
JOIN products pr ON i.product_id = pr.product_id
GROUP BY w.warehouse_name
ORDER BY inventory_value DESC;

---------------------------------------------------------

-- 13. Which suppliers provide the largest number of products?
SELECT
    s.supplier_name,
    COUNT(*) AS total_products
FROM suppliers s
JOIN products p
ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_name
ORDER BY total_products DESC;

---------------------------------------------------------

-- 14. Which products have never been ordered?
SELECT
    product_name
FROM products
WHERE product_id NOT IN
(
    SELECT DISTINCT product_id
    FROM order_items
);

---------------------------------------------------------

-- 15. Which warehouses manage the largest stock quantity?
SELECT
    w.warehouse_name,
    SUM(i.stock_quantity) AS total_stock
FROM warehouses w
JOIN inventory i
ON w.warehouse_id = i.warehouse_id
GROUP BY w.warehouse_name
ORDER BY total_stock DESC;

-- =====================================================
-- Returns & Shipping
-- =====================================================

-- 16. Which products are returned most frequently?
SELECT
    p.product_name,
    COUNT(r.return_id) AS total_returns
FROM returns r
JOIN order_items oi ON r.order_item_id = oi.order_item_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_returns DESC
LIMIT 10;

---------------------------------------------------------

-- 17. Which carrier has the highest average shipping cost?
SELECT
    carrier,
    ROUND(AVG(shipping_cost),2) AS avg_shipping_cost
FROM shipments
GROUP BY carrier
ORDER BY avg_shipping_cost DESC;

---------------------------------------------------------

-- 18. What is the average delivery time for each carrier?
SELECT
    carrier,
    ROUND(AVG(delivery_date - ship_date),2) AS avg_delivery_days
FROM shipments
WHERE delivery_date IS NOT NULL
GROUP BY carrier
ORDER BY avg_delivery_days;

-- =====================================================
-- Promotions
-- =====================================================

-- 19. Which promotion was used most often?
SELECT
    promotion_id,
    COUNT(*) AS usage_count
FROM coupon_usage
GROUP BY promotion_id
ORDER BY usage_count DESC
LIMIT 1;

---------------------------------------------------------

-- 20. Total discount amount given through promotions
SELECT
    ROUND(SUM(discount_amount),2) AS total_discount
FROM coupon_usage;