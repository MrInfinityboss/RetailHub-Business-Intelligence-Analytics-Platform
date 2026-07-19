# Warehouses

## Overview

The **Warehouses** table is a master reference table that stores information about all warehouse facilities operated by RetailHub. Warehouses act as centralized storage locations where products are received from suppliers, stored as inventory, and dispatched to fulfill customer orders.

This table plays a critical role in inventory management, logistics, and supply chain operations. It provides the foundation for tracking stock availability, warehouse utilization, inventory movement, and fulfillment efficiency across the organization.

---

# Business Purpose

The Warehouses table maintains standardized information about all storage facilities within RetailHub's supply chain. It enables efficient inventory allocation, stock monitoring, warehouse performance analysis, and order fulfillment planning.

This table supports:

- Warehouse management
- Inventory storage
- Stock allocation
- Order fulfillment
- Supply chain optimization
- Logistics reporting

---

# Table Details

| Property | Value |
|----------|-------|
| Table Name | warehouses |
| Table Type | Master / Dimension Table |
| Storage Type | PostgreSQL |
| Estimated Records | 50 |
| Update Frequency | Rare |
| Primary Consumer | Inventory, Logistics, Supply Chain, BI Team |

---

# Primary Key

| Column |
|---------|
| warehouse_id |

---

# Foreign Keys

This table does not contain foreign keys.

It is referenced by:

- Inventory
- Stock Movements
- Shipments

---

# Columns

| Column | Data Type | Nullable | Description |
|---------|-----------|----------|-------------|
| warehouse_id | BIGINT | No | Unique identifier for each warehouse |
| warehouse_name | VARCHAR(150) | No | Name of the warehouse |
| city | VARCHAR(100) | No | Warehouse city |
| state | VARCHAR(100) | No | Warehouse state |
| country | VARCHAR(100) | No | Warehouse country |
| capacity | INTEGER | No | Maximum storage capacity |
| manager_name | VARCHAR(100) | Yes | Warehouse manager |

---

# Relationships

```
                    Warehouses
                    /    |    \
                   /     |     \
                  ▼      ▼      ▼
          Inventory  Stock Movements  Shipments
```

A warehouse can store many inventory records, generate multiple stock movements, and dispatch numerous shipments.

---

# Business Rules

- Every warehouse must have a unique Warehouse ID.
- Warehouse names should be unique.
- Each warehouse has a predefined storage capacity.
- Warehouses can store inventory for multiple products.
- Inventory levels cannot exceed warehouse capacity.
- Every shipment must originate from one warehouse.
- Warehouse information changes infrequently.

---

# Data Quality Constraints

- `warehouse_id` must be unique.
- `warehouse_name` cannot be NULL.
- `capacity` must be greater than zero.
- City, state, and country cannot be NULL.
- Duplicate warehouse names should not exist.

---

# Used In Analytics

The Warehouses table supports:

- Warehouse Utilization Analysis
- Inventory Distribution Analysis
- Storage Capacity Monitoring
- Warehouse Performance Analysis
- Stock Allocation Analysis
- Order Fulfillment Analysis
- Regional Inventory Analysis
- Supply Chain Performance

---

# Sample Business Questions

- Which warehouse stores the highest inventory?
- Which warehouse has the highest utilization rate?
- Which warehouse fulfills the most customer orders?
- Which warehouses frequently run out of stock?
- Which warehouse experiences the highest inventory turnover?
- Which region requires additional warehouse capacity?
- Which warehouse processes the most shipments?

---

# Dependencies

## Parent Tables

None

## Child Tables

- Inventory
- Stock Movements
- Shipments

---

# Notes

The Warehouses table serves as the operational backbone of RetailHub's inventory and logistics network. It enables efficient inventory storage, stock tracking, and shipment management while supporting enterprise-wide supply chain analytics.

Accurate warehouse information is essential for inventory optimization, fulfillment efficiency, and strategic capacity planning. As a low-volume master table, it provides stable reference data for multiple transactional processes throughout the data warehouse.