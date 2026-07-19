# Promotions

## Overview

The **Promotions** table is a master reference table that stores information about marketing campaigns and promotional offers launched by RetailHub. These promotions are designed to increase customer engagement, drive sales, improve customer retention, and boost product visibility.

Each promotion has a defined validity period, discount strategy, and campaign objective. The table serves as the foundation for measuring campaign performance and marketing effectiveness across different sales channels.

---

# Business Purpose

The Promotions table centralizes information about all promotional campaigns executed by RetailHub. It enables marketing teams to plan, monitor, and evaluate promotional activities while supporting analytical reporting on campaign performance.

This table supports:

- Marketing campaign management
- Discount strategy analysis
- Promotional performance reporting
- Customer engagement analysis
- Revenue uplift measurement
- Campaign ROI evaluation

---

# Table Details

| Property | Value |
|----------|-------|
| Table Name | promotions |
| Table Type | Master / Dimension Table |
| Storage Type | PostgreSQL |
| Estimated Records | 100 |
| Update Frequency | Low |
| Primary Consumer | Marketing, Sales, BI Team |

---

# Primary Key

| Column |
|---------|
| promotion_id |

---

# Foreign Keys

This table does not contain foreign keys.

It is referenced by:

- Coupon_Usage

---

# Columns

| Column | Data Type | Nullable | Description |
|---------|-----------|----------|-------------|
| promotion_id | BIGINT | No | Unique identifier for each promotion |
| promotion_name | VARCHAR(150) | No | Name of the promotional campaign |
| promotion_type | VARCHAR(50) | No | Type of promotion |
| discount_percentage | NUMERIC(5,2) | Yes | Percentage discount offered |
| start_date | DATE | No | Campaign start date |
| end_date | DATE | No | Campaign end date |
| minimum_order_amount | NUMERIC(10,2) | Yes | Minimum purchase required to qualify |
| status | VARCHAR(20) | No | Current promotion status |

---

# Relationships

```
Promotions
      │
      │ One-to-Many
      ▼
Coupon Usage
```

A single promotion can be used by multiple customers through coupon redemption.

---

# Business Rules

- Every promotion must have a unique Promotion ID.
- Promotion names should be unique.
- Start date must be earlier than or equal to the end date.
- Discount percentage cannot exceed 100%.
- Promotions can be Active, Scheduled, Expired, or Cancelled.
- A promotion may exist even if it has never been redeemed.
- Promotions cannot overlap if they use the same exclusive coupon code.

---

# Data Quality Constraints

- `promotion_id` must be unique.
- `promotion_name` cannot be NULL.
- `start_date <= end_date`
- `discount_percentage BETWEEN 0 AND 100`
- `minimum_order_amount >= 0`
- `status` must contain valid business values:
  - Scheduled
  - Active
  - Expired
  - Cancelled

---

# Used In Analytics

The Promotions table supports:

- Campaign Performance Analysis
- Promotion ROI Analysis
- Discount Effectiveness
- Revenue Lift Analysis
- Seasonal Promotion Analysis
- Customer Engagement Analysis
- Marketing Dashboard Reporting
- Promotion Success Rate

---

# Sample Business Questions

- Which promotion generated the highest revenue?
- Which campaigns had the highest redemption rate?
- Which promotion produced the highest ROI?
- Which promotions attracted the most new customers?
- Which campaigns were most successful during holidays?
- What is the average discount offered across campaigns?
- Which promotion resulted in the highest average order value?
- Which campaigns should be repeated in future seasons?

---

# Dependencies

## Parent Tables

None

## Child Tables

- Coupon_Usage

---

# Notes

The Promotions table serves as the central repository for RetailHub's marketing campaigns. It enables marketing teams to monitor campaign performance, evaluate promotional effectiveness, and optimize future marketing strategies.

Accurate promotion data allows RetailHub to measure campaign ROI, understand customer purchasing behavior, improve promotional planning, and maximize revenue through data-driven marketing decisions.