SET search_path TO retailhub;

-- =====================================================
-- View: Product Catalog
-- Description:
-- Complete product information with category,
-- brand and supplier details.
-- =====================================================

CREATE OR REPLACE VIEW vw_product_catalog AS

SELECT

    p.product_id,
    p.product_name,

    c.category_name,

    b.brand_name,

    s.supplier_name,

    p.cost_price,
    p.selling_price,

    (p.selling_price - p.cost_price) AS profit_per_unit,

    p.status,
    p.launch_date

FROM products p

JOIN categories c
ON p.category_id = c.category_id

JOIN brands b
ON p.brand_id = b.brand_id

JOIN suppliers s
ON p.supplier_id = s.supplier_id;


-- =====================================================
-- View: Order Details
-- Description:
-- Complete order information with customer,
-- product, payment and shipment details.
-- =====================================================

CREATE OR REPLACE VIEW vw_order_details AS

SELECT

    o.order_id,
    o.order_date,
    o.order_status,
    o.sales_channel,

    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    c.membership_level,

    s.store_name,

    p.product_name,
    cat.category_name,
    b.brand_name,

    oi.quantity,
    oi.unit_price,
    oi.discount,
    oi.tax,

    pay.payment_method,
    pay.payment_status,

    sh.delivery_status,
    sh.ship_date,
    sh.delivery_date

FROM orders o

JOIN customers c
ON o.customer_id = c.customer_id

JOIN stores s
ON o.store_id = s.store_id

JOIN order_items oi
ON o.order_id = oi.order_id

JOIN products p
ON oi.product_id = p.product_id

JOIN categories cat
ON p.category_id = cat.category_id

JOIN brands b
ON p.brand_id = b.brand_id

LEFT JOIN payments pay
ON o.order_id = pay.order_id

LEFT JOIN shipments sh
ON o.order_id = sh.order_id;


CREATE OR REPLACE VIEW vw_inventory_status AS

SELECT

    i.inventory_id,

    p.product_name,

    w.warehouse_name,

    i.stock_quantity,

    i.reorder_level,

    CASE
        WHEN i.stock_quantity <= i.reorder_level
            THEN 'Low Stock'
        ELSE 'Sufficient Stock'
    END AS stock_status,

    i.last_stock_update

FROM inventory i

JOIN products p
ON i.product_id = p.product_id

JOIN warehouses w
ON i.warehouse_id = w.warehouse_id;


CREATE OR REPLACE VIEW vw_customer_summary AS

SELECT

    c.customer_id,

    CONCAT(c.first_name,' ',c.last_name) AS customer_name,

    c.city,
    c.state,
    c.country,

    c.membership_level,

    COUNT(DISTINCT o.order_id) AS total_orders,

    COALESCE(SUM(oi.quantity * oi.unit_price),0) AS total_spent

FROM customers c

LEFT JOIN orders o
ON c.customer_id = o.customer_id

LEFT JOIN order_items oi
ON o.order_id = oi.order_id

GROUP BY

    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    c.state,
    c.country,
    c.membership_level;


    CREATE OR REPLACE VIEW vw_sales_summary AS

SELECT

    o.order_date,

    s.store_name,

    o.sales_channel,

    COUNT(DISTINCT o.order_id) AS total_orders,

    SUM(oi.quantity) AS total_units_sold,

    SUM((oi.unit_price * oi.quantity) - oi.discount + oi.tax) AS total_sales

FROM orders o

JOIN stores s
ON o.store_id = s.store_id

JOIN order_items oi
ON o.order_id = oi.order_id

GROUP BY

    o.order_date,
    s.store_name,
    o.sales_channel;