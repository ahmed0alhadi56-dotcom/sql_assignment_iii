-- ============================================================
-- ASSIGNMENT III: SQL TABLE MANIPULATION
-- Student: Ahmed Alhadi (202513597)
-- Project: Pharmacy Management System
-- Database: ahmed_202513597_pharmacy_system
-- ============================================================

-- 1. DATABASE CREATION
CREATE DATABASE ahmed_202513597_pharmacy_system;
-- (Connect to the new database before running the rest)

-- ============================================================
-- 2. TABLE CREATION AND CONSTRAINTS
-- ============================================================
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    full_name   VARCHAR(100) NOT NULL,
    phone       VARCHAR(20)  UNIQUE,
    gender      VARCHAR(10)
);

CREATE TABLE medicines (
    medicine_id    SERIAL PRIMARY KEY,
    medicine_name  VARCHAR(100) NOT NULL,
    price          NUMERIC(10,2) NOT NULL CHECK (price > 0),
    stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    expiry_date    DATE
);

CREATE TABLE sales (
    sale_id      SERIAL PRIMARY KEY,
    customer_id  INT NOT NULL,
    medicine_id  INT NOT NULL,
    quantity     INT NOT NULL CHECK (quantity > 0),
    sale_date    DATE NOT NULL DEFAULT CURRENT_DATE,
    total_price  NUMERIC(10,2) NOT NULL,
    CONSTRAINT fk_sales_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_sales_medicine FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

-- ============================================================
-- 3. INITIAL DATA INSERTION (5 records per table)
-- ============================================================
INSERT INTO customers (full_name, phone, gender) VALUES
('Ahmed Alhadi',    '0788000001', 'Male'),
('Fatima Uwase',    '0788000002', 'Female'),
('Eric Nkurunziza', '0788000003', 'Male'),
('Alice Mukamana',  '0788000004', 'Female'),
('Yves Habimana',   '0788000005', 'Male');

INSERT INTO medicines (medicine_name, price, stock_quantity, expiry_date) VALUES
('Paracetamol 500mg', 1500.00, 200, '2027-05-31'),
('Amoxicillin 250mg', 3200.00, 150, '2027-08-15'),
('Ibuprofen 400mg',   2500.00, 180, '2027-03-20'),
('Cetirizine 10mg',   1200.00, 300, '2028-01-10'),
('Omeprazole 20mg',   4500.00, 100, '2027-11-30');

INSERT INTO sales (customer_id, medicine_id, quantity, sale_date, total_price) VALUES
(1, 1, 2, '2026-10-20', 3000.00),
(2, 3, 1, '2026-10-21', 2500.00),
(3, 2, 3, '2026-10-21', 9600.00),
(4, 5, 1, '2026-10-22', 4500.00),
(5, 4, 4, '2026-10-22', 4800.00);

-- ============================================================
-- 4. SELECT TASKS
-- ============================================================
-- Q1.1: Basic Data Retrieval
SELECT full_name, phone FROM customers;

-- Q1.2: Conditional Data Retrieval
SELECT medicine_name, price FROM medicines WHERE price > 2000;

-- Q1.3: Sorted Data Retrieval
SELECT medicine_name, price FROM medicines ORDER BY price DESC;

-- ============================================================
-- 5. JOIN TASKS
-- ============================================================
-- Q2.1: INNER JOIN
SELECT c.full_name, s.sale_id, s.total_price
FROM customers c
INNER JOIN sales s ON c.customer_id = s.customer_id;

-- Q2.2: LEFT JOIN
SELECT m.medicine_name, s.sale_id, s.quantity
FROM medicines m
LEFT JOIN sales s ON m.medicine_id = s.medicine_id;

-- Q2.3: Multi-Table JOIN
SELECT 
    c.full_name AS customer_name, 
    m.medicine_name, 
    s.quantity, 
    s.total_price
FROM sales s
JOIN customers c ON s0.customer_id = c.customer_id
JOIN medicines m ON s.medicine_id = m.medicine_id;

-- ============================================================
-- 6. UPDATE TASKS AND VERIFICATION
-- ============================================================
-- Q3.1: Update One Record
UPDATE customers SET phone = '0788999999' WHERE customer_id = 1;
SELECT * FROM customers WHERE customer_id = 1; -- Verification

-- Q3.2: Update Multiple Records
UPDATE medicines SET stock_quantity = stock_quantity + 50 WHERE price < 2000;
SELECT medicine_name, price, stock_quantity FROM medicines WHERE price < 2000; -- Verification

-- Q3.3: Conditional Update
UPDATE medicines SET price = price * 0.90 WHERE expiry_date < '2027-04-01';
SELECT medicine_name, price, expiry_date FROM medicines WHERE expiry_date < '2027-04-01'; -- Verification

-- ============================================================
-- 7. ALTER TABLE TASKS AND VERIFICATION
-- ============================================================
-- Q4.1: Rename a Column
ALTER TABLE customers RENAME COLUMN phone TO phone_number;
SELECT * FROM customers LIMIT 1; -- Verification

-- Q4.2: Change a Column's Data Type
ALTER TABLE medicines ALTER COLUMN price TYPE NUMERIC(12,2);
SELECT column_name, data_type, numeric_precision FROM information_schema.columns WHERE table_name = 'medicines' AND column_name = 'price'; -- Verification

-- Q4.3: Add a Column
ALTER TABLE medicines ADD COLUMN manufacturer VARCHAR(100);
SELECT * FROM medicines LIMIT 1; -- Verification

-- ============================================================
-- 8. ADDITIONAL INSERT TASKS AND VERIFICATION
-- ============================================================
-- Q5.1: Insert a Single Record
INSERT INTO customers (full_name, phone_number, gender) VALUES ('Khalid Mansour', '0788111222', 'Male');
SELECT * FROM customers ORDER BY customer_id DESC LIMIT 1; -- Verification

-- Q5.2: Insert Multiple Records
INSERT INTO medicines (medicine_name, price, stock_quantity, expiry_date, manufacturer) 
VALUES 
('Vitamin C 1000mg', 350.00, 80, '2028-05-20', 'HealthPlus'),
('Cough Syrup', 2800.00, 120, '2027-09-15', 'MediCare');
SELECT * FROM medicines ORDER BY medicine_id DESC LIMIT 2; -- Verification

-- Q5.3: Insert a Related Record
INSERT INTO sales (customer_id, medicine_id, quantity, sale_date, total_price) VALUES (6, 6, 1, '2026-10-24', 3500.00);
SELECT * FROM sales ORDER BY sale_id DESC LIMIT 1; -- Verification
