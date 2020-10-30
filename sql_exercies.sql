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

9. Write a query which will retrieve the value of salesman id of all salesmen, getting orders from the customers in orders table without any repeats. 
SELECT DISTINCT salesman_id
FROM order_no;

10. Write a SQL statement to display all the information for those customers with a grade of 200.
SELECT * 
FROM customer
WHERE grade = 200;

11. Write a SQL query to display the order number followed by order date and the purchase amount for each order which will be delivered by the salesman who is holding the ID 5001.
SELECT ord_no, ord_date, purch_amt
FROM orders
WHERE salesman_id = 5001;

12. Write a SQL query to display the Nobel prizes for 1970.
SELECT year,subject,winner 
FROM nobel_win 
WHERE year=1970; 

13. Write a SQL query to know the winner of the 1971 prize for Literature. 
SELECT winner
FROM nobel_win
WHERE year = 1971 AND subject = 'Literature';

14. Write a SQL query to display the year and subject that won 'Dennis Gabor' his prize.
SELECT year, subject
FROM nobel_win
WHERE winner = 'Dennis Gabor';

15. Write a SQL query to give the name of the 'Physics' winners since the year 1950.
SELECT winner
FROM nobel_win
WHERE year >= 1950 AND subject = 'Physics';

16. Write a SQL query to Show all the details (year, subject, winner, country ) of the Chemistry prize winners between the year 1965 to 1975 inclusive. 
SELECT *
FROM nobel_win
WHERE subject = 'Chemistry' 
AND year BETWEEN 1965 AND 1975;

17. Write a SQL query to show all details of the Prime Ministerial winners after 1972 of Menachem Begin and Yitzhak Rabin.
SELECT *
FROM nobel_win
WHERE category = 'Prime Minister' 
AND year > 1972;

18. Write a SQL query to show all the details of the winners with first name Louis.
SELECT *
FROM nobel_win
WHERE winner LIKE 'Louis%';

19. Write a SQL query to show all the winners in Physics for 1970 together with the winner of Economics for 1971. 
SELECT *
FROM nobel_win
WHERE subject = 'Physics' AND year = 1970
UNION 
SELECT * 
FROM nobel_win 
WHERE subject = 'Economics' AND year = 1971;

20. Write a SQL query to show all the winners of nobel prize in the year 1970 except the subject Physiology and Economics
SELECT *
FROM nobel_win 
WHERE year=1970
AND subject NOT IN('Physiology','Economics');
