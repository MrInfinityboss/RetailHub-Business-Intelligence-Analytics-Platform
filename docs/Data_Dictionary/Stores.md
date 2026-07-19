# Stores

## Overview

The **Stores** table is a master reference table that maintains information about all physical retail stores operated by RetailHub. Each store represents a business location where customers can purchase products, collect online orders, and access customer support services.

This table enables store-level sales reporting, regional performance analysis, workforce management, and operational monitoring. It serves as a key dimension table for analyzing business performance across different geographical locations.

---

# Business Purpose

The Stores table provides standardized information about RetailHub's physical retail outlets. It supports operational management, sales analysis, employee allocation, and regional business intelligence.

This table supports:

- Store management
- Regional sales analysis
- Store performance reporting
- Employee allocation
- Customer purchase analysis
- Operational monitoring

---

# Table Details

| Property | Value |
|----------|-------|
| Table Name | stores |
| Table Type | Master / Dimension Table |
| Storage Type | PostgreSQL |
| Estimated Records | 100 |
| Update Frequency | Low |
| Primary Consumer | Sales, Operations, HR, BI Team |

---

# Primary Key

| Column |
|---------|
| store_id |

---

# Foreign Keys

This table does not contain foreign keys.

It is referenced by:

- Employees
- Orders

---

# Columns

| Column | Data Type | Nullable | Description |
|---------|-----------|----------|-------------|
| store_id | BIGINT | No | Unique identifier for each store |
| store_name | VARCHAR(150) | No | Name of the retail store |
| city | VARCHAR(100) | No | Store city |
| state | VARCHAR(100) | No | Store state |
| country | VARCHAR(100) | No | Store country |
| opening_date | DATE | Yes | Date the store became operational |
| store_type | VARCHAR(50) | No | Type of store (Flagship, Standard, Express, etc.) |

---

# Relationships

```
               Stores
              /      \
             /        \
            ▼          ▼
      Employees     Orders
```

One store can employ many employees and process many customer orders.

---

# Business Rules

- Every store must have a unique Store ID.
- Store names should be unique within the organization.
- Every employee must be assigned to one store.
- Orders placed through physical retail locations are associated with a store.
- Store opening dates cannot be in the future.
- Closed stores should remain in the database to preserve historical reporting.

---

# Data Quality Constraints

- `store_id` must be unique.
- `store_name` cannot be NULL.
- City, state, and country cannot be NULL.
- `opening_date` must be less than or equal to the current date.
- `store_type` must contain valid business values.
- Duplicate store names should be avoided.

---

# Used In Analytics

The Stores table supports:

- Store-wise Sales Analysis
- Regional Revenue Analysis
- Store Performance Comparison
- Customer Distribution Analysis
- Employee Performance Analysis
- Footfall and Sales Correlation
- Geographic Sales Trends
- Store Profitability Analysis

---

# Sample Business Questions

- Which store generates the highest revenue?
- Which stores receive the highest number of customer orders?
- Which region contributes the highest sales?
- Which stores have the highest average order value?
- Which stores consistently outperform others?
- Which store requires additional staffing?
- Which stores experience seasonal sales fluctuations?

---

# Dependencies

## Parent Tables

None

## Child Tables

- Employees
- Orders

---

# Notes

The Stores table provides the geographical and operational foundation for RetailHub's physical retail network. It enables comprehensive store-level reporting, supports regional performance analysis, and facilitates workforce management.

Maintaining accurate store information ensures reliable operational reporting, better resource allocation, and informed strategic decisions regarding retail expansion and performance optimization.