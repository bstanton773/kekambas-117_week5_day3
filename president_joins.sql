-- DDL STATEMENTS TO SET UP DATABASE

-- Create a customer table

CREATE TABLE IF NOT EXISTS customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(50),
	address VARCHAR(50),
	city VARCHAR(50),
	state VARCHAR(50)
);


SELECT *
FROM customer;


-- Create Customer Order Table
CREATE TABLE IF NOT EXISTS receipt(
	receipt_id SERIAL PRIMARY KEY,
	receipt_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	amount NUMERIC(5,2), -- Max 5 total digits, 2 TO the RIGHT OF the decimal (XXX.XX)
	customer_id INTEGER,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

SELECT *
FROM receipt;



-- DML STATEMENTS TO ADD DATA TO THE TABLES

-- Inserting data into the customer table
INSERT INTO customer(first_name, last_name, email, address, city, state)
VALUES('George', 'Washington', 'firstpres@usa.gov', '3200 Mt. Vernon Way', 'Mt. Vernon', 'VA'),
('John', 'Adams', 'jadams@whitehouse.org', '1234 W Presidential Place', 'Quincy', 'MA'),
('Thomas', 'Jefferson', 'iwrotethedeclaration@freeamerica.org', '555 Independence Drive', 'Charleston', 'VA'),
('James', 'Madison', 'fatherofconstitution@prez.io', '8345 E Eastern Ave', 'Richmond', 'VA'),
('James', 'Monroe', 'jmonroe@usa.gov', '3682 N Monroe Parkway', 'Chicago', 'IL');

-- Confirm the new customers have been added
SELECT *
FROM customer;

-- Add data to the receipt table
INSERT INTO receipt(amount, customer_id)
VALUES (23.32, 1);

INSERT INTO receipt(amount, customer_id)
VALUES (78.84, 3);

INSERT INTO receipt(amount, customer_id)
VALUES (173.85, 1);

INSERT INTO receipt(amount, customer_id)
VALUES (294.51, 2);

INSERT INTO receipt(amount, customer_id)
VALUES (73.97, null);

INSERT INTO receipt(amount, customer_id)
VALUES (876.54, null);

SELECT *
FROM receipt;

SELECT *
FROM customer;


SELECT *
FROM customer 
WHERE customer_id = 1;

SELECT *
FROM receipt
WHERE customer_id = 1;

-- USING JOINS we can combine these tables together on a common field
-- Syntax:
-- SELECT col_1, col_2, etc. (can be from either table)
-- FROM table_name_1 (will be considered the LEFT table)
-- JOIN table_name_2 (will be considered the RIGHT table)
-- ON table_name_1.col_name = table_name_2.col_name (where col_name is a Foreign Key to other col_name)

-- Inner Join - Most Common Join - deafult JOIN i.e. do not have to specify INNER
SELECT first_name, last_name, email, customer.customer_id AS cust_cust_id, receipt.customer_id AS rec_cust_id, amount, receipt_date, receipt_id
FROM customer 
INNER JOIN receipt 
ON customer.customer_id = receipt.customer_id;

-- Each Join

-- INNER JOIN
SELECT *
FROM customer 
JOIN receipt 
ON customer.customer_id = receipt.customer_id;

-- FULL JOIN
SELECT *
FROM customer 
FULL JOIN receipt 
ON customer.customer_id = receipt.customer_id;

-- LEFT JOIN
SELECT *
FROM customer -- LEFT Table
LEFT JOIN receipt -- RIGHT TABLE
ON customer.customer_id = receipt.customer_id;

-- LEFT JOIN *flip-flop left and right table*
SELECT *
FROM receipt -- LEFT Table
LEFT JOIN customer -- RIGHT TABLE
ON customer.customer_id = receipt.customer_id;

-- RIGHT JOIN
SELECT *
FROM customer -- LEFT Table
RIGHT JOIN receipt -- RIGHT TABLE
ON customer.customer_id = receipt.customer_id;


-- JOIN ON comes after the SELCT FROM and before the WHERE 
--
--SELECT 
--FROM 
--JOIN 
--ON 
--WHERE 
--GROUP BY 
--HAVING 
--ORDER BY 
--LIMIT 
--OFFSET 

SELECT customer.customer_id, first_name, last_name, COUNT(*), SUM(amount)
FROM customer 
JOIN receipt 
ON customer.customer_id = receipt.customer_id
WHERE last_name = 'Washington'
GROUP BY customer.customer_id, first_name, last_name;


-- ALIASING table Names

CREATE TABLE IF NOT EXISTS teacher(
	teacher_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50)
);


INSERT INTO teacher(first_name, last_name) VALUES ('Bob', 'Bobberson'), ('Frank', 'Franklinson');

CREATE TABLE IF NOT EXISTS student(
	student_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	teacher_id INTEGER NOT NULL,
	FOREIGN KEY(teacher_id) REFERENCES teacher(teacher_id)
);

INSERT INTO student(first_name, last_name, teacher_id)
VALUES ('Jimmy', 'Butler', 1), ('Jayson', 'Tatum', 2), ('Jaylen', 'Brown', 1), ('Dereck', 'Rose', 2);

SELECT *
FROM teacher;

SELECT *
FROM student;


SELECT teacher.first_name, teacher.last_name, student.first_name, student.last_name
FROM teacher 
JOIN student
ON teacher.teacher_id = student.teacher_id;

SELECT t.first_name, t.last_name, s.first_name, s.last_name
FROM teacher t
JOIN student s 
ON t.teacher_id = s.teacher_id;


