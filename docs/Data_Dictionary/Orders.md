# Orders

## Overview

The **Orders** table is the primary transactional table in the RetailHub Enterprise Retail Data Warehouse. It records every customer purchase made through RetailHub's sales channels, including physical stores, the e-commerce website, and the mobile application.

Each order represents a completed business transaction and acts as the central entity connecting customers, stores, order items, payments, shipments, returns, promotions, and loyalty programs. As the largest business transaction table, it serves as the foundation for revenue reporting, customer analytics, operational monitoring, and executive decision-making.

---

# Business Purpose

The Orders table stores high-level information about every customer order placed within RetailHub. It enables the organization to monitor sales performance, analyze customer purchasing behavior, track order fulfillment, and support financial reporting.

This table supports:

- Sales transaction management
- Revenue reporting
- Customer purchase tracking
- Order lifecycle monitoring
- Sales channel analysis
- Business performance reporting

---

# Table Details

| Property | Value |
|----------|-------|
| Table Name | orders |
| Table Type | Fact / Transactional Table |
| Storage Type | PostgreSQL |
| Estimated Records | 500,000 |
| Update Frequency | Very High |
| Primary Consumer | Sales, Finance, Marketing, Operations, BI Team |

---

# Primary Key

| Column |
|---------|
| order_id |

---

# Foreign Keys

| Foreign Key | References |
|-------------|------------|
| customer_id | Customers(customer_id) |
| store_id | Stores(store_id) |

---

# Columns

| Column | Data Type | Nullable | Description |
|---------|-----------|----------|-------------|
| order_id | BIGINT | No | Unique identifier for each order |
| customer_id | BIGINT | No | Customer who placed the order |
| store_id | BIGINT | Yes | Store where the order was placed (if applicable) |
| order_date | TIMESTAMP | No | Date and time when the order was placed |
| order_status | VARCHAR(30) | No | Current order status |
| sales_channel | VARCHAR(30) | No | Channel through which the order was placed |
| subtotal | NUMERIC(12,2) | No | Total value before discounts and taxes |
| discount_amount | NUMERIC(10,2) | No | Total discount applied |
| tax_amount | NUMERIC(10,2) | No | Tax charged on the order |
| shipping_cost | NUMERIC(10,2) | No | Shipping charges |
| total_amount | NUMERIC(12,2) | No | Final payable amount |

---

# Relationships

```
                    Customers
                        │
                        ▼
                     Orders
        ┌───────────┼────────────┬────────────┐
        ▼           ▼            ▼            ▼
 Order Items   Payments    Shipments     Returns
        │
        ▼
Coupon Usage
```

Each order belongs to one customer and may contain multiple order items, one payment, one shipment, and one or more return records.

---

# Business Rules

- Every order must have a unique Order ID.
- Every order belongs to exactly one customer.
- An order must contain at least one order item.
- Every completed order must have one payment record.
- Orders can have only one sales channel.
- Cancelled orders cannot be shipped.
- Returned orders must reference an existing completed order.
- Total amount must equal subtotal minus discount plus tax and shipping cost.

---

# Data Quality Constraints

- `order_id` must be unique.
- `customer_id` must exist in the Customers table.
- `store_id` must exist in the Stores table when applicable.
- `order_date` cannot be NULL.
- `subtotal >= 0`
- `discount_amount >= 0`
- `tax_amount >= 0`
- `shipping_cost >= 0`
- `total_amount >= 0`
- `order_status` must contain valid business values:
  - Pending
  - Confirmed
  - Shipped
  - Delivered
  - Cancelled
  - Returned
- `sales_channel` must contain one of:
  - Website
  - Mobile App
  - Store

---

# Used In Analytics

The Orders table supports:

- Revenue Analysis
- Sales Trend Analysis
- Daily Sales Reporting
- Monthly Revenue Analysis
- Customer Purchase Analysis
- Average Order Value (AOV)
- Sales Channel Performance
- Store Performance Analysis
- Seasonal Sales Analysis
- Order Fulfillment Analysis
- Customer Retention Analysis
- Executive KPI Dashboards

---

# Sample Business Questions

- What is the total revenue generated this month?
- Which sales channel generates the highest revenue?
- Which customers place the highest number of orders?
- What is the average order value by region?
- Which days experience the highest order volume?
- What percentage of orders are cancelled?
- Which stores generate the highest sales?
- How does revenue change across different seasons?
- Which customers have not placed an order recently?
- What is the order completion rate?

---

# Dependencies

## Parent Tables

- Customers
- Stores

## Child Tables

- Order Items
- Payments
- Shipments
- Returns
- Coupon Usage

---

# Notes

The Orders table is the central fact table of the RetailHub Enterprise Retail Data Warehouse and serves as the foundation for nearly all business reporting. It connects customer, product, financial, logistics, and marketing data into a unified transactional model.

Because of its strategic importance, this table is frequently queried for executive dashboards, financial reporting, customer analytics, and operational monitoring. Maintaining data integrity, accurate financial calculations, and proper relationships with dependent tables is essential for reliable business intelligence and enterprise-scale analytical reporting.