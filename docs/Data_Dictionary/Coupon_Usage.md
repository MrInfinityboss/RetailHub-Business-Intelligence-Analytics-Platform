# Coupon Usage

## Overview

The **Coupon_Usage** table is a transactional table that records every instance of a promotional coupon being redeemed by a customer during an order. It serves as the bridge between customers, orders, and marketing campaigns, allowing RetailHub to measure the effectiveness of promotional strategies.

This table enables the organization to analyze coupon redemption patterns, campaign performance, customer engagement, and the financial impact of discounts on sales and profitability.

---

# Business Purpose

The Coupon_Usage table captures all coupon redemption transactions made by customers. It provides valuable insights into marketing campaign performance and customer purchasing behavior while supporting financial reporting and promotional analysis.

This table supports:

- Coupon redemption tracking
- Promotion effectiveness analysis
- Customer engagement analysis
- Discount analysis
- Marketing ROI measurement
- Campaign performance reporting

---

# Table Details

| Property | Value |
|----------|-------|
| Table Name | coupon_usage |
| Table Type | Fact / Transactional Table |
| Storage Type | PostgreSQL |
| Estimated Records | 110,109 |
| Update Frequency | High |
| Primary Consumer | Marketing, Sales, Finance, BI Team |

---

# Primary Key

| Column |
|---------|
| coupon_usage_id |

---

# Foreign Keys

| Foreign Key | References |
|-------------|------------|
| promotion_id | Promotions(promotion_id) |
| customer_id | Customers(customer_id) |
| order_id | Orders(order_id) |

---

# Columns

| Column | Data Type | Nullable | Description |
|---------|-----------|----------|-------------|
| coupon_usage_id | BIGINT | No | Unique identifier for each coupon redemption |
| promotion_id | BIGINT | No | Promotion associated with the coupon |
| customer_id | BIGINT | No | Customer who redeemed the coupon |
| order_id | BIGINT | No | Order where the coupon was applied |
| coupon_code | VARCHAR(50) | No | Promotional coupon code |
| discount_amount | NUMERIC(10,2) | No | Discount applied to the order |
| redemption_date | TIMESTAMP | No | Date and time when the coupon was redeemed |

---

# Relationships

```
             Promotions
                  │
                  │
Customers ─── Coupon Usage ─── Orders
```

Each coupon redemption is linked to one promotion, one customer, and one order.

A promotion can be redeemed multiple times by different customers.

A customer can redeem multiple coupons over time.

---

# Business Rules

- Every coupon redemption must have a unique Coupon Usage ID.
- Every redemption must reference one valid promotion.
- Every redemption must reference one customer.
- Every redemption must reference one order.
- Discount amount cannot be negative.
- Redemption date cannot occur before the promotion start date.
- Coupon codes should be valid and active at the time of redemption.
- A coupon should not be redeemed multiple times for the same order unless business rules explicitly allow it.

---

# Data Quality Constraints

- `coupon_usage_id` must be unique.
- `promotion_id` must exist in the Promotions table.
- `customer_id` must exist in the Customers table.
- `order_id` must exist in the Orders table.
- `discount_amount >= 0`
- `redemption_date` cannot be NULL.
- `coupon_code` cannot be NULL.

---

# Used In Analytics

The Coupon_Usage table supports:

- Coupon Redemption Analysis
- Promotion Effectiveness Analysis
- Campaign ROI Analysis
- Customer Discount Behavior
- Revenue Impact Analysis
- Customer Acquisition Analysis
- Customer Retention Campaign Analysis
- Marketing Performance Dashboards

---

# Sample Business Questions

- Which promotional campaign has the highest redemption rate?
- Which coupon generates the highest revenue?
- Which customers use coupons most frequently?
- How much revenue was influenced by promotional discounts?
- What is the average discount per redeemed coupon?
- Which campaigns attract new customers?
- Which promotions generate the highest repeat purchases?
- What percentage of orders include promotional coupons?
- Which coupon codes are most effective during seasonal sales?
- How do coupon users differ from non-coupon customers?

---

# Dependencies

## Parent Tables

- Promotions
- Customers
- Orders

## Child Tables

None

---

# Notes

The Coupon_Usage table connects RetailHub's marketing initiatives with actual customer purchasing behavior. It provides measurable evidence of campaign success by linking promotions directly to customer orders and financial outcomes.

By combining data from Customers, Orders, and Promotions, this table enables comprehensive marketing analytics, helping RetailHub optimize promotional strategies, improve customer engagement, and maximize return on marketing investment.