# Categories

## Overview

The **Categories** table is a master reference table that stores the classification of products offered by RetailHub. It organizes products into logical groups, enabling structured inventory management, sales reporting, marketing analysis, and business intelligence.

As a dimension table, Categories provides standardized product classification that supports consistent reporting across the enterprise. Each product belongs to exactly one category, allowing analysts to evaluate category-level performance, customer preferences, and revenue trends.

---

# Business Purpose

The Categories table serves as the primary classification system for products within the RetailHub Enterprise Retail Data Warehouse. It enables the organization to group products into meaningful business segments for operational management and analytical reporting.

This table supports:

- Product categorization
- Sales analysis by category
- Inventory monitoring
- Revenue contribution analysis
- Promotion performance by category
- Customer purchasing behavior analysis

---

# Table Details

| Property | Value |
|----------|-------|
| Table Name | categories |
| Table Type | Master / Dimension Table |
| Storage Type | PostgreSQL |
| Estimated Records | 25 |
| Update Frequency | Rare |
| Primary Consumer | Sales, Inventory, Marketing, BI Team |

---

# Primary Key

| Column |
|---------|
| category_id |

---

# Foreign Keys

This table does not contain foreign keys.

It is referenced by:

- Products

---

# Columns

| Column | Data Type | Nullable | Description |
|---------|-----------|----------|-------------|
| category_id | BIGINT | No | Unique identifier for each product category |
| category_name | VARCHAR(100) | No | Name of the product category |
| description | TEXT | Yes | Brief description of the category |

---

# Relationships

```
Categories
      │
      │ One-to-Many
      ▼
Products
```

A single category can contain multiple products, while each product belongs to only one category.

---

# Business Rules

- Every category must have a unique Category ID.
- Category names must be unique.
- A category may contain zero or many products.
- Every product must belong to exactly one category.
- Categories are considered master data and change infrequently.
- Category names should follow standardized business naming conventions.

---

# Data Quality Constraints

- `category_id` must be unique.
- `category_name` cannot be NULL.
- `category_name` must be unique.
- Description is optional.
- Duplicate category names are not allowed.

---

# Used In Analytics

The Categories table is used in:

- Sales by Category
- Revenue Contribution Analysis
- Product Mix Analysis
- Inventory Distribution
- Fast-Moving vs Slow-Moving Categories
- Category-wise Profitability
- Promotion Performance by Category
- Customer Purchase Preference Analysis

---

# Sample Business Questions

- Which product category generates the highest revenue?
- Which category has the largest number of products?
- Which category has the highest average product rating?
- Which categories experience the highest return rates?
- Which categories require inventory replenishment most frequently?
- Which product categories contribute the highest profit margins?
- Which categories perform best during promotional campaigns?

---

# Dependencies

### Parent Tables

None

### Child Tables

- Products

---

# Notes

The Categories table is a low-volume master table that provides standardized product classification across the RetailHub Enterprise Retail Data Warehouse. Since category information changes infrequently, it serves as a stable reference for transactional and analytical data.

Proper maintenance of this table ensures consistent reporting, simplifies business analysis, and supports scalable data warehouse design.