-- =====================================================
-- Enterprise Retail Data Warehouse
-- File: 04_window_functions.sql
-- Description:
-- Advanced SQL Window Function Queries
-- Concepts:
-- ROW_NUMBER, RANK, DENSE_RANK,
-- NTILE, LAG, LEAD,
-- FIRST_VALUE, LAST_VALUE,
-- Running Total,
-- Moving Average,
-- Cumulative Percentage
-- =====================================================

SET search_path TO retailhub;

-- =====================================================
-- ROW_NUMBER()
-- =====================================================

-- 1. Assign row numbers to products based on selling price
SELECT
    product_name,
    selling_price,
    ROW_NUMBER() OVER(ORDER BY selling_price DESC) AS row_num
FROM products;

---------------------------------------------------------

-- 2. Rank customers by total spending
SELECT
    customer_id,
    customer_name,
    total_spent,
    ROW_NUMBER() OVER(ORDER BY total_spent DESC) AS customer_rank
FROM vw_customer_summary;

---------------------------------------------------------

-- 3. Latest order of every customer
SELECT *
FROM
(
SELECT
    order_id,
    customer_id,
    order_date,
    ROW_NUMBER() OVER
    (
        PARTITION BY customer_id
        ORDER BY order_date DESC
    ) rn
FROM orders
)t
WHERE rn=1;

-- =====================================================
-- RANK()
-- =====================================================

-- 4. Rank stores by revenue
SELECT
    store_name,
    revenue,
    RANK() OVER(ORDER BY revenue DESC) store_rank
FROM
(
SELECT
    s.store_name,
    SUM(p.amount) revenue
FROM stores s
JOIN orders o ON s.store_id=o.store_id
JOIN payments p ON o.order_id=p.order_id
WHERE payment_status='Completed'
GROUP BY s.store_name
)t;

---------------------------------------------------------

-- 5. Rank products within each category
SELECT
    category_name,
    product_name,
    selling_price,
    RANK() OVER
    (
        PARTITION BY category_name
        ORDER BY selling_price DESC
    ) category_rank
FROM vw_product_catalog;

-- =====================================================
-- DENSE_RANK()
-- =====================================================

-- 6. Dense rank brands by average product price
SELECT
    brand_name,
    avg_price,
    DENSE_RANK() OVER(ORDER BY avg_price DESC) price_rank
FROM
(
SELECT
    brand_name,
    AVG(selling_price) avg_price
FROM vw_product_catalog
GROUP BY brand_name
)t;

---------------------------------------------------------

-- 7. Dense rank customers within membership level
SELECT
    membership_level,
    customer_name,
    total_spent,
    DENSE_RANK() OVER
    (
        PARTITION BY membership_level
        ORDER BY total_spent DESC
    ) spending_rank
FROM vw_customer_summary;

-- =====================================================
-- NTILE()
-- =====================================================

-- 8. Divide products into four price groups
SELECT
    product_name,
    selling_price,
    NTILE(4) OVER(ORDER BY selling_price DESC) price_quartile
FROM products;

---------------------------------------------------------

-- 9. Divide customers into five spending segments
SELECT
    customer_name,
    total_spent,
    NTILE(5) OVER(ORDER BY total_spent DESC) spending_segment
FROM vw_customer_summary;

-- =====================================================
-- LAG()
-- =====================================================

-- 10. Compare daily revenue with previous day
SELECT
    order_date,
    daily_sales,
    LAG(daily_sales)
    OVER(ORDER BY order_date) previous_day_sales
FROM
(
SELECT
    o.order_date,
    SUM(p.amount) daily_sales
FROM orders o
JOIN payments p
ON o.order_id=p.order_id
WHERE payment_status='Completed'
GROUP BY order_date
)t;

---------------------------------------------------------

-- 11. Previous order date of each customer
SELECT
    customer_id,
    order_date,
    LAG(order_date)
    OVER
    (
        PARTITION BY customer_id
        ORDER BY order_date
    ) previous_order
FROM orders;

-- =====================================================
-- LEAD()
-- =====================================================

-- 12. Next order date for each customer
SELECT
    customer_id,
    order_date,
    LEAD(order_date)
    OVER
    (
        PARTITION BY customer_id
        ORDER BY order_date
    ) next_order
FROM orders;

---------------------------------------------------------

-- 13. Compare current revenue with next day's revenue
SELECT
    order_date,
    revenue,
    LEAD(revenue)
    OVER(ORDER BY order_date) next_day_revenue
FROM
(
SELECT
    order_date,
    SUM(amount) revenue
FROM orders o
JOIN payments p
ON o.order_id=p.order_id
WHERE payment_status='Completed'
GROUP BY order_date
)t;

-- =====================================================
-- FIRST_VALUE()
-- =====================================================

-- 14. Highest priced product in every category
SELECT
    category_name,
    product_name,
    selling_price,
    FIRST_VALUE(product_name)
    OVER
    (
        PARTITION BY category_name
        ORDER BY selling_price DESC
    ) highest_priced_product
FROM vw_product_catalog;

-- =====================================================
-- LAST_VALUE()
-- =====================================================

-- 15. Lowest priced product in every category
SELECT
    category_name,
    product_name,
    selling_price,
    LAST_VALUE(product_name)
    OVER
    (
        PARTITION BY category_name
        ORDER BY selling_price
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING
    ) lowest_priced_product
FROM vw_product_catalog;

-- =====================================================
-- Running Totals
-- =====================================================

-- 16. Running revenue
SELECT
    payment_date,
    amount,
    SUM(amount)
    OVER
    (
        ORDER BY payment_date
    ) running_revenue
FROM payments
WHERE payment_status='Completed';

---------------------------------------------------------

-- 17. Running customer spending
SELECT
    customer_name,
    total_spent,
    SUM(total_spent)
    OVER
    (
        ORDER BY total_spent DESC
    ) cumulative_customer_spending
FROM vw_customer_summary;

-- =====================================================
-- Moving Average
-- =====================================================

-- 18. Three-day moving average of sales
SELECT
    order_date,
    daily_sales,
    ROUND(
        AVG(daily_sales)
        OVER
        (
            ORDER BY order_date
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) moving_average
FROM
(
SELECT
    o.order_date,
    SUM(p.amount) daily_sales
FROM orders o
JOIN payments p
ON o.order_id=p.order_id
WHERE payment_status='Completed'
GROUP BY order_date
)t;

-- =====================================================
-- Cumulative Percentage
-- =====================================================

-- 19. Revenue contribution percentage by store
SELECT
    store_name,
    revenue,
    ROUND(
        revenue * 100 /
        SUM(revenue) OVER(),
        2
    ) contribution_percentage
FROM
(
SELECT
    s.store_name,
    SUM(p.amount) revenue
FROM stores s
JOIN orders o ON s.store_id=o.store_id
JOIN payments p ON o.order_id=p.order_id
WHERE payment_status='Completed'
GROUP BY s.store_name
)t;

---------------------------------------------------------

-- 20. Top 10 customers with cumulative revenue
SELECT
    customer_name,
    total_spent,
    SUM(total_spent)
    OVER(ORDER BY total_spent DESC) cumulative_revenue
FROM vw_customer_summary
ORDER BY total_spent DESC
LIMIT 10;