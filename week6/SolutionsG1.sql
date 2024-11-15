/* Task 1 */

CREATE DATABASE university;
CREATE USER 'student'@'%' IDENTIFIED BY 'secure123';
GRANT SELECT, INSERT, UPDATE ON university.* TO 'student'@'%';
SHOW GRANTS FOR 'student'@'%';
REVOKE UPDATE ON university.* FROM 'student'@'%';
SHOW GRANTS FOR 'student'@'%';

/* Task 2 */

CREATE DATABASE company;
USE company;

CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15),
    hire_date DATE NOT NULL,
    department_id INT NOT NULL,
    CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    budget DECIMAL(12, 2)
);


CREATE TABLE salaries (
    salary_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    change_date DATE NOT NULL,
    CONSTRAINT fk_employee_salary FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE employee_project_assignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    project_id INT NOT NULL,
    role VARCHAR(50),
    assignment_date DATE NOT NULL,
    CONSTRAINT fk_employee_project FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    CONSTRAINT fk_project_assignment FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

CREATE TABLE clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    client_name VARCHAR(100) NOT NULL,
    contact_name VARCHAR(100),
    contact_email VARCHAR(100) UNIQUE,
    employee_id INT,
    CONSTRAINT fk_employee_assignment FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

/* Task 3 */

CREATE INDEX idx_employee_email ON employees(email);
CREATE INDEX idx_salary_change_date ON salaries(change_date);
CREATE INDEX idx_assignment_date ON employee_project_assignments(assignment_date);



