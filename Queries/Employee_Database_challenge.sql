-- Create retirement_titles table with titles of all retiring employees
SELECT e.emp_no, 
    e.first_name, 
    e.last_name, 
    ti.title, 
    ti.from_date, 
    ti.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Create table with count of titles for retiring employees
SELECT COUNT (title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

-- Create mentorship eligibility table
SELECT DISTINCT ON (e.emp_no)
    e.emp_no,
    e.first_name, 
    e.last_name, 
    e.birth_date, 
    de.from_date, 
    de.to_date, 
    ti.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
    ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
    ON (e.emp_no = ti.emp_no)
WHERE de.to_date = '9999-01-01'
    AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

--Create table with count retiring from each department
SELECT COUNT(d.dept_name),
	d.dept_name
INTO retirement_dept
FROM departments as d
INNER JOIN dept_emp as de
	ON (d.dept_no = de.dept_no)
INNER JOIN retirement_info as ri
	ON (de.emp_no = ri.emp_no)
GROUP BY d.dept_name
ORDER BY COUNT (d.dept_name) DESC;

--Create table with count of mentors from each department
SELECT COUNT(d.dept_name),
	d.dept_name
INTO mentorship_dept
FROM departments as d
INNER JOIN dept_emp as de
	ON (d.dept_no = de.dept_no)
INNER JOIN mentorship_eligibility as me
	ON (de.emp_no = me.emp_no)
GROUP BY d.dept_name
ORDER BY COUNT (d.dept_name) DESC;

--Create table with both mentor and retirement counts
SELECT rd.count,
    md.count,
    rd.dept_name
INTO mentor_retire
FROM retirement_dept as rd
INNER JOIN mentorship_dept as md
    ON (rd.dept_name = md.dept_name)
ORDER BY rd.count DESC;