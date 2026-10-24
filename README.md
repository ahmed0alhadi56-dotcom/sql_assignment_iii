# Pharmacy Management System Database

## Project Overview
- *Student Name:* Ahmed Alhadi
- *Student ID:* 202513597
- *Business Idea:* Pharmacy Management System
- *DBMS:* PostgreSQL (pgAdmin 4)

## Database Design
The database name is ahmed_202513597_pharmacy_system. 
It consists of three related tables:
1. *customers*: Stores customer information (Primary Key: customer_id).
2. *medicines*: Stores medicine details and stock (Primary Key: medicine_id).
3. *sales*: Records purchases made by customers (Primary Key: sale_id).

### Relationships & Foreign Keys
- The sales table has two Foreign Keys:
  - customer_id references customers(customer_id).
  - medicine_id references medicines(medicine_id).
This ensures data integrity and prevents orphan records.

## Entity-Relationship Diagram (ERD)
![ERD](erd.png)

## SQL Tasks Execution & Results
(Note: All 15 SQL tasks were executed successfully. The full code is in assignment_iii.sql. Screenshots of the results are included in the digital report.)

### SELECT Tasks
- Q1.1: Retrieved specific columns from customers.
- Q1.2: Retrieved medicines with a price greater than 2000.
- Q1.3: Sorted medicines by price in descending order.

### JOIN Tasks
- Q2.1: INNER JOIN between customers and sales.
- Q2.2: LEFT JOIN between medicines and sales to find unsold medicines.
- Q2.3: Multi-table JOIN to generate a complete sales report.

### UPDATE Tasks
- Q3.1: Updated a single customer's phone number.
- Q3.2: Increased stock for medicines priced below 2000.
- Q3.3: Applied a 10% discount to medicines expiring before a specific date.

### ALTER TABLE Tasks
- Q4.1: Renamed phone column to phone_number.
- Q4.2: Changed price data type to NUMERIC(12,2).
- Q4.3: Added a manufacturer column to the medicines table.

### INSERT Tasks
- Q5.1: Inserted a single new customer.
- Q5.2: Inserted multiple new medicines.
- Q5.3: Inserted a new sale record referencing existing parent records.

## Conclusion
Through this assignment, I learned how to create a relational database, define primary and foreign keys, insert and retrieve data, combine related records using JOINs, safely update existing data, and modify table structures using ALTER TABLE.