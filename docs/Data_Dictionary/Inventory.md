# Inventory

## Overview

The **Inventory** table is a transactional table that stores the current stock levels of products across RetailHub's warehouses. It acts as the bridge between products and warehouses, providing real-time visibility into inventory availability and supporting efficient warehouse operations.

This table is essential for inventory planning, stock monitoring, replenishment decisions, and order fulfillment. It enables business users to determine product availability, identify stock shortages, optimize warehouse utilization, and improve supply chain efficiency.

---

# Business Purpose

The Inventory table maintains the current quantity of every product stored in each warehouse. It enables RetailHub to monitor inventory levels, support order fulfillment, prevent stockouts, and optimize warehouse capacity.

This table supports:

- Inventory management
- Stock availability monitoring
- Warehouse stock allocation
- Replenishment planning
- Inventory optimization
- Supply chain analysis

---

# Table Details

| Property | Value |
|----------|-------|
| Table Name | inventory |
| Table Type | Transactional Table |
| Storage Type | PostgreSQL |
| Estimated Records | 200,000 |
| Update Frequency | Very High |
| Primary Consumer | Inventory Team, Warehouse Operations, Supply Chain, BI Team |

---

# Primary Key

| Column |
|---------|
| inventory_id |

---

# Foreign Keys

| Foreign Key | References |
|-------------|------------|
| product_id | Products(product_id) |
| warehouse_id | Warehouses(warehouse_id) |

---

# Columns

| Column | Data Type | Nullable | Description |
|---------|-----------|----------|-------------|
| inventory_id | BIGINT | No | Unique identifier for each inventory record |
| product_id | BIGINT | No | Product stored in the warehouse |
| warehouse_id | BIGINT | No | Warehouse where the product is stored |
| stock_quantity | INTEGER | No | Current quantity available |
| reorder_level | INTEGER | No | Minimum stock level before replenishment |
| last_updated | TIMESTAMP | No | Date and time of the latest inventory update |

---

# Relationships

```
Products
     │
     │
     ▼
 Inventory
     ▲
     │
Warehouses
```

Each inventory record represents the stock quantity of one product in one warehouse.

A product may exist in multiple warehouses, and a warehouse stores multiple products.

---

# Business Rules

- Every inventory record must have a unique Inventory ID.
- Every inventory record must reference one product.
- Every inventory record must reference one warehouse.
- Stock quantity cannot be negative.
- Reorder level must be greater than or equal to zero.
- Each product can appear only once within the same warehouse.
- Inventory records are updated whenever stock is received, sold, returned, or transferred.

---

# Data Quality Constraints

- `inventory_id` must be unique.
- `product_id` must exist in the Products table.
- `warehouse_id` must exist in the Warehouses table.
- `stock_quantity >= 0`
- `reorder_level >= 0`
- `last_updated` cannot be NULL.
- `(product_id, warehouse_id)` should be unique to prevent duplicate inventory records.

---

# Used In Analytics

The Inventory table supports:

- Inventory Availability Analysis
- Stock Level Monitoring
- Warehouse Utilization Analysis
- Inventory Turnover Analysis
- Stockout Analysis
- Overstock Analysis
- Reorder Planning
- ABC Inventory Analysis
- Supply Chain Optimization
- Inventory Aging Analysis

---

# Sample Business Questions

- Which products are currently out of stock?
- Which warehouses hold the highest inventory value?
- Which products require immediate replenishment?
- Which products are overstocked?
- What is the inventory turnover by product category?
- Which warehouses have the highest stock utilization?
- How much inventory is available for a specific product across all warehouses?
- Which products have remained unsold for long periods?

---

# Dependencies

## Parent Tables

- Products
- Warehouses

## Child Tables

- Stock Movements

---

# Notes

The Inventory table is one of the most frequently updated transactional tables in the RetailHub Enterprise Retail Data Warehouse. It provides a real-time view of stock availability and plays a critical role in inventory management, warehouse operations, and order fulfillment.

Accurate inventory records are essential for preventing stock shortages, reducing excess inventory, improving customer satisfaction, and optimizing overall supply chain performance. This table also serves as the foundation for inventory-related dashboards, warehouse analytics, and replenishment strategies.