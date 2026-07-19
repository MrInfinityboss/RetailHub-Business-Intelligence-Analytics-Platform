# Returns

## Overview

The **Returns** table is a transactional table that records products returned by customers after purchase. It captures return requests, return reasons, refund amounts, and return processing details, providing complete visibility into RetailHub's reverse logistics operations.

This table plays a critical role in customer satisfaction, quality assurance, inventory management, and financial reporting. It enables RetailHub to analyze return patterns, identify problematic products, monitor refund processing, and improve operational efficiency.

---

# Business Purpose

The Returns table stores detailed information about returned products and refund transactions. It supports reverse logistics management, customer service operations, product quality monitoring, and financial reconciliation.

This table supports:

- Return management
- Refund tracking
- Reverse logistics
- Product quality analysis
- Customer satisfaction analysis
- Financial reporting

---

# Table Details

| Property | Value |
|----------|-------|
| Table Name | returns |
| Table Type | Fact / Transactional Table |
| Storage Type | PostgreSQL |
| Estimated Records | 91,088 |
| Update Frequency | High |
| Primary Consumer | Customer Service, Finance, Inventory, BI Team |

---

# Primary Key

| Column |
|---------|
| return_id |

---

# Foreign Keys

| Foreign Key | References |
|-------------|------------|
| order_item_id | Order_Items(order_item_id) |

---

# Columns

| Column | Data Type | Nullable | Description |
|---------|-----------|----------|-------------|
| return_id | BIGINT | No | Unique identifier for each return |
| order_item_id | BIGINT | No | Order item being returned |
| return_date | TIMESTAMP | No | Date and time when the return was initiated |
| return_reason | VARCHAR(100) | No | Reason provided for the return |
| refund_amount | NUMERIC(10,2) | No | Amount refunded to the customer |
| return_status | VARCHAR(30) | No | Current processing status of the return |

---

# Relationships

```
Orders
   │
   ▼
Order Items
     │
     ▼
  Returns
```

Each return is associated with one order item.

An order item may have zero or one return record depending on whether the product was returned.

---

# Business Rules

- Every return must have a unique Return ID.
- Every return must reference an existing order item.
- Only delivered products are eligible for return.
- Refund amount cannot exceed the value of the purchased product.
- Every return must have a valid return reason.
- A returned item cannot be returned multiple times.
- Return date cannot be earlier than the product delivery date.

---

# Data Quality Constraints

- `return_id` must be unique.
- `order_item_id` must exist in the Order_Items table.
- `refund_amount >= 0`
- `refund_amount <= line_total`
- `return_date` cannot be NULL.
- `return_reason` cannot be NULL.
- `return_status` must contain valid business values:
  - Requested
  - Approved
  - Rejected
  - Refunded
  - Completed

---

# Used In Analytics

The Returns table supports:

- Return Rate Analysis
- Refund Analysis
- Product Quality Analysis
- Return Reason Analysis
- Category-wise Return Analysis
- Brand-wise Return Analysis
- Customer Return Behavior
- Financial Loss Analysis
- Reverse Logistics Performance
- Customer Satisfaction Reporting

---

# Sample Business Questions

- Which products have the highest return rate?
- What are the most common reasons for product returns?
- Which product categories experience the highest returns?
- Which brands generate the highest refund amounts?
- What percentage of total sales are returned?
- Which customers return products most frequently?
- How much revenue is lost due to returns?
- Which products should be investigated for quality issues?
- What is the monthly return trend?
- Which return reasons occur most frequently?

---

# Dependencies

## Parent Tables

- Order_Items

## Child Tables

None

---

# Notes

The Returns table completes the customer order lifecycle by recording reverse logistics activities after product delivery. It provides valuable insights into product quality, customer satisfaction, and operational performance.

Maintaining accurate return records enables RetailHub to reduce financial losses, improve product quality, optimize return policies, and enhance the overall customer experience. This table is also essential for refund reconciliation, inventory adjustments, and executive reporting on return performance.