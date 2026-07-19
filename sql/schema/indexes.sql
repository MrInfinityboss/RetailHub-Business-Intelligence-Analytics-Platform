/*
===============================================================================
RetailHub Enterprise Retail Data Warehouse
File: 04_indexes.sql
Description: Create indexes for faster query performance
===============================================================================
*/

SET search_path TO retailhub;

-- =====================================================
-- PRODUCTS
-- =====================================================

CREATE INDEX idx_products_category
ON products(category_id);

CREATE INDEX idx_products_brand
ON products(brand_id);

CREATE INDEX idx_products_supplier
ON products(supplier_id);

CREATE INDEX idx_products_status
ON products(status);

-- =====================================================
-- EMPLOYEES
-- =====================================================

CREATE INDEX idx_employees_store
ON employees(store_id);

CREATE INDEX idx_employees_warehouse
ON employees(warehouse_id);

-- =====================================================
-- INVENTORY
-- =====================================================

CREATE INDEX idx_inventory_product
ON inventory(product_id);

CREATE INDEX idx_inventory_warehouse
ON inventory(warehouse_id);

-- =====================================================
-- ORDERS
-- =====================================================

CREATE INDEX idx_orders_customer
ON orders(customer_id);

CREATE INDEX idx_orders_store
ON orders(store_id);

CREATE INDEX idx_orders_date
ON orders(order_date);

CREATE INDEX idx_orders_status
ON orders(order_status);

CREATE INDEX idx_orders_sales_channel
ON orders(sales_channel);

-- =====================================================
-- ORDER ITEMS
-- =====================================================

CREATE INDEX idx_order_items_order
ON order_items(order_id);

CREATE INDEX idx_order_items_product
ON order_items(product_id);

-- =====================================================
-- PAYMENTS
-- =====================================================

CREATE INDEX idx_payments_order
ON payments(order_id);

CREATE INDEX idx_payments_status
ON payments(payment_status);

CREATE INDEX idx_payments_method
ON payments(payment_method);

-- =====================================================
-- SHIPMENTS
-- =====================================================

CREATE INDEX idx_shipments_order
ON shipments(order_id);

CREATE INDEX idx_shipments_warehouse
ON shipments(warehouse_id);

CREATE INDEX idx_shipments_status
ON shipments(delivery_status);

-- =====================================================
-- RETURNS
-- =====================================================

CREATE INDEX idx_returns_orderitem
ON returns(order_item_id);

-- =====================================================
-- COUPON USAGE
-- =====================================================

CREATE INDEX idx_coupon_customer
ON coupon_usage(customer_id);

CREATE INDEX idx_coupon_order
ON coupon_usage(order_id);

CREATE INDEX idx_coupon_promotion
ON coupon_usage(promotion_id);

-- =====================================================
-- REVIEWS
-- =====================================================

CREATE INDEX idx_reviews_product
ON reviews(product_id);

CREATE INDEX idx_reviews_customer
ON reviews(customer_id);

CREATE INDEX idx_reviews_rating
ON reviews(rating);

-- =====================================================
-- LOYALTY TRANSACTIONS
-- =====================================================

CREATE INDEX idx_loyalty_customer
ON loyalty_transactions(customer_id);

CREATE INDEX idx_loyalty_order
ON loyalty_transactions(order_id);

-- =====================================================
-- STOCK MOVEMENTS
-- =====================================================

CREATE INDEX idx_stock_product
ON stock_movements(product_id);

CREATE INDEX idx_stock_warehouse
ON stock_movements(warehouse_id);

CREATE INDEX idx_stock_date
ON stock_movements(movement_date);