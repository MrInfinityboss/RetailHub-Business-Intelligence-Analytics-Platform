# Shipments

## Overview

The **Shipments** table is a transactional table that records shipment and delivery information for customer orders within the RetailHub Enterprise Retail Data Warehouse. It tracks the movement of orders from warehouses to customers and provides complete visibility into the order fulfillment process.

This table enables RetailHub to monitor delivery performance, evaluate logistics efficiency, analyze shipping costs, and improve customer satisfaction. It forms the foundation for logistics reporting and supply chain performance analysis.

---

# Business Purpose

The Shipments table stores shipment-related information for customer orders. It supports order fulfillment, delivery tracking, logistics management, and operational reporting.

This table supports:

- Order fulfillment tracking
- Delivery performance monitoring
- Shipping cost analysis
- Logistics reporting
- Carrier performance evaluation
- Customer service operations

---

# Table Details

| Property | Value |
|----------|-------|
| Table Name | shipments |
| Table Type | Fact / Transactional Table |
| Storage Type | PostgreSQL |
| Estimated Records | 500,000 |
| Update Frequency | High |
| Primary Consumer | Logistics, Operations, Customer Service, BI Team |

---

# Primary Key

| Column |
|---------|
| shipment_id |

---

# Foreign Keys

| Foreign Key | References |
|-------------|------------|
| order_id | Orders(order_id) |
| warehouse_id | Warehouses(warehouse_id) |

---

# Columns

| Column | Data Type | Nullable | Description |
|---------|-----------|----------|-------------|
| shipment_id | BIGINT | No | Unique identifier for each shipment |
| order_id | BIGINT | No | Associated customer order |
| warehouse_id | BIGINT | No | Warehouse fulfilling the order |
| shipment_date | TIMESTAMP | No | Date and time when the shipment was dispatched |
| delivery_date | TIMESTAMP | Yes | Date and time when the shipment was delivered |
| carrier | VARCHAR(100) | No | Shipping carrier responsible for delivery |
| tracking_number | VARCHAR(100) | Yes | Shipment tracking number |
| shipment_status | VARCHAR(30) | No | Current shipment status |
| shipping_cost | NUMERIC(10,2) | No | Cost incurred for shipping |

---

# Relationships

```
              Orders
                 │
                 ▼
            Shipments
                 ▲
                 │
            Warehouses
```

Each shipment belongs to one customer order and is dispatched from one warehouse.

A warehouse can process multiple shipments, while each order has one shipment record.

---

# Business Rules

- Every shipment must have a unique Shipment ID.
- Every shipment must reference one customer order.
- Every shipment must originate from one warehouse.
- Shipment date cannot be earlier than the corresponding order date.
- Delivery date cannot be earlier than the shipment date.
- Shipping cost cannot be negative.
- Cancelled orders should not generate shipment records.
- Every delivered shipment must have a delivery date.

---

# Data Quality Constraints

- `shipment_id` must be unique.
- `order_id` must exist in the Orders table.
- `warehouse_id` must exist in the Warehouses table.
- `shipment_date` cannot be NULL.
- `shipping_cost >= 0`
- `delivery_date >= shipment_date`
- `shipment_status` must contain valid business values:
  - Pending
  - Packed
  - Shipped
  - In Transit
  - Delivered
  - Failed Delivery
  - Returned
- Tracking number should be unique when available.

---

# Used In Analytics

The Shipments table supports:

- Delivery Performance Analysis
- Average Delivery Time
- On-Time Delivery Rate
- Warehouse Fulfillment Performance
- Carrier Performance Analysis
- Shipping Cost Analysis
- Regional Delivery Analysis
- Order Fulfillment Analysis
- Logistics KPI Dashboards
- Supply Chain Performance Monitoring

---

# Sample Business Questions

- What is the average delivery time?
- Which warehouse fulfills orders the fastest?
- Which shipping carrier has the highest on-time delivery rate?
- Which regions experience the longest delivery times?
- What percentage of shipments are delivered on time?
- Which carrier incurs the highest shipping cost?
- How does shipping performance vary by sales channel?
- Which warehouses handle the largest shipment volume?
- What is the monthly shipment trend?
- Which shipments experienced delivery failures?

---

# Dependencies

## Parent Tables

- Orders
- Warehouses

## Child Tables

None

---

# Notes

The Shipments table provides complete visibility into RetailHub's logistics and order fulfillment process. It connects customer orders with warehouse operations and enables detailed monitoring of shipment activities from dispatch to final delivery.

Accurate shipment data is essential for improving delivery efficiency, reducing logistics costs, enhancing customer satisfaction, and supporting enterprise-wide supply chain analytics. This table is a key source for operational dashboards and executive logistics reporting.