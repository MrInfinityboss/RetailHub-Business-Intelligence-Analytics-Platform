# Reviews

## Overview

The **Reviews** table is a transactional table that stores customer feedback and ratings for products purchased through RetailHub. It captures customer opinions, product ratings, review comments, and review submission dates, enabling the business to measure customer satisfaction and product quality.

This table serves as an important source of customer-generated data that helps RetailHub understand customer preferences, improve product quality, identify high-performing products, and make informed merchandising decisions.

---

# Business Purpose

The Reviews table records customer feedback for purchased products. It enables RetailHub to evaluate customer satisfaction, analyze product performance, monitor brand reputation, and support quality improvement initiatives.

This table supports:

- Customer feedback management
- Product quality analysis
- Customer satisfaction measurement
- Product rating analysis
- Brand reputation monitoring
- Marketing and merchandising decisions

---

# Table Details

| Property | Value |
|----------|-------|
| Table Name | reviews |
| Table Type | Fact / Transactional Table |
| Storage Type | PostgreSQL |
| Estimated Records | 264,510 |
| Update Frequency | High |
| Primary Consumer | Marketing, Product Team, Customer Experience, BI Team |

---

# Primary Key

| Column |
|---------|
| review_id |

---

# Foreign Keys

| Foreign Key | References |
|-------------|------------|
| customer_id | Customers(customer_id) |
| product_id | Products(product_id) |

---

# Columns

| Column | Data Type | Nullable | Description |
|---------|-----------|----------|-------------|
| review_id | BIGINT | No | Unique identifier for each review |
| customer_id | BIGINT | No | Customer who submitted the review |
| product_id | BIGINT | No | Product being reviewed |
| rating | NUMERIC(2,1) | No | Product rating on a scale of 1 to 5 |
| review_title | VARCHAR(200) | Yes | Short title summarizing the review |
| review_text | TEXT | Yes | Detailed customer feedback |
| review_date | TIMESTAMP | No | Date and time when the review was submitted |

---

# Relationships

```
Customers
     │
     ▼
  Reviews
     ▲
     │
 Products
```

Each review is submitted by one customer for one product.

A customer can review multiple products, and a product can receive reviews from multiple customers.

---

# Business Rules

- Every review must have a unique Review ID.
- Every review must reference one valid customer.
- Every review must reference one valid product.
- Customers should only review products they have purchased.
- Rating must be between 1 and 5.
- A customer should submit only one review per product.
- Reviews cannot be submitted before the purchase date.
- Review content must not be modified after publication except for moderation purposes.

---

# Data Quality Constraints

- `review_id` must be unique.
- `customer_id` must exist in the Customers table.
- `product_id` must exist in the Products table.
- `rating BETWEEN 1 AND 5`
- `review_date` cannot be NULL.
- `(customer_id, product_id)` should be unique to prevent duplicate reviews.

---

# Used In Analytics

The Reviews table supports:

- Customer Satisfaction Analysis
- Product Rating Analysis
- Product Quality Assessment
- Brand Reputation Analysis
- Category-wise Rating Analysis
- Customer Feedback Trends
- Product Recommendation Analysis
- Product Improvement Insights
- Marketing Dashboard Reporting
- Customer Experience Analytics

---

# Sample Business Questions

- Which products have the highest average rating?
- Which products receive the most customer reviews?
- Which brands consistently receive the best ratings?
- Which product categories have the lowest customer satisfaction?
- How has customer satisfaction changed over time?
- Which products have a high sales volume but poor ratings?
- Which customers actively provide product feedback?
- Which products require quality improvements?
- What is the average product rating by category?
- How do customer ratings influence product sales?

---

# Dependencies

## Parent Tables

- Customers
- Products

## Child Tables

None

---

# Notes

The Reviews table captures valuable customer-generated feedback that complements transactional sales data. It provides qualitative and quantitative insights into product performance and customer satisfaction, helping RetailHub continuously improve its product offerings and customer experience.

By combining review data with sales, returns, and inventory information, RetailHub can identify quality issues, measure customer sentiment, prioritize product improvements, and strengthen brand loyalty through data-driven decision-making.