DROP TABLE titles, employees, departments, dept_manager, dept_emp, salaries;

CREATE TABLE titles(
	title_id VARCHAR(20) PRIMARY KEY,
	title VARCHAR(50)
);

CREATE TABLE employees(
	emp_no INT PRIMARY KEY,
	emp_title_id VARCHAR(20),
	birth_date VARCHAR(20),
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	sex VARCHAR(20) NOT NULL,
	hire_date DATE NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

CREATE TABLE departments(
	dept_no VARCHAR(20) PRIMARY KEY,
	dept_NAME VARCHAR(50) NOT NULL
);

CREATE TABLE dept_manager(
	dept_no VARCHAR(20),
	emp_no INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY(emp_no, dept_no)
);

CREATE TABLE dept_emp(
	emp_no INT,
	dept_no VARCHAR(20),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY(emp_no, dept_no)
);

CREATE TABLE salaries(
	emp_no INT PRIMARY KEY,
	salary INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

--List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, salary
FROM employees AS e
LEFT JOIN salaries ON e.emp_no = salaries.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--List the manager of each department along with their department number, 
--department name, employee number, last name, and first name.
SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM departments AS d
INNER JOIN dept_manager AS dm
ON d.dept_no = dm.dept_no
INNER JOIN employees AS e
ON dm.emp_no = e.emp_no;

--List the department number for each employee along with that employee’s employee number, 
--last name, first name, and department name.
SELECT de.dept_no, de.emp_no, e.last_name, e.first_name, d.dept_name
FROM departments AS d
INNER JOIN dept_emp AS de
ON d.dept_no = de.dept_no
INNER JOIN employees AS e
ON de.emp_no = e.emp_no;

--List first name, last name, and sex of each employee whose first name is Hercules and 
--whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, 
--and first name.
SELECT d.dept_name, de.emp_no, e.last_name, e.first_name
FROM departments AS d 
INNER JOIN dept_emp AS de
ON d.dept_no = de.dept_no
INNER JOIN employees AS e
ON de.emp_no = e.emp_no
WHERE d.dept_name = 'Sales';

--List each employee in the Sales and Development departments, including their employee 
--number, last name, first name, and department name.
SELECT d.dept_name, de.emp_no, e.last_name, e.first_name
FROM departments AS d 
INNER JOIN dept_emp AS de
ON d.dept_no = de.dept_no
INNER JOIN employees AS e
ON de.emp_no = e.emp_no
WHERE d.dept_name = 'Sales'
OR d.dept_name = 'Development';

--List the frequency counts, in descending order, of all the employee last names 
--(that is, how many employees share each last name).
SELECT last_name, COUNT(last_name) AS "Frequency of Last Names"
FROM employees
GROUP BY (last_name)
ORDER BY "Frequency of Last Names" DESC;