# Suppliers

## Overview

The **Suppliers** table is a master reference table that stores information about vendors responsible for supplying products to RetailHub. It acts as the central repository for supplier-related data and supports procurement, inventory management, product sourcing, and supply chain analytics.

As a dimension table, Suppliers enables the organization to evaluate vendor performance, monitor procurement efficiency, analyze supplier contributions, and ensure a reliable supply chain across all warehouses and stores.

---

# Business Purpose

The Suppliers table maintains standardized information about organizations that provide products to RetailHub. It establishes the relationship between suppliers and products, enabling efficient procurement management and supplier performance evaluation.

This table supports:

- Supplier management
- Product sourcing
- Procurement analysis
- Supplier performance evaluation
- Inventory planning
- Supply chain reporting

---

# Table Details

| Property | Value |
|----------|-------|
| Table Name | suppliers |
| Table Type | Master / Dimension Table |
| Storage Type | PostgreSQL |
| Estimated Records | 300 |
| Update Frequency | Low |
| Primary Consumer | Procurement, Inventory, Supply Chain, BI Team |

---

# Primary Key

| Column |
|---------|
| supplier_id |

---

# Foreign Keys

This table does not contain foreign keys.

It is referenced by:

- Products

---

# Columns

| Column | Data Type | Nullable | Description |
|---------|-----------|----------|-------------|
| supplier_id | BIGINT | No | Unique identifier for each supplier |
| supplier_name | VARCHAR(150) | No | Name of the supplier company |
| contact_person | VARCHAR(100) | Yes | Primary contact person |
| email | VARCHAR(150) | Yes | Supplier email address |
| phone | VARCHAR(20) | Yes | Supplier contact number |
| city | VARCHAR(100) | Yes | Supplier city |
| state | VARCHAR(100) | Yes | Supplier state |
| country | VARCHAR(100) | Yes | Supplier country |

---

# Relationships

```
Suppliers
      │
      │ One-to-Many
      ▼
Products
```

One supplier can supply multiple products, while each product is supplied by one supplier.

---

# Business Rules

- Every supplier must have a unique Supplier ID.
- Supplier names should be unique.
- A supplier can supply multiple products.
- Every product must have one assigned supplier.
- Contact information should remain updated.
- Suppliers may continue to exist even if they currently supply no active products.

---

# Data Quality Constraints

- `supplier_id` must be unique.
- `supplier_name` cannot be NULL.
- Email addresses should follow a valid email format.
- Phone numbers should follow standard business formats.
- Duplicate supplier names should be avoided.
- Country and state names should follow standardized naming conventions.

---

# Used In Analytics

The Suppliers table supports:

- Supplier Performance Analysis
- Procurement Analysis
- Revenue Contribution by Supplier
- Product Availability Analysis
- Inventory Replenishment Planning
- Return Rate by Supplier
- Supply Chain Performance
- Vendor-wise Product Distribution

---

# Sample Business Questions

- Which supplier contributes the highest revenue?
- Which supplier provides the largest number of products?
- Which suppliers have the highest product return rates?
- Which suppliers generate the highest profit?
- Which suppliers support the most product categories?
- Which suppliers require frequent inventory replenishment?
- Which suppliers contribute the most to total inventory value?

---

# Dependencies

### Parent Tables

None

### Child Tables

- Products

---

# Notes

The Suppliers table is a foundational master table within the RetailHub Enterprise Retail Data Warehouse. It provides standardized supplier information used across procurement, inventory, and product management processes.

Maintaining accurate supplier data enables effective supply chain monitoring, improves procurement decisions, and supports comprehensive supplier performance analytics. Since supplier information changes infrequently, this table serves as a stable reference for transactional and analytical operations.