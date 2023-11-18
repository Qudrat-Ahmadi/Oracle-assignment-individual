-- Create a table with optional data types and constraints

 /* if we want to create a auto increment id use of this command
 
    entity_name  NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) 
    */
CREATE TABLE employees (
    Emp_id  NUMBER(10)  primary key, 
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    email VARCHAR2(100) UNIQUE,
    hire_date DATE DEFAULT SYSDATE,
    salary  NUMBER(12, 2) CHECK (salary > 0)
);
drop table employees;
 
desc employees;

-- now i wanna insert some employees to employee table
insert into employees values(10,'Qudrat','Ahmadi','Ahmadi@gmil.com',sysdate,90000);
insert into employees values(20,'Ahmad','jahani','Ahmad@gmil.com',sysdate,5000);
 insert into employees values(40,'Zaman','Ahmadi','Ahmai@gmil.com',sysdate,87900);
insert into employees values(50,'Lyla','Amiri','Am@gmil.com',sysdate,7800);
insert into employees values(60,'Ali','Ahmadi','Ahm@gmil.com',sysdate,465400);
insert into employees values(33,'khan','jan','jan@gmail.com',sysdate,88900);
insert into employees values(44,'Firshta','Haidari','Fri@gmail.com',sysdate,94300);
 
select * from employees;

-- Create an index on the email column
CREATE INDEX idx_employees_email ON employees(email);

-- Create a view
CREATE VIEW employee_details AS
SELECT Emp_id, first_name || ' ' || last_name AS full_name, email, salary
FROM employees;

-- Create a synonym for the employee_details view
CREATE SYNONYM emp_details FOR employee_details;

-- Create a sequence
CREATE SEQUENCE employee_Emp_id_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;
 
-- Create roles and grant privileges
CREATE ROLE hr_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON employees TO hr_role;
GRANT hr_role TO username;

 -- Create a trigger
CREATE OR REPLACE TRIGGER update_salary_trigger
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    :NEW.salary := :NEW.salary * 1.1;
END;