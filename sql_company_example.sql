CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    birth_date DATE,
    sex VARCHAR(1),
    salary INT,
    super_id INT,
    branch_id INT
);

CREATE TABLE branch (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(40),
    mgr_id INT,
    mgr_start_date DATE,
    FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(40),
    branch_id INT,
    FOREIGN KEY(branch_id)
    REFERENCES branch(branch_id)
    ON DELETE SET NULL
);

CREATE TABLE works_with (
    emp_id INT,
    client_id INT,
    total_sales INT,
    PRIMARY KEY(emp_id, client_id),
    FOREIGN KEY(emp_id)
    REFERENCES employee(emp_id)
    ON DELETE CASCADE,
    FOREIGN KEY(client_id)
    REFERENCES client(client_id)
    ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
    branch_id INT,
    supplier_name VARCHAR(40),
    supply_type VARCHAR(40),
    PRIMARY KEY(branch_id, supplier_name),
    FOREIGN KEY(branch_id)
    REFERENCES branch(branch_id)
    ON DELETE CASCADE
);

# have to respect the order of the commands because branch id in branch didnt exists at the start so we have to give it a NULL for start
INSERT INTO employee VALUES(100, 'Karim', 'Wölbert', '1992-06-26', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES (1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1)

# updating the Scranton branch and adding more employees related to that branch
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);


# updating the Stamford branch and adding more employees related to that branch
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);


# updating branch_supplier table 
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

# updating client table
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

# updating works_with table
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);


## USEFUL QUERYS

# Query to find all employee ordered by salary
SELECT * 
FROM employee
ORDER BY salary;

# Query to find all employee ordered by salary descending (absteigend)
SELECT * 
FROM employee
ORDER BY salary DESC;

# Query to find all employee ordered by sex and then name
SELECT * 
FROM employee
ORDER BY sex, first_name, last_name;

# Query to find the first 5 employees in the table
SELECT * 
FROM employee
LIMIT 5;

# Query to find the first and last name of all employees
SELECT first_name, last_name
FROM employee;

# Query to find the forname and surname of all employees
SELECT first_name AS forname, last_name AS surname
FROM employee;

# Find out all the different genders. Disctinct tells us the different values in a particular column
SELECT DISTINCT sex
FROM employee;



## MORE ADVANCED QUERIES

# Find the number of employees
SELECT COUNT(emp_id)
FROm employee;

# Find the number of employees have supervisors
SELECT COUNT(super_id)
FROM employee;

# Find the number of female employees born after 1970
SELECT COUNT(sex)
FROM employee
WHERE sex = 'F' AND birth_date >= '1970-01-01';

# Find the average of all employees salaries
SELECT SUM(salary) / COUNT(salary)
FROM employee;

better way:
SELECT AVG(salary)
FROM employee;

# Find the average of all male employees salaries
SELECT AVG(salary)
FROM employee
WHERE sex = 'M';

# Find the sum of all male employees salaries
SELECT SUM(salary)
FROM employee;

# Find out how many males and females there are. Using Group by for aggregation
SELECT COUNT(sex)
FROM employee
GROUP BY sex;

# Find the total sales of each salesman
SELECT SUM(total_sales), emp_id
FROM works_with
GROUP BY emp_id;

# Find the number of money each client is spending 
SELECT SUM(total_sales), client_id
FROM works_with
GROUP BY client_id;


## USING WILDCARDS
## % = any number of characters, _ = one character

# Find any clients who are an LLC (GmbH)
SELECT *
FROM client
WHERE client_name LIKE '%LLC';  --> name has to end in LLC

# Find any branch suppliers who are in the label business
SELECT *
FROM branch_supplier
WHERE supplier_name LIKE '%Label%'; --> label is anythere inside the name

# Find any employee born in october
SELECT *
FROM employee
WHERE birth_date LIKE '%-10-%';

other way:
# Find any employee born in october
SELECT *
FROM employee
WHERE birth_date LIKE '____-10%';

# Find any clients who are schools
SELECT *
FROM client
WHERE client_name LIKE '%school%';


## UNION - combine result of mutiple select statements in one

# Find a list of employee and branch names
SELECT first_name
FROM employee
UNION
SELECT branch_name
FROM branch;

# Find a list of all clients & branch suppliers names
SELECT client_name, branch_id
FROM client
UNION
SELECT supplier_name, branch_id
FROM branch_supplier;

# Find a list of all money spent or earned by the company 
SELECT total_sales
FROM works_with
UNION
SELECT salary
FROM employee;


## JOINS

##INNER JOIN --> only the branch managers get included
# Find all branches and the names of their managers
SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch
ON employee.emp_id = branch.mgr_id;

##LEFT JOIN --> all of the employees get included because all of the rows of the left table (employee) get included but only the rows of the right table which match get included
# Find all branches and the names of their managers
SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
LEFT JOIN branch
ON employee.emp_id = branch.mgr_id;

##RIGHT JOIN --> all of the branches get included because all of the rows of the right table (branch) get included but only the rows of the left table which match get included
# Find all branches and the names of their managers
SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
RIGHT JOIN branch
ON employee.emp_id = branch.mgr_id;


## NESTED QUERIES

# Find names of all employees who have sold over 30k to a single client

SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
    SELECT works_with.emp_id 
    FROM works_with
    WHERE works_with.total_sales > 29999
);

# Find all clients who are handled by the branch that Michael Scott manages

SELECT client_name
FROM client
WHERE branch_id IN (
    SELECT branch_id
    FROM branch
    WHERE mgr_id = 102
);

## ON DELETE

DELETE FROM employee
WHERE emp_id = 102;

ON DELETE SETS NULL --> sets the value of the associated values in the other tables to NULL, mostly used when the foreign key is not the primary key
ON DELETE CASCADE --> erases the whole row of associated values to the erased row, primary key can't be NULL so we have to use this if the associated values are primary keys

##TRIGGER

CREATE TRIGGER my_trigger BEFORE INSERT ON employee
FOR EACH ROW INSERT INTO trigger_test VALUES('added new employee');

INSERT INTO employee VALUES (109, 'Oscar', 'Martinez', '1986-02-19', 'M', 69000, 106, 3);

SELECT * FROM trigger_test;