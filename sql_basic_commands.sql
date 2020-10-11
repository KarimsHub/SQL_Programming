INT -- Whole numbers 
DECIMAL(10,4) -- Decimal Numbers - Exact Values 
Varchar(1) -- String of text of length 1 
Blob -- Binary Large Object, Stores large data
DATE -- 'YYYY-MM-DD'
TIMESTAMP -- 'YYYY-MM-DD HH:MM:SS' - used for recording

DROP TABLE student; #erase the created table

#Creating a new table with automatically incrementing the student id
CREATE TABLE student (
    student_id INT Auto_increment,
    name VARCHAR(20) NOT NULL,
    major VARCHAR(20) DEFAULT 'undecided',
    PRIMARY KEY(student_id)
);

SELECT * FROM student; # shows all values from the table

#Inserting new values to the table
INSERT INTO student VALUES(1, 'Claire', 'Chemie'); 
INSERT INTO student VALUES(2, 'Eren', 'VWL');
INSERT INTO student VALUES(3, 'Selino', 'Psychologie');
INSERT INTO student(name, major) VALUES('Brenner', 'BWL');
INSERT INTO student(name, major) VALUES('Mattis', 'Politics');

DESCRIBE student;

#The ALTER TABLE statement is used to add, delete, or modify columns in an existing table.
ALTER TABLE student ADD gpa DECIMAL(3, 2); # three total digits with two after the decimal

ALTER TABLE student DROP COLUMN gpa;

DELETE FROM student;
WHERE student_id = 5;

#Updating the existing Values
UPDATE student
SET major = 'Psy'
WHERE student_id = 3;
WHERE major = 'Chemie';
SET name = 'Tom', major = 'undecided'
WHERE student_id = 1; 

#Sorting/Ordering the existing Values
SELECT *
FROM student
ORDER BY major, student_id; # orders first the major and if there are doubles its sorts after the ID
ORDER BY name ASC; # ASC = geordnet
ORDER BY name DESC; # DESC = umgekehrt
ORDER BY student_id DESC
LIMIT 2;

#Selecting specific Values
SELECT *
FROM student
WHERE name IN ('Eren', 'Brenner'); # getting all rows which equal the given names
WHERE major <> 'Politics'; # not equal to Politics