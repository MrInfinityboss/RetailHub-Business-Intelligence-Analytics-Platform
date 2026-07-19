# Order Items

## Overview

The **Order Items** table is a transactional fact table that stores detailed information about each product included in a customer order. While the Orders table records order-level information, the Order Items table captures product-level details such as quantity, unit price, discounts, and line totals.

This table provides the granular transaction data required for product performance analysis, profitability calculations, inventory tracking, and customer purchasing behavior. It is one of the most critical tables in the RetailHub Enterprise Retail Data Warehouse and serves as the foundation for advanced business analytics.

---

# Business Purpose

The Order Items table records every product purchased within an order. It enables RetailHub to analyze sales at the product level, calculate revenue and profit, monitor purchasing trends, and support inventory planning.

This table supports:

- Product-level sales analysis
- Revenue calculation
- Profitability analysis
- Basket analysis
- Inventory consumption tracking
- Customer purchase behavior analysis

---

# Table Details

| Property | Value |
|----------|-------|
| Table Name | order_items |
| Table Type | Fact / Transactional Table |
| Storage Type | PostgreSQL |
| Estimated Records | 2,250,029 |
| Update Frequency | Very High |
| Primary Consumer | Sales, Inventory, Finance, Marketing, BI Team |

---

# Primary Key

| Column |
|---------|
| order_item_id |

---

# Foreign Keys

| Foreign Key | References |
|-------------|------------|
| order_id | Orders(order_id) |
| product_id | Products(product_id) |

---

# Columns

| Column | Data Type | Nullable | Description |
|---------|-----------|----------|-------------|
| order_item_id | BIGINT | No | Unique identifier for each order item |
| order_id | BIGINT | No | Associated customer order |
| product_id | BIGINT | No | Product purchased |
| quantity | INTEGER | No | Number of units purchased |
| unit_price | NUMERIC(10,2) | No | Selling price per unit at the time of purchase |
| discount_amount | NUMERIC(10,2) | No | Discount applied to this product |
| line_total | NUMERIC(12,2) | No | Total amount for this order item after discount |

---

# Relationships

```
                 Orders
                    │
                    │
                    ▼
              Order Items
                    ▲
                    │
                 Products
```

Each order consists of one or more order items, while each order item represents one product purchased in that order.

A product can appear in multiple order items across different customer orders.

---

# Business Rules

- Every order item must have a unique Order Item ID.
- Every order item must belong to one order.
- Every order item must reference one product.
- Quantity must be greater than zero.
- Unit price must be greater than zero.
- Discount amount cannot exceed the total product value.
- Line total must equal `(Quantity × Unit Price) − Discount Amount`.
- Every order must contain at least one order item.

---

# Data Quality Constraints

- `order_item_id` must be unique.
- `order_id` must exist in the Orders table.
- `product_id` must exist in the Products table.
- `quantity > 0`
- `unit_price > 0`
- `discount_amount >= 0`
- `discount_amount <= (quantity × unit_price)`
- `line_total >= 0`

---

# Used In Analytics

The Order Items table supports:

- Product Sales Analysis
- Revenue Analysis
- Gross Profit Analysis
- Product Profitability
- Best-Selling Products
- Slow-Moving Products
- Product Mix Analysis
- Basket Analysis
- Cross-Selling Analysis
- Customer Purchase Patterns
- Inventory Consumption Analysis
- Sales Forecasting

---

# Sample Business Questions

- Which products generate the highest revenue?
- Which products are sold most frequently?
- Which products contribute the highest profit?
- What is the average quantity purchased per order?
- Which products are commonly purchased together?
- Which products receive the highest discounts?
- Which categories contribute the highest sales volume?
- Which brands generate the highest product revenue?
- Which products have declining sales trends?
- Which products should be discontinued due to poor performance?

---

# Dependencies

## Parent Tables

- Orders
- Products

## Child Tables

None

---

# Notes

The Order Items table is the most granular sales table within the RetailHub Enterprise Retail Data Warehouse. Nearly all product-level analytics depend on this table, making it one of the highest-value datasets in the warehouse.

Because it contains over **2.25 million records**, query optimization through indexing, partitioning strategies (if required), and efficient SQL design is essential. This table serves as the foundation for advanced analytics such as product profitability, basket analysis, inventory optimization, customer purchasing behavior, and executive sales reporting.