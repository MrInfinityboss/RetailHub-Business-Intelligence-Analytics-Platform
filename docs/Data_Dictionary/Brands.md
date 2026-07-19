# Brands

## Overview

The **Brands** table is a master reference table that stores information about the brands whose products are sold by RetailHub. It provides standardized brand information used across product management, sales, marketing, inventory, and business intelligence.

As a dimension table, Brands enables consistent reporting by allowing products to be grouped under their respective manufacturers or brand owners. This supports brand-level performance analysis, customer preference tracking, and strategic decision-making.

---

# Business Purpose

The Brands table serves as the centralized repository for all product brand information within the RetailHub Enterprise Retail Data Warehouse.

It enables the organization to:

- Organize products by brand
- Analyze brand-wise sales performance
- Measure customer brand preferences
- Evaluate promotional effectiveness by brand
- Compare profitability across brands
- Support inventory planning based on brand demand

---

# Table Details

| Property | Value |
|----------|-------|
| Table Name | brands |
| Table Type | Master / Dimension Table |
| Storage Type | PostgreSQL |
| Estimated Records | 200 |
| Update Frequency | Rare |
| Primary Consumer | Sales, Marketing, Inventory, BI Team |

---

# Primary Key

| Column |
|---------|
| brand_id |

---

# Foreign Keys

This table does not contain foreign keys.

It is referenced by:

- Products

---

# Columns

| Column | Data Type | Nullable | Description |
|---------|-----------|----------|-------------|
| brand_id | BIGINT | No | Unique identifier for each brand |
| brand_name | VARCHAR(100) | No | Name of the brand |
| country | VARCHAR(100) | Yes | Country where the brand originated |
| established_year | INTEGER | Yes | Year the brand was established |

---

# Relationships

```
Brands
    │
    │ One-to-Many
    ▼
Products
```

One brand can have multiple products, while every product belongs to exactly one brand.

---

# Business Rules

- Every brand must have a unique Brand ID.
- Brand names must be unique.
- Each product must belong to exactly one brand.
- A brand may have zero or many products.
- Established year cannot be in the future.
- Brand information changes infrequently and is considered master data.

---

# Data Quality Constraints

- `brand_id` must be unique.
- `brand_name` cannot be NULL.
- `brand_name` must be unique.
- `established_year` must be less than or equal to the current year.
- Country is optional but should follow standardized country names.

---

# Used In Analytics

The Brands table supports:

- Brand Revenue Analysis
- Brand-wise Sales Trends
- Product Portfolio Analysis
- Market Share Analysis
- Customer Brand Preference Analysis
- Brand Profitability Analysis
- Promotion Performance by Brand
- Brand Return Rate Analysis

---

# Sample Business Questions

- Which brand generates the highest revenue?
- Which brands sell the most products?
- Which brand has the highest average customer rating?
- Which brands experience the highest return rates?
- Which brands contribute the highest profit?
- Which brands perform best during promotional campaigns?
- Which brands have the fastest inventory turnover?

---

# Dependencies

### Parent Tables

None

### Child Tables

- Products

---

# Notes

The Brands table is a low-volume master table that standardizes brand information across the RetailHub Enterprise Retail Data Warehouse. It enables accurate product classification, simplifies reporting, and provides the foundation for brand-level analytics.

Maintaining clean and consistent brand data ensures reliable insights for sales, marketing, inventory planning, and executive decision-making.