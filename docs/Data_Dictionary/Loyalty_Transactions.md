# Loyalty Transactions

## Overview

The **Loyalty_Transactions** table is a transactional table that records all loyalty point activities for RetailHub customers. It tracks points earned from purchases, points redeemed for rewards, bonus points awarded through promotional campaigns, and point adjustments made by customer support.

This table serves as the foundation of RetailHub's customer loyalty program, enabling the business to measure customer engagement, retention, repeat purchases, and Customer Lifetime Value (CLV). It provides valuable insights into customer behavior and the effectiveness of loyalty initiatives.

---

# Business Purpose

The Loyalty_Transactions table maintains a complete history of customer loyalty point transactions. It supports customer retention strategies, reward program management, marketing campaigns, and advanced customer analytics.

This table supports:

- Loyalty program management
- Customer retention analysis
- Customer Lifetime Value (CLV) analysis
- Reward redemption tracking
- Customer engagement analysis
- Marketing campaign evaluation

---

# Table Details

| Property | Value |
|----------|-------|
| Table Name | loyalty_transactions |
| Table Type | Fact / Transactional Table |
| Storage Type | PostgreSQL |
| Estimated Records | 1,250,000 |
| Update Frequency | High |
| Primary Consumer | Marketing, CRM, Customer Experience, BI Team |

---

# Primary Key

| Column |
|---------|
| loyalty_transaction_id |

---

# Foreign Keys

| Foreign Key | References |
|-------------|------------|
| customer_id | Customers(customer_id) |
| order_id | Orders(order_id) |

---

# Columns

| Column | Data Type | Nullable | Description |
|---------|-----------|----------|-------------|
| loyalty_transaction_id | BIGINT | No | Unique identifier for each loyalty transaction |
| customer_id | BIGINT | No | Customer associated with the transaction |
| order_id | BIGINT | Yes | Order linked to the loyalty transaction, if applicable |
| transaction_date | TIMESTAMP | No | Date and time of the loyalty transaction |
| transaction_type | VARCHAR(30) | No | Type of loyalty transaction |
| points | INTEGER | No | Number of loyalty points earned or redeemed |
| points_balance | INTEGER | No | Customer's loyalty points balance after the transaction |
| remarks | VARCHAR(255) | Yes | Additional notes or description of the transaction |

---

# Relationships

```
Customers
     │
     │
     ▼
Loyalty Transactions
     ▲
     │
   Orders
```

Each loyalty transaction belongs to one customer.

Some transactions are linked to customer orders (points earned or redeemed during purchases), while others may represent promotional bonuses or manual adjustments.

A customer can have many loyalty transactions over time.

---

# Business Rules

- Every loyalty transaction must have a unique Loyalty Transaction ID.
- Every transaction must reference an existing customer.
- Order ID is optional because promotional bonuses and manual adjustments may not relate to a purchase.
- Transaction type must be a valid business value.
- Points earned must be positive.
- Redeemed points reduce the customer's available balance.
- Customer point balance cannot become negative.
- Loyalty points should expire according to company policy (handled outside this table).

---

# Data Quality Constraints

- `loyalty_transaction_id` must be unique.
- `customer_id` must exist in the Customers table.
- `order_id`, when present, must exist in the Orders table.
- `transaction_date` cannot be NULL.
- `points_balance >= 0`
- `transaction_type` must contain valid business values:
  - Earned
  - Redeemed
  - Bonus
  - Expired
  - Adjustment
- Points should follow business rules depending on transaction type:
  - Earned and Bonus → Positive values
  - Redeemed and Expired → Negative values
  - Adjustment → Positive or Negative

---

# Used In Analytics

The Loyalty_Transactions table supports:

- Customer Lifetime Value (CLV) Analysis
- Customer Retention Analysis
- Loyalty Program Performance
- Repeat Purchase Analysis
- Customer Segmentation
- RFM (Recency, Frequency, Monetary) Analysis
- Reward Redemption Analysis
- Customer Engagement Reporting
- Marketing Campaign Effectiveness
- Executive CRM Dashboards

---

# Sample Business Questions

- Which customers earn the most loyalty points?
- Which customers redeem rewards most frequently?
- What percentage of customers actively participate in the loyalty program?
- How does loyalty membership influence repeat purchases?
- Which marketing campaigns generate the most bonus point activity?
- What is the average loyalty point balance across customers?
- Which customer segments have the highest Customer Lifetime Value (CLV)?
- How many points are redeemed versus earned each month?
- What is the retention rate of loyalty program members?
- Does loyalty participation increase average order value?

---

# Dependencies

## Parent Tables

- Customers
- Orders

## Child Tables

None

---

# Notes

The Loyalty_Transactions table represents the final stage of RetailHub's customer engagement ecosystem. It captures every loyalty point movement throughout the customer lifecycle, enabling comprehensive analysis of retention, engagement, and long-term customer value.

When combined with Orders, Payments, Coupon_Usage, Reviews, and Returns, this table provides a 360-degree view of customer behavior. It is essential for Customer Lifetime Value (CLV) calculations, RFM segmentation, retention analytics, personalized marketing strategies, and executive CRM reporting, making it one of the most valuable analytical assets in the Enterprise Retail Data Warehouse.