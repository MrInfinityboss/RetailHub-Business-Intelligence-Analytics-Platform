# Payments

## Overview

The **Payments** table is a transactional table that records payment information for customer orders within the RetailHub Enterprise Retail Data Warehouse. It captures details about payment methods, payment status, transaction amounts, and payment timestamps.

This table plays a vital role in financial reporting, revenue reconciliation, payment analysis, and customer transaction tracking. It enables RetailHub to monitor payment success rates, analyze customer payment preferences, and support financial auditing.

---

# Business Purpose

The Payments table stores payment information associated with customer orders. It provides the financial transaction layer of the retail business and supports accounting, finance, fraud monitoring, and business intelligence.

This table supports:

- Payment processing records
- Revenue reconciliation
- Financial reporting
- Payment method analysis
- Payment success monitoring
- Customer payment behavior analysis

---

# Table Details

| Property | Value |
|----------|-------|
| Table Name | payments |
| Table Type | Fact / Transactional Table |
| Storage Type | PostgreSQL |
| Estimated Records | 500,000 |
| Update Frequency | Very High |
| Primary Consumer | Finance, Sales, Accounting, BI Team |

---

# Primary Key

| Column |
|---------|
| payment_id |

---

# Foreign Keys

| Foreign Key | References |
|-------------|------------|
| order_id | Orders(order_id) |

---

# Columns

| Column | Data Type | Nullable | Description |
|---------|-----------|----------|-------------|
| payment_id | BIGINT | No | Unique identifier for each payment |
| order_id | BIGINT | No | Associated customer order |
| payment_date | TIMESTAMP | No | Date and time when payment was made |
| payment_method | VARCHAR(50) | No | Method used for payment |
| payment_status | VARCHAR(30) | No | Current payment status |
| amount_paid | NUMERIC(12,2) | No | Amount paid by the customer |
| transaction_reference | VARCHAR(100) | Yes | External payment transaction reference |

---

# Relationships

```
Orders
   │
   │ One-to-One
   ▼
Payments
```

Each completed order is associated with one payment record.

A payment cannot exist without a valid customer order.

---

# Business Rules

- Every payment must have a unique Payment ID.
- Every payment must reference an existing order.
- Each order should have only one successful payment.
- Payment amount cannot be negative.
- Payment date cannot occur before the corresponding order date.
- Cancelled orders should not have successful payment records.
- Transaction references should be unique whenever available.

---

# Data Quality Constraints

- `payment_id` must be unique.
- `order_id` must exist in the Orders table.
- `amount_paid >= 0`
- `payment_date` cannot be NULL.
- `payment_method` must contain valid business values.
- `payment_status` must contain valid business values.
- Transaction reference should be unique when present.

---

# Used In Analytics

The Payments table supports:

- Revenue Analysis
- Payment Method Analysis
- Payment Success Rate
- Failed Payment Analysis
- Financial Reconciliation
- Daily Revenue Reporting
- Monthly Revenue Trends
- Customer Payment Preferences
- Finance KPI Dashboards
- Accounting Reports

---

# Sample Business Questions

- Which payment method is used most frequently?
- What percentage of payments are successful?
- What is the daily payment collection trend?
- Which payment methods generate the highest revenue?
- What is the average payment amount?
- Which payment methods experience the highest failure rate?
- What is the monthly revenue collected?
- How many payments are pending or failed?
- Which sales channels generate the highest payment volume?
- How does payment behavior vary across customer segments?

---

# Dependencies

## Parent Tables

- Orders

## Child Tables

None

---

# Notes

The Payments table represents the financial component of RetailHub's transaction lifecycle. It provides a reliable record of customer payments and supports financial auditing, revenue reporting, and business intelligence.

Because every completed order generates a payment record, this table is one of the primary sources for financial analytics and executive reporting. Maintaining accurate payment information ensures reliable revenue calculations, supports reconciliation processes, and enables comprehensive analysis of customer payment behavior and payment system performance.