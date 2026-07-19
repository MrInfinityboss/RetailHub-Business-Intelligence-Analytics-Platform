# Products

## Overview

The **Products** table is the central master table of the RetailHub Enterprise Retail Data Warehouse. It stores detailed information about every product offered by the company and acts as the primary reference for sales, inventory, procurement, marketing, and customer analytics.

Every product is associated with a category, brand, and supplier, making this table the core entity that connects multiple business domains. It enables comprehensive product lifecycle management and serves as the foundation for analytical reporting across the organization.

---

# Business Purpose

The Products table maintains standardized information about all products sold by RetailHub. It provides the foundation for product management, inventory tracking, sales analysis, pricing strategies, supplier management, and customer purchasing behavior.

This table supports:

- Product catalog management
- Pricing analysis
- Sales reporting
- Inventory management
- Procurement planning
- Product profitability analysis
- Customer purchase analysis
- Marketing campaign evaluation

---

# Table Details

| Property | Value |
|----------|-------|
| Table Name | products |
| Table Type | Master / Dimension Table |
| Storage Type | PostgreSQL |
| Estimated Records | 20,000 |
| Update Frequency | Medium |
| Primary Consumer | Sales, Inventory, Procurement, Marketing, BI Team |

---

# Primary Key

| Column |
|---------|
| product_id |

---

# Foreign Keys

| Foreign Key | References |
|-------------|------------|
| category_id | Categories(category_id) |
| brand_id | Brands(brand_id) |
| supplier_id | Suppliers(supplier_id) |

---

# Columns

| Column | Data Type | Nullable | Description |
|---------|-----------|----------|-------------|
| product_id | BIGINT | No | Unique identifier for each product |
| product_name | VARCHAR(200) | No | Name of the product |
| category_id | BIGINT | No | Associated product category |
| brand_id | BIGINT | No | Associated brand |
| supplier_id | BIGINT | No | Supplier providing the product |
| cost_price | NUMERIC(10,2) | No | Cost incurred to purchase the product |
| selling_price | NUMERIC(10,2) | No | Selling price offered to customers |
| weight | NUMERIC(8,2) | Yes | Product weight |
| color | VARCHAR(50) | Yes | Product color |
| launch_date | DATE | Yes | Date when the product was introduced |
| status | VARCHAR(20) | No | Product availability status |

---

# Relationships

```
                Categories
                     │
                     │
Brands ─────── Products ─────── Suppliers
                     │
      ┌──────────────┼───────────────┐
      │              │               │
Inventory      Order Items      Reviews
      │
Stock Movements
```

The Products table serves as the central hub connecting master data with transactional and analytical data.

---

# Business Rules

- Every product must have a unique Product ID.
- Every product must belong to one category.
- Every product must belong to one brand.
- Every product must have one supplier.
- Selling price must be greater than or equal to cost price.
- Products may exist without sales history.
- Product names should remain consistent across all systems.
- Inactive products should not be deleted to preserve historical reporting.

---

# Data Quality Constraints

- `product_id` must be unique.
- `product_name` cannot be NULL.
- `category_id` must exist in the Categories table.
- `brand_id` must exist in the Brands table.
- `supplier_id` must exist in the Suppliers table.
- `cost_price` must be greater than or equal to 0.
- `selling_price` must be greater than or equal to `cost_price`.
- Product status must contain valid business values (Active, Inactive, Discontinued).

---

# Used In Analytics

The Products table supports:

- Product Performance Analysis
- Revenue Analysis
- Profit Margin Analysis
- Category-wise Sales
- Brand-wise Sales
- Inventory Optimization
- Product Return Analysis
- Customer Purchase Behavior
- Product Rating Analysis
- Promotion Effectiveness
- Fast-Moving Product Analysis
- Slow-Moving Product Analysis
- ABC Inventory Analysis

---

# Sample Business Questions

- Which products generate the highest revenue?
- Which products generate the highest profit?
- Which products have the highest sales volume?
- Which products have the highest return rate?
- Which products receive the best customer ratings?
- Which products require frequent restocking?
- Which brands contribute the highest-performing products?
- Which categories contain the most profitable products?
- Which products are frequently purchased together?
- Which inactive products should be discontinued permanently?

---

# Dependencies

## Parent Tables

- Categories
- Brands
- Suppliers

## Child Tables

- Inventory
- Order Items
- Reviews

---

# Notes

The Products table is the core master entity of the RetailHub Enterprise Retail Data Warehouse. Nearly every business process—including sales, procurement, inventory, logistics, and customer analytics—depends on accurate product information.

Because this table connects multiple master and transactional tables, maintaining data integrity through primary keys, foreign keys, and business rules is critical. Proper product data enables reliable reporting, efficient inventory planning, accurate profitability analysis, and informed business decision-making across the organization.