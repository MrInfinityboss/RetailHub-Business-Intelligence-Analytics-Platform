/*
=====================================================
RetailHub Enterprise Retail Data Warehouse
Foreign Key Constraints
=====================================================
*/

SET search_path TO retailhub;

-- =====================================================
-- Products
-- =====================================================

ALTER TABLE products
ADD CONSTRAINT fk_products_category
FOREIGN KEY (category_id)
REFERENCES categories(category_id);

ALTER TABLE products
ADD CONSTRAINT fk_products_brand
FOREIGN KEY (brand_id)
REFERENCES brands(brand_id);

ALTER TABLE products
ADD CONSTRAINT fk_products_supplier
FOREIGN KEY (supplier_id)
REFERENCES suppliers(supplier_id);

-- =====================================================
-- Employees
-- =====================================================

ALTER TABLE employees
ADD CONSTRAINT fk_employee_store
FOREIGN KEY (store_id)
REFERENCES stores(store_id);

ALTER TABLE employees
ADD CONSTRAINT fk_employee_warehouse
FOREIGN KEY (warehouse_id)
REFERENCES warehouses(warehouse_id);

-- =====================================================
-- Inventory
-- =====================================================

ALTER TABLE inventory
ADD CONSTRAINT fk_inventory_product
FOREIGN KEY (product_id)
REFERENCES products(product_id);

ALTER TABLE inventory
ADD CONSTRAINT fk_inventory_warehouse
FOREIGN KEY (warehouse_id)
REFERENCES warehouses(warehouse_id);

-- =====================================================
-- Orders
-- =====================================================

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_store
FOREIGN KEY (store_id)
REFERENCES stores(store_id);

-- =====================================================
-- Order Items
-- =====================================================

ALTER TABLE order_items
ADD CONSTRAINT fk_orderitems_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_orderitems_product
FOREIGN KEY (product_id)
REFERENCES products(product_id);

-- =====================================================
-- Payments
-- =====================================================

ALTER TABLE payments
ADD CONSTRAINT fk_payments_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- =====================================================
-- Shipments
-- =====================================================

ALTER TABLE shipments
ADD CONSTRAINT fk_shipments_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

ALTER TABLE shipments
ADD CONSTRAINT fk_shipments_warehouse
FOREIGN KEY (warehouse_id)
REFERENCES warehouses(warehouse_id);

-- =====================================================
-- Returns
-- =====================================================

ALTER TABLE returns
ADD CONSTRAINT fk_returns_orderitem
FOREIGN KEY (order_item_id)
REFERENCES order_items(order_item_id);

-- =====================================================
-- Coupon Usage
-- =====================================================

ALTER TABLE coupon_usage
ADD CONSTRAINT fk_coupon_promotion
FOREIGN KEY (promotion_id)
REFERENCES promotions(promotion_id);

ALTER TABLE coupon_usage
ADD CONSTRAINT fk_coupon_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE coupon_usage
ADD CONSTRAINT fk_coupon_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- =====================================================
-- Reviews
-- =====================================================

ALTER TABLE reviews
ADD CONSTRAINT fk_reviews_product
FOREIGN KEY (product_id)
REFERENCES products(product_id);

ALTER TABLE reviews
ADD CONSTRAINT fk_reviews_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE reviews
ADD CONSTRAINT fk_reviews_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- =====================================================
-- Loyalty Transactions
-- =====================================================

ALTER TABLE loyalty_transactions
ADD CONSTRAINT fk_loyalty_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE loyalty_transactions
ADD CONSTRAINT fk_loyalty_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- =====================================================
-- Stock Movements
-- =====================================================

ALTER TABLE stock_movements
ADD CONSTRAINT fk_stock_product
FOREIGN KEY (product_id)
REFERENCES products(product_id);

ALTER TABLE stock_movements
ADD CONSTRAINT fk_stock_warehouse
FOREIGN KEY (warehouse_id)
REFERENCES warehouses(warehouse_id);