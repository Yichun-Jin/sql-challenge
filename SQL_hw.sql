--Create tables
Create table department(
	dept_no VARCHAR NOT NULL ,
	dept_name VARCHAR NOT NULL,
	CONSTRAINT "pk_departments" PRIMARY KEY ("dept_no")
);

CREATE TABLE "dept_emp" (
    "emp_no" INT NOT NULL,
    "dept_no" VARCHAR NOT NULL,
    "from_date" DATE NOT NULL,
    "to_date" DATE NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR NOT NULL,
    "emp_no" INT NOT NULL,
    "from_date" DATE NOT NULL,
    "to_date" DATE NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INT NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
     CONSTRAINT "pk_employees" PRIMARY KEY ("emp_no")
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" INT   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

select * from department;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;

--List each employee: employee number, last name, first name, gender, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no;

--List employees who were hired in 1986.
SELECT employees.last_name, employees.first_name,employees.hire_date 
FROM employees
Where hire_date between '1986-01-01' and '1987-01-01';

--List the manager of each department with the following information: department number, 
--department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT department.dept_no,department.dept_name,dept_manager.emp_no,employees.first_name,employees.last_name,
       dept_manager.from_date,dept_manager.to_date
From department
JOIN dept_manager
ON department.dept_no = dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no;

--List the department of each employee with the following information: employee number, last name, 
--first name, and department name.
SELECT dept_emp.emp_no, department.dept_name,employees.first_name, employees.last_name
From employees
JOIN dept_emp
ON dept_emp.emp_no = employees.emp_no
JOIN department
ON department.dept_no = dept_emp.dept_no;

--List all employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules'
AND last_name like 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.first_name, employees.last_name, department.dept_name
From employees
JOIN dept_emp
ON dept_emp.emp_no = employees.emp_no
JOIN department
ON department.dept_no = dept_emp.dept_no
WHERE department.dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their employee number, 
--last name, first name, and department name.
SELECT employees.emp_no, employees.first_name, employees.last_name, department.dept_name
From employees
JOIN dept_emp
ON dept_emp.emp_no = employees.emp_no
JOIN department
ON department.dept_no = dept_emp.dept_no
WHERE department.dept_name = 'Sales' 
OR department.dept_name = 'Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name,
COUNT(last_name) as "frequency"
From employees
GROUP BY last_name
ORDER BY count(last_name) desc;