-- =====================================================
-- Enterprise Retail Data Warehouse
-- File: 07_case_studies.sql
-- Description:
-- End-to-End Business Case Studies
-- =====================================================

SET search_path TO retailhub;

-- =====================================================
-- Case Study 1
-- Business Problem:
-- Identify the highest revenue-generating stores.
-- =====================================================

SELECT
    s.store_name,
    ROUND(SUM(p.amount),2) AS total_revenue
FROM stores s
JOIN orders o
ON s.store_id = o.store_id
JOIN payments p
ON o.order_id = p.order_id
WHERE p.payment_status = 'Completed'
GROUP BY s.store_name
ORDER BY total_revenue DESC;

-- Business Insight:
-- High-performing stores contribute the largest share of revenue.

-- Recommendation:
-- Replicate their inventory planning, staffing, and promotional strategies
-- across lower-performing stores.

------------------------------------------------------------

-- =====================================================
-- Case Study 2
-- Business Problem:
-- Identify the top customers by lifetime value.
-- =====================================================

SELECT
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    ROUND(SUM(p.amount),2) AS lifetime_value
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN payments p
ON o.order_id = p.order_id
WHERE p.payment_status='Completed'
GROUP BY c.customer_id,c.first_name,c.last_name
ORDER BY lifetime_value DESC
LIMIT 10;

-- Business Insight:
-- A small percentage of customers contribute a significant share of revenue.

-- Recommendation:
-- Reward these customers with exclusive offers and loyalty benefits.

------------------------------------------------------------

-- =====================================================
-- Case Study 3
-- Business Problem:
-- Find products requiring immediate restocking.
-- =====================================================

SELECT
    p.product_name,
    w.warehouse_name,
    i.stock_quantity,
    i.reorder_level
FROM inventory i
JOIN products p
ON i.product_id = p.product_id
JOIN warehouses w
ON i.warehouse_id = w.warehouse_id
WHERE i.stock_quantity <= i.reorder_level
ORDER BY i.stock_quantity;

-- Business Insight:
-- Low inventory increases the risk of stockouts.

-- Recommendation:
-- Prioritize replenishment for these products.

------------------------------------------------------------

-- =====================================================
-- Case Study 4
-- Business Problem:
-- Determine the best-performing product categories.
-- =====================================================

SELECT
    c.category_name,
    ROUND(
        SUM((oi.quantity * oi.unit_price) - oi.discount + oi.tax),
        2
    ) AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
JOIN categories c
ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY revenue DESC;

-- Business Insight:
-- Revenue is concentrated in a few product categories.

-- Recommendation:
-- Increase assortment and marketing investment in top categories.

------------------------------------------------------------

-- =====================================================
-- Case Study 5
-- Business Problem:
-- Measure the effectiveness of sales channels.
-- =====================================================

SELECT
    o.sales_channel,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(pay.amount),2) AS revenue
FROM orders o
JOIN payments pay
ON o.order_id = pay.order_id
WHERE pay.payment_status='Completed'
GROUP BY o.sales_channel
ORDER BY revenue DESC;

-- Business Insight:
-- One or two channels outperform the others.

-- Recommendation:
-- Allocate more marketing budget to high-performing channels.

------------------------------------------------------------

-- =====================================================
-- Case Study 6
-- Business Problem:
-- Evaluate supplier contribution.
-- =====================================================

SELECT
    s.supplier_name,
    COUNT(*) AS total_products
FROM suppliers s
JOIN products p
ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_name
ORDER BY total_products DESC;

-- Business Insight:
-- Some suppliers contribute a significantly larger product portfolio.

-- Recommendation:
-- Strengthen relationships with reliable suppliers while reducing
-- dependency on a single supplier.

------------------------------------------------------------

-- =====================================================
-- Case Study 7
-- Business Problem:
-- Identify products with the highest return rates.
-- =====================================================

SELECT
    p.product_name,
    COUNT(r.return_id) AS total_returns
FROM returns r
JOIN order_items oi
ON r.order_item_id = oi.order_item_id
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_returns DESC
LIMIT 10;

-- Business Insight:
-- Frequently returned products may indicate quality issues,
-- misleading product descriptions, or shipping damage.

-- Recommendation:
-- Investigate root causes and reduce return rates.

------------------------------------------------------------

-- =====================================================
-- Case Study 8
-- Business Problem:
-- Identify the most valuable warehouse.
-- =====================================================

SELECT
    w.warehouse_name,
    ROUND(
        SUM(i.stock_quantity * p.cost_price),
        2
    ) AS inventory_value
FROM inventory i
JOIN warehouses w
ON i.warehouse_id = w.warehouse_id
JOIN products p
ON i.product_id = p.product_id
GROUP BY w.warehouse_name
ORDER BY inventory_value DESC;

-- Business Insight:
-- Inventory investment is not evenly distributed across warehouses.

-- Recommendation:
-- Optimize inventory allocation to reduce holding costs.

------------------------------------------------------------

-- =====================================================
-- Case Study 9
-- Business Problem:
-- Analyze promotion effectiveness.
-- =====================================================

SELECT
    cu.promotion_id,
    COUNT(*) AS usage_count,
    ROUND(SUM(cu.discount_amount),2) AS total_discount
FROM coupon_usage cu
GROUP BY cu.promotion_id
ORDER BY usage_count DESC;

-- Business Insight:
-- Promotions differ significantly in customer adoption.

-- Recommendation:
-- Continue high-performing campaigns and redesign low-performing ones.

------------------------------------------------------------

-- =====================================================
-- Case Study 10
-- Business Problem:
-- Evaluate shipping performance by carrier.
-- =====================================================

SELECT
    carrier,
    COUNT(*) AS shipments,
    ROUND(AVG(delivery_date - ship_date),2) AS avg_delivery_days,
    ROUND(AVG(shipping_cost),2) AS avg_shipping_cost
FROM shipments
WHERE delivery_date IS NOT NULL
GROUP BY carrier
ORDER BY avg_delivery_days;

-- Business Insight:
-- Carriers differ in delivery speed and shipping cost.

-- Recommendation:
-- Balance cost and delivery performance when selecting logistics partners.