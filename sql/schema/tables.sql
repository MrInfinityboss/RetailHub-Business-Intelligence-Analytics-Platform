/*
=====================================================
RetailHub Enterprise Retail Data Warehouse
Table Creation Script
=====================================================
*/

SET search_path TO retailhub;

-- ==========================
-- Categories
-- ==========================
CREATE TABLE categories (
    category_id BIGINT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    parent_category VARCHAR(100)
);

-- ==========================
-- Brands
-- ==========================
CREATE TABLE brands (
    brand_id BIGINT PRIMARY KEY,
    brand_name VARCHAR(150) NOT NULL,
    country VARCHAR(100),
    founded_year INT
);

-- ==========================
-- Suppliers
-- ==========================
CREATE TABLE suppliers (
    supplier_id BIGINT PRIMARY KEY,
    supplier_name VARCHAR(150) NOT NULL,
    city VARCHAR(100),
    country VARCHAR(100),
    rating NUMERIC(3,2),
    contract_start_date DATE
);

-- ==========================
-- Warehouses
-- ==========================
CREATE TABLE warehouses (
    warehouse_id BIGINT PRIMARY KEY,
    warehouse_name VARCHAR(150),
    city VARCHAR(100),
    state VARCHAR(100),
    capacity INT,
    manager_id BIGINT
);

-- ==========================
-- Stores
-- ==========================
CREATE TABLE stores (
    store_id BIGINT PRIMARY KEY,
    store_name VARCHAR(150),
    city VARCHAR(100),
    state VARCHAR(100),
    opening_date DATE,
    manager_id BIGINT
);

-- ==========================
-- Customers
-- ==========================
CREATE TABLE customers (
    customer_id BIGINT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    gender VARCHAR(20),
    dob DATE,
    email VARCHAR(255),
    phone VARCHAR(20),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    registration_date DATE,
    membership_level VARCHAR(50)
);

-- ==========================
-- Employees
-- ==========================
CREATE TABLE employees (
    employee_id BIGINT PRIMARY KEY,
    employee_name VARCHAR(150),
    department VARCHAR(100),
    designation VARCHAR(100),
    store_id BIGINT,
    warehouse_id BIGINT,
    hire_date DATE,
    salary NUMERIC(12,2)
);

-- ==========================
-- Promotions
-- ==========================
CREATE TABLE promotions (
    promotion_id BIGINT PRIMARY KEY,
    campaign_name VARCHAR(150),
    discount_percent NUMERIC(5,2),
    start_date DATE,
    end_date DATE,
    promotion_type VARCHAR(50)
);

-- ==========================
-- Products
-- ==========================
CREATE TABLE products (
    product_id BIGINT PRIMARY KEY,
    product_name VARCHAR(255),
    category_id BIGINT,
    supplier_id BIGINT,
    brand_id BIGINT,
    selling_price NUMERIC(12,2),
    cost_price NUMERIC(12,2),
    launch_date DATE,
    status VARCHAR(50)
);


-- =====================================================
-- Inventory
-- =====================================================

CREATE TABLE inventory (
    inventory_id BIGINT PRIMARY KEY,
    warehouse_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    stock_quantity INT NOT NULL,
    reorder_level INT,
    last_stock_update DATE
);

-- =====================================================
-- Orders
-- =====================================================

CREATE TABLE orders (
    order_id BIGINT PRIMARY KEY,
    customer_id BIGINT NOT NULL,
    store_id BIGINT NOT NULL,
    order_date DATE NOT NULL,
    sales_channel VARCHAR(50),
    order_status VARCHAR(50)
);

-- =====================================================
-- Order Items
-- =====================================================

CREATE TABLE order_items (
    order_item_id BIGINT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    quantity INT,
    unit_price NUMERIC(12,2),
    discount NUMERIC(10,2),
    tax NUMERIC(10,2)
);

-- =====================================================
-- Payments
-- =====================================================

CREATE TABLE payments (
    payment_id BIGINT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    payment_date DATE,
    amount NUMERIC(12,2)
);

-- =====================================================
-- Shipments
-- =====================================================

CREATE TABLE shipments (
    shipment_id BIGINT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    warehouse_id BIGINT,
    carrier VARCHAR(100),
    ship_date DATE,
    delivery_date DATE,
    delivery_status VARCHAR(50),
    shipping_cost NUMERIC(12,2)
);

-- =====================================================
-- Returns
-- =====================================================

CREATE TABLE returns (
    return_id BIGINT PRIMARY KEY,
    order_item_id BIGINT NOT NULL,
    return_date DATE,
    reason TEXT,
    refund_amount NUMERIC(12,2)
);

-- =====================================================
-- Coupon Usage
-- =====================================================

CREATE TABLE coupon_usage (
    coupon_id BIGINT PRIMARY KEY,
    promotion_id BIGINT NOT NULL,
    customer_id BIGINT NOT NULL,
    order_id BIGINT NOT NULL,
    discount_amount NUMERIC(10,2)
);

-- =====================================================
-- Reviews
-- =====================================================

CREATE TABLE reviews (
    review_id BIGINT PRIMARY KEY,
    product_id BIGINT NOT NULL,
    customer_id BIGINT NOT NULL,
    order_id BIGINT NOT NULL,
    rating INT,
    review_text TEXT,
    review_date DATE,
    verified_purchase BOOLEAN
);

-- =====================================================
-- Loyalty Transactions
-- =====================================================

CREATE TABLE loyalty_transactions (
    loyalty_txn_id BIGINT PRIMARY KEY,
    customer_id BIGINT NOT NULL,
    order_id BIGINT NOT NULL,
    points_earned INT,
    points_redeemed INT,
    transaction_date DATE,
    balance_after INT
);

-- =====================================================
-- Stock Movements
-- =====================================================

CREATE TABLE stock_movements (
    movement_id BIGINT PRIMARY KEY,
    warehouse_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    movement_type VARCHAR(50),
    quantity INT,
    movement_date DATE
);