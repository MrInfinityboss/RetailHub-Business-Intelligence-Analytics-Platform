# Database Normalization

## Introduction

Database normalization is the process of organizing data within a relational database to minimize redundancy, eliminate data anomalies, and improve overall data integrity.

For the RetailHub Enterprise Retail Data Warehouse, normalization was applied during the database design phase to ensure that business entities such as customers, products, orders, inventory, suppliers, warehouses, and payments are stored efficiently without unnecessary duplication.

The RetailHub database has been designed following the principles of **Third Normal Form (3NF)**. This level of normalization provides an optimal balance between data consistency, maintainability, and query performance while supporting large-scale analytical workloads.

This document demonstrates how the database evolves from an unnormalized structure into a fully normalized relational model.

## Why Normalization?

RetailHub manages business operations across multiple functional areas, including product management, inventory, sales, logistics, marketing, finance, and customer relationship management.

Without normalization, business data would be duplicated across multiple records, leading to several issues:

- Data redundancy
- Update anomalies
- Insert anomalies
- Delete anomalies
- Inconsistent business information
- Increased storage requirements
- Reduced data integrity

Normalization addresses these challenges by separating business entities into independent tables connected through primary and foreign key relationships.

The primary goals of normalization in the RetailHub database are:

- Eliminate duplicate data
- Improve data consistency
- Maintain referential integrity
- Reduce storage redundancy
- Simplify database maintenance
- Support scalable business operations
- Enable efficient analytical reporting

## Unnormalized Form (UNF)

Before designing the RetailHub database, business information could be stored in a single large table containing customer details, order information, product details, supplier information, warehouse information, and payment details.

Such a design introduces multiple problems, including repeated data, update anomalies, insertion anomalies, and deletion anomalies. It also violates the principles of relational database design by storing multiple values for similar attributes in the same record.

### Example of an Unnormalized Table

| Order ID | Customer Name | Phone | Product 1 | Qty 1 | Product 2 | Qty 2 | Product 3 | Qty 3 | Supplier | Warehouse | Payment Method |
|----------|---------------|-------|-----------|------:|-----------|------:|-----------|------:|----------|-----------|----------------|
| 1001 | John Smith | 9876543210 | Laptop | 1 | Mouse | 2 | Keyboard | 1 | Dell Pvt Ltd | Delhi Warehouse | Credit Card |

### Problems with the Unnormalized Design

- Customer information is repeated for every order.
- Supplier information is duplicated for every product.
- Warehouse details are repeated across multiple records.
- Multiple product columns (`Product 1`, `Product 2`, `Product 3`) violate the principle of atomic values.
- Updating a customer's phone number requires changes in multiple rows.
- Deleting the only order for a customer could also remove important customer information.
- The design is difficult to maintain and inefficient for reporting.

These issues demonstrate the need for database normalization. The following sections illustrate how the RetailHub database is transformed into a normalized relational model by applying the principles of First, Second, and Third Normal Forms.

## First Normal Form (1NF)

The First Normal Form (1NF) requires that every column in a table contains atomic (indivisible) values and that there are no repeating groups or multi-valued attributes.

In the unnormalized RetailHub order data, multiple products were stored in separate columns such as **Product 1**, **Product 2**, and **Product 3**, resulting in repeating groups and violating the principles of 1NF.

To achieve First Normal Form, each order item is stored as a separate record. Instead of storing multiple products in a single row, every product purchased in an order is represented by its own row in the **Order_Items** table.

### Before Applying 1NF

| Order ID | Customer Name | Product 1 | Qty 1 | Product 2 | Qty 2 |
|----------|---------------|-----------|------:|-----------|------:|
| 1001 | John Smith | Laptop | 1 | Mouse | 2 |

### After Applying 1NF

#### Orders

| Order ID | Customer Name |
|----------|---------------|
| 1001 | John Smith |

#### Order_Items

| Order Item ID | Order ID | Product | Quantity |
|---------------|----------|----------|---------:|
| 1 | 1001 | Laptop | 1 |
| 2 | 1001 | Mouse | 2 |

### Improvements Achieved

- Every column stores a single atomic value.
- Repeating product columns are eliminated.
- Each row represents a single business transaction.
- Orders containing any number of products can be stored efficiently.
- The database structure becomes easier to query, maintain, and extend.

After applying First Normal Form, the RetailHub database satisfies the requirement that every table contains atomic values with no repeating groups.

## Second Normal Form (2NF)

Second Normal Form (2NF) builds upon First Normal Form by ensuring that every non-key attribute is fully dependent on the entire primary key. This eliminates partial dependencies and prevents unnecessary duplication of data.

In the RetailHub database, storing customer details, product information, supplier details, or warehouse information directly within the **Orders** or **Order_Items** tables would result in redundant data. Every time a customer places an order or purchases a product, the same information would be repeated.

To achieve Second Normal Form, these business entities are separated into their own dedicated tables and linked using primary and foreign keys.

### Before Applying 2NF

| Order ID | Customer Name | Customer Email | Product Name | Brand | Category | Quantity |
|----------|---------------|----------------|--------------|--------|----------|---------:|
| 1001 | John Smith | john@email.com | Laptop | Dell | Electronics | 1 |
| 1001 | John Smith | john@email.com | Mouse | Logitech | Accessories | 2 |

In this design:

- Customer information is repeated for every product purchased.
- Product details are duplicated across multiple orders.
- Updating customer or product information requires modifying multiple records.
- The database consumes unnecessary storage and becomes difficult to maintain.

### After Applying 2NF

Customer information is stored in the **Customers** table.

| Customer ID | Customer Name | Email |
|-------------|---------------|-------|
| 501 | John Smith | john@email.com |

Product information is stored in the **Products** table.

| Product ID | Product Name | Brand ID | Category ID |
|-----------|--------------|---------:|------------:|
| 201 | Laptop | 10 | 5 |
| 202 | Mouse | 15 | 8 |

Orders reference customers using a foreign key.

| Order ID | Customer ID |
|----------|------------:|
| 1001 | 501 |

Order items reference products using a foreign key.

| Order Item ID | Order ID | Product ID | Quantity |
|--------------|----------|-----------:|---------:|
| 1 | 1001 | 201 | 1 |
| 2 | 1001 | 202 | 2 |

### Improvements Achieved

- Customer information is stored only once.
- Product information is stored only once.
- Data redundancy is significantly reduced.
- Updates to customer or product information require changes in only one table.
- Foreign key relationships maintain data integrity.
- The database becomes easier to maintain and more scalable.

By applying Second Normal Form, RetailHub separates independent business entities into dedicated tables while maintaining relationships through primary and foreign keys.

## Third Normal Form (3NF)

Third Normal Form (3NF) extends the principles of Second Normal Form by eliminating **transitive dependencies**. A transitive dependency occurs when a non-key attribute depends on another non-key attribute instead of depending directly on the primary key.

For example, storing the **Brand Name**, **Category Name**, or **Supplier Name** directly in the **Products** table would result in duplicate information. If a brand or supplier name changes, every related product record would need to be updated, increasing the risk of inconsistent data.

To eliminate these dependencies, RetailHub stores each business entity in its own table and establishes relationships using foreign keys.

### Before Applying 3NF

| Product ID | Product Name | Brand Name | Category Name | Supplier Name |
|------------|--------------|------------|---------------|---------------|
| 201 | Laptop | Dell | Electronics | Dell Pvt Ltd |
| 202 | Mouse | Logitech | Accessories | Logitech India |

Problems with this design include:

- Brand names are repeated for every product.
- Category names are duplicated across multiple records.
- Supplier information is stored repeatedly.
- Updating a brand or supplier name requires changes in many rows.
- Increased risk of inconsistent and inaccurate data.

### After Applying 3NF

#### Products

| Product ID | Product Name | Brand ID | Category ID | Supplier ID |
|------------|--------------|---------:|------------:|------------:|
| 201 | Laptop | 10 | 5 | 101 |
| 202 | Mouse | 15 | 8 | 102 |

#### Brands

| Brand ID | Brand Name |
|----------|------------|
| 10 | Dell |
| 15 | Logitech |

#### Categories

| Category ID | Category Name |
|-------------|---------------|
| 5 | Electronics |
| 8 | Accessories |

#### Suppliers

| Supplier ID | Supplier Name |
|-------------|---------------|
| 101 | Dell Pvt Ltd |
| 102 | Logitech India |

Similarly, other business entities such as **Warehouses**, **Promotions**, **Payments**, **Shipments**, **Returns**, **Reviews**, and **Loyalty Transactions** are maintained in separate tables and connected through foreign key relationships.

### Improvements Achieved

- Eliminates transitive dependencies.
- Prevents duplication of business information.
- Ensures high data consistency across the database.
- Simplifies updates and maintenance.
- Improves referential integrity using foreign keys.
- Supports scalable database growth as new business entities are introduced.

After applying Third Normal Form, every non-key attribute in the RetailHub database depends only on the primary key, the whole primary key, and nothing but the primary key. This results in a clean, efficient, and maintainable relational database structure suitable for enterprise-scale retail operations.

## Final Normalized RetailHub Database

After applying the principles of First Normal Form (1NF), Second Normal Form (2NF), and Third Normal Form (3NF), the RetailHub database is organized into a set of well-structured relational tables. Each table represents a single business entity, while relationships between entities are maintained using primary and foreign keys.

The final database design minimizes data redundancy, maintains referential integrity, and provides a scalable foundation for enterprise retail operations.

### Master Tables

| Table | Purpose |
|--------|---------|
| Categories | Stores product category information. |
| Brands | Stores product brand information. |
| Suppliers | Stores supplier details. |
| Products | Stores product information and references categories, brands, and suppliers. |
| Warehouses | Stores warehouse locations and details. |
| Stores | Stores retail store information. |
| Employees | Stores employee records. |
| Customers | Stores customer information. |
| Promotions | Stores promotional campaign details. |

### Transaction Tables

| Table | Purpose |
|--------|---------|
| Inventory | Tracks product stock across warehouses and stores. |
| Stock_Movements | Records stock transfers, adjustments, and replenishments. |
| Orders | Stores customer order information. |
| Order_Items | Stores individual products included in each order. |
| Payments | Records payment transactions for orders. |
| Shipments | Tracks order shipment and delivery status. |
| Returns | Records returned products and refund details. |
| Coupon_Usage | Tracks coupon redemption by customers. |
| Reviews | Stores customer ratings and product reviews. |
| Loyalty_Transactions | Records loyalty points earned and redeemed by customers. |

### Database Summary

| Category | Count |
|----------|------:|
| Master Tables | 9 |
| Transaction Tables | 10 |
| Total Tables | 19 |

### Normalization Outcome

The RetailHub database successfully satisfies the requirements of Third Normal Form (3NF):

- Every table represents a single business entity.
- Each table has a clearly defined primary key.
- Relationships between tables are maintained through foreign keys.
- Non-key attributes depend only on their respective primary keys.
- Data redundancy has been minimized.
- Update, insert, and delete anomalies have been eliminated.
- The database is optimized for data consistency, scalability, and long-term maintainability.

This normalized structure serves as the foundation for the subsequent implementation stages, including schema creation, data loading, SQL querying, business intelligence reporting, and analytical dashboard development.