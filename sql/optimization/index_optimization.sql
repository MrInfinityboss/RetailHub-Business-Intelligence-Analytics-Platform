-- =====================================================
-- Enterprise Retail Data Warehouse
-- File: 02_index_optimization.sql
-- Description:
-- Performance indexes
-- =====================================================

SET search_path TO retailhub;

---------------------------------------------------------
-- Customer Email
---------------------------------------------------------

CREATE INDEX idx_customer_email

ON customers(email);

---------------------------------------------------------
-- Product Name
---------------------------------------------------------

CREATE INDEX idx_product_name

ON products(product_name);

---------------------------------------------------------
-- Order Date
---------------------------------------------------------

CREATE INDEX idx_order_date

ON orders(order_date);

---------------------------------------------------------
-- Payment Status
---------------------------------------------------------

CREATE INDEX idx_payment_status

ON payments(payment_status);

---------------------------------------------------------
-- Sales Channel
---------------------------------------------------------

CREATE INDEX idx_sales_channel

ON orders(sales_channel);

---------------------------------------------------------
-- Membership
---------------------------------------------------------

CREATE INDEX idx_membership

ON customers(membership_level);

---------------------------------------------------------
-- Delivery Status
---------------------------------------------------------

CREATE INDEX idx_delivery_status

ON shipments(delivery_status);

---------------------------------------------------------
-- Brand
---------------------------------------------------------

CREATE INDEX idx_brand

ON products(brand_id);

---------------------------------------------------------
-- Category
---------------------------------------------------------

CREATE INDEX idx_category

ON products(category_id);