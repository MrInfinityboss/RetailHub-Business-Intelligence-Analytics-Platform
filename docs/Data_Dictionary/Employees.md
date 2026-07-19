# Employees

## Overview

The **Employees** table is a master reference table that stores information about all employees working across RetailHub's physical stores. It maintains employee details required for workforce management, operational reporting, store administration, and performance analysis.

This table links employees to their respective stores, enabling management to monitor staffing levels, analyze workforce distribution, and evaluate store operations. Although employees are not directly involved in customer transactions within this project, they play an important role in supporting store-level analytics and business operations.

---

# Business Purpose

The Employees table provides a centralized repository for employee information across RetailHub's retail network. It supports workforce planning, operational management, and business reporting while maintaining a standardized employee database.

This table supports:

- Employee management
- Store staffing analysis
- Workforce distribution
- Operational reporting
- Human resource analytics
- Store performance evaluation

---

# Table Details

| Property | Value |
|----------|-------|
| Table Name | employees |
| Table Type | Master / Dimension Table |
| Storage Type | PostgreSQL |
| Estimated Records | 2,000 |
| Update Frequency | Medium |
| Primary Consumer | HR, Operations, Store Management, BI Team |

---

# Primary Key

| Column |
|---------|
| employee_id |

---

# Foreign Keys

| Foreign Key | References |
|-------------|------------|
| store_id | Stores(store_id) |

---

# Columns

| Column | Data Type | Nullable | Description |
|---------|-----------|----------|-------------|
| employee_id | BIGINT | No | Unique identifier for each employee |
| first_name | VARCHAR(100) | No | Employee first name |
| last_name | VARCHAR(100) | No | Employee last name |
| gender | VARCHAR(20) | Yes | Employee gender |
| email | VARCHAR(150) | No | Official email address |
| phone | VARCHAR(20) | Yes | Contact number |
| job_title | VARCHAR(100) | No | Employee designation |
| hire_date | DATE | No | Date of joining |
| salary | NUMERIC(10,2) | No | Monthly salary |
| store_id | BIGINT | No | Assigned store |

---

# Relationships

```
            Stores
               │
               │ One-to-Many
               ▼
          Employees
```

A single store can have multiple employees, while every employee is assigned to one store.

---

# Business Rules

- Every employee must have a unique Employee ID.
- Every employee must belong to one store.
- Employees cannot be assigned to multiple stores simultaneously.
- Hire date cannot be in the future.
- Salary must be greater than zero.
- Every employee must have a valid job title.
- Employee records should remain in the database even after resignation to preserve historical reporting.

---

# Data Quality Constraints

- `employee_id` must be unique.
- `store_id` must exist in the Stores table.
- `email` should be unique.
- `salary` must be greater than zero.
- `hire_date` must be less than or equal to the current date.
- `job_title` cannot be NULL.

---

# Used In Analytics

The Employees table supports:

- Workforce Distribution Analysis
- Store Staffing Analysis
- Employee Count by Store
- Salary Distribution Analysis
- Regional Workforce Analysis
- Store Resource Planning
- Employee Hiring Trends
- Operational Performance Reporting

---

# Sample Business Questions

- Which store employs the highest number of employees?
- What is the average salary by job title?
- Which regions have the largest workforce?
- How many employees joined each year?
- Which stores may require additional staffing?
- What is the distribution of employees across different job roles?
- How does workforce size compare with store performance?

---

# Dependencies

## Parent Tables

- Stores

## Child Tables

None

---

# Notes

The Employees table provides the foundation for workforce management and operational reporting within the RetailHub Enterprise Retail Data Warehouse. While employees are not directly linked to customer transactions in the current implementation, this table enables valuable workforce analytics and supports store-level operational insights.

Maintaining accurate employee information helps RetailHub optimize staffing, monitor workforce distribution, and support strategic planning for future business growth.