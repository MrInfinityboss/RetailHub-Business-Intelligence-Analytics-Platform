# Customers

## Overview

The **Customers** table is one of the core master tables in the RetailHub Enterprise Retail Data Warehouse. It stores demographic, contact, geographic, and membership information for every customer registered with RetailHub.

This table serves as the foundation for customer-centric analytics and is linked to multiple transactional tables such as Orders, Reviews, Coupon Usage, and Loyalty Transactions. It enables the business to understand customer behavior, measure engagement, analyze purchasing patterns, and build long-term customer relationships.

---

# Business Purpose

The Customers table acts as the single source of truth for customer information across RetailHub. It supports customer management, sales analysis, marketing campaigns, loyalty programs, and business intelligence initiatives.

This table enables the organization to:

- Maintain customer profiles
- Track customer purchases
- Support loyalty programs
- Analyze customer behavior
- Measure customer retention
- Perform customer segmentation
- Calculate Customer Lifetime Value (CLV)

---

# Table Details

| Property | Value |
|----------|-------|
| Table Name | customers |
| Table Type | Master / Dimension Table |
| Storage Type | PostgreSQL |
| Estimated Records | 100,000 |
| Update Frequency | High |
| Primary Consumer | Sales, Marketing, Customer Service, BI Team |

---

# Primary Key

| Column |
|---------|
| customer_id |

---

# Foreign Keys

This table does not contain foreign keys.

It is referenced by:

- Orders
- Reviews
- Coupon Usage
- Loyalty Transactions

---

# Columns

| Column | Data Type | Nullable | Description |
|---------|-----------|----------|-------------|
| customer_id | BIGINT | No | Unique identifier for each customer |
| first_name | VARCHAR(100) | No | Customer first name |
| last_name | VARCHAR(100) | No | Customer last name |
| gender | VARCHAR(20) | Yes | Customer gender |
| date_of_birth | DATE | Yes | Customer date of birth |
| email | VARCHAR(150) | No | Customer email address |
| phone | VARCHAR(20) | Yes | Customer contact number |
| city | VARCHAR(100) | No | City of residence |
| state | VARCHAR(100) | No | State of residence |
| country | VARCHAR(100) | No | Country of residence |
| registration_date | DATE | No | Date customer registered with RetailHub |
| membership_level | VARCHAR(20) | No | Loyalty membership tier |

---

# Relationships

```
                     Customers
        ┌─────────────┼─────────────┐
        │             │             │
        ▼             ▼             ▼
     Orders       Reviews    Coupon Usage
        │
        ▼
Loyalty Transactions
```

A customer can place multiple orders, write multiple product reviews, redeem multiple coupons, and earn or redeem loyalty points through multiple loyalty transactions.

---

# Business Rules

- Every customer must have a unique Customer ID.
- Email addresses should be unique.
- Customers must register before placing an order.
- One customer can place multiple orders.
- One customer can submit multiple product reviews.
- Customers can redeem multiple promotional coupons.
- Membership level determines loyalty program benefits.
- Customer records should never be deleted to preserve historical transactions.

---

# Data Quality Constraints

- `customer_id` must be unique.
- `email` should be unique.
- `registration_date` cannot be NULL.
- `registration_date` cannot be greater than the current date.
- `membership_level` must contain one of the following values:
  - Bronze
  - Silver
  - Gold
  - Platinum
- City, state, and country should follow standardized naming conventions.

---

# Used In Analytics

The Customers table supports:

- Customer Segmentation
- Customer Lifetime Value (CLV)
- RFM Analysis
- Customer Retention Analysis
- Customer Churn Analysis
- Repeat Purchase Analysis
- Geographic Customer Distribution
- Customer Acquisition Analysis
- Loyalty Program Analysis
- Marketing Campaign Effectiveness

---

# Sample Business Questions

- Who are the top 100 customers by revenue?
- Which membership tier generates the highest revenue?
- Which cities have the highest number of customers?
- What is the average customer lifetime value?
- Which customers have not made a purchase in the last six months?
- What percentage of customers are repeat buyers?
- Which age group contributes the highest sales?
- Which membership level has the highest retention rate?
- Which customers frequently use promotional coupons?
- How effective is the loyalty program in increasing repeat purchases?

---

# Dependencies

## Parent Tables

None

## Child Tables

- Orders
- Reviews
- Coupon Usage
- Loyalty Transactions

---

# Notes

The Customers table is one of the most valuable business entities within the RetailHub Enterprise Retail Data Warehouse. It enables customer-centric decision-making by providing a complete view of customer demographics, purchasing behavior, and engagement with loyalty and promotional programs.

Maintaining accurate customer information is essential for personalized marketing, customer retention strategies, revenue optimization, and advanced analytics. This table serves as the foundation for several business intelligence models, including Customer Lifetime Value (CLV), RFM segmentation, churn prediction, and loyalty analysis.