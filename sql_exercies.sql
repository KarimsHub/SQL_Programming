CREATE DATABASE exercises;

USE exercises;

CREATE TABLE salesman (
	salesman_id INT,
    name VARCHAR(20),
    city VARCHAR(20),
    comission DECIMAL(3,2),
    PRIMARY KEY(salesman_id)
    );

INSERT INTO salesman VALUES(5001, 'James Hoog', 'New York', 0.15);
INSERT INTO salesman VALUES(5002, 'Nail Knite', 'Paris', 0.13);
INSERT INTO salesman VALUES(5005, 'Pit Alex', 'London', 0.11);
INSERT INTO salesman VALUES(5006, 'Mc Lyon', 'Paris', 0.14);
INSERT INTO salesman VALUES(5007, 'Paul Adam', 'Rome', 0.13);
INSERT INTO salesman VALUES(5003, 'Lauson Hen', 'San Jose', 0.12);


1. Write a SQL statement to display all the information of all salesmen.
SELECT * FROM salesman;

2. Write a SQL statement to display a string "This is SQL Exercise, Practice and Solution".
SELECT 'This is a string';

3. Write a query to display three numbers in three columns.
SELECT 5, 10, 15;

4. Write a query to display the sum of two numbers 10 and 15 from RDMS sever.
SELECT SUM(10 + 15);

5. Write a query to display the result of an arithmetic expression.
SELECT 10 + 15 - 9 * 2;

6. Write a SQL statement to display specific columns like name and commission for all the salesmen.
SELECT name, comission
FROM salesman
ORDER BY comission
;

7. Write a SQL statement to display names and city of salesman, who belongs to the city of Paris.
SELECT name, city
FROM salesman
WHERE city = 'Paris';

8. Write a query to display the columns in a specific order like order date, salesman id, order number and purchase amount from for all the orders. 

CREATE TABLE order_no (
	ord_no INT,
    purch_amt DECIMAL(6,2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    PRIMARY KEY(ord_no),
    FOREIGN KEY(salesman_id) REFERENCES salesman(salesman_id) ON DELETE CASCADE);

INSERT INTO order_no (
	ord_no,
    purch_amt,
    ord_date,
    customer_id,
    salesman_id
    ) 
    VALUES
    (
    70001, 150.5, '2012-10-05', 3005, 5002
    ),
    (
    70009, 270.65, '2012-09-10', 3001, 5005
    );

SELECT ord_date, salesman_id, ord_no, purch_amt
FROM order_no;
