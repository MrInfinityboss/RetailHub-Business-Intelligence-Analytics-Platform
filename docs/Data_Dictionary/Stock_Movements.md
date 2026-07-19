# Stock Movements

## Overview

The **Stock Movements** table is a transactional table that records every inventory movement within the RetailHub supply chain. Each record represents a stock transaction such as receiving inventory from suppliers, customer sales, product returns, warehouse transfers, or inventory adjustments.

Unlike the Inventory table, which stores the current stock balance, the Stock Movements table maintains the complete history of inventory changes. This provides a detailed audit trail, supports inventory reconciliation, and enables advanced warehouse and supply chain analytics.

---

# Business Purpose

The Stock Movements table captures every change in inventory quantities across warehouses. It enables RetailHub to monitor stock flow, analyze inventory movement patterns, detect discrepancies, and support operational decision-making.

This table supports:

- Inventory transaction tracking
- Warehouse operations
- Inventory auditing
- Supply chain monitoring
- Stock reconciliation
- Operational reporting

---

# Table Details

| Property | Value |
|----------|-------|
| Table Name | stock_movements |
| Table Type | Transactional Table |
| Storage Type | PostgreSQL |
| Estimated Records | 400,000 |
| Update Frequency | Very High |
| Primary Consumer | Inventory Team, Warehouse Operations, Supply Chain, BI Team |

---

# Primary Key

| Column |
|---------|
| movement_id |

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
| movement_id | BIGINT | No | Unique identifier for each stock movement |
| product_id | BIGINT | No | Product involved in the movement |
| warehouse_id | BIGINT | No | Warehouse where the movement occurred |
| movement_type | VARCHAR(30) | No | Type of inventory movement |
| quantity | INTEGER | No | Number of units moved |
| movement_date | TIMESTAMP | No | Date and time of the inventory movement |
| reference_number | VARCHAR(100) | Yes | Reference document or transaction ID |

---

# Relationships

```
Products
     │
     │
     ▼
Stock Movements
     ▲
     │
Warehouses
```

Each stock movement is associated with one product and one warehouse.

A product can have many stock movement records throughout its lifecycle.

---

# Business Rules

- Every stock movement must have a unique Movement ID.
- Every movement must reference one product.
- Every movement must reference one warehouse.
- Quantity must always be greater than zero.
- Movement type must contain a valid business value.
- Every inventory change should generate exactly one stock movement record.
- Stock movements cannot be deleted once recorded to preserve audit history.

---

# Data Quality Constraints

- `movement_id` must be unique.
- `product_id` must exist in the Products table.
- `warehouse_id` must exist in the Warehouses table.
- `quantity > 0`
- `movement_date` cannot be NULL.
- `movement_type` must contain one of the following values:
  - Purchase
  - Sale
  - Return
  - Transfer In
  - Transfer Out
  - Stock Adjustment
- Reference number is optional.

---

# Used In Analytics

The Stock Movements table supports:

- Inventory Movement Analysis
- Warehouse Activity Analysis
- Stock Replenishment Analysis
- Inventory Audit Reporting
- Product Demand Analysis
- Inventory Turnover Analysis
- Warehouse Efficiency Analysis
- Supply Chain Performance
- Stock Adjustment Monitoring
- Inventory Loss Analysis

---

# Sample Business Questions

- Which products have the highest inventory movement?
- Which warehouses process the largest number of stock transactions?
- How much inventory was received from suppliers this month?
- Which products require frequent stock replenishment?
- What percentage of stock movements are customer returns?
- Which warehouses perform the highest number of inventory adjustments?
- Which products experience the highest outbound movement?
- How frequently is inventory transferred between warehouses?

---

# Dependencies

## Parent Tables

- Products
- Warehouses

## Child Tables

None

---

# Notes

The Stock Movements table provides the complete transaction history of inventory activities across RetailHub's warehouse network. It complements the Inventory table by recording every stock change rather than only the current balance.

This table is essential for inventory auditing, operational transparency, warehouse performance analysis, and supply chain optimization. Maintaining an accurate and immutable history of stock movements enables reliable inventory reconciliation and supports advanced analytical reporting throughout the organization.