# Pewlett-Hackard-Analysis

## Overview 
- The purpose of this exercise was to gain a better understanding of the employees that would be likely to be retiring in the near future based on their birthdates. 

## Results
- The title group with the most employees up for retirement is Senior Engineers which means there are a lot of Engineers that will either need to be promoted or hired.
- There are only 2 Managers that are up for retirement soon which means that there will not be many Managers that will need to be replaced in the near future. 
- About 14% of employees will be retiring in the next few years.
- There is a large range of time that the mentorship eligible employees have been working at the company which means that there are some people in this group that have less experience than others and expanding the age range that are eligible for mentorship would probably be beneficial due to the large number of retirees. 

## Summary
- There are 41,380 roles that will need to be filled as the "silver tsunami" begins.
- There are not enough employees to mentor the next generation as there are only 1549 employees that are eligible to be mentors and there are 41,380 roles that need to be filled. 
- One table that could help to gain a better understanding of this situation would be to look at the various departments will be impacted by this. 
~~~  
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
~~~
- From this table we can see that there are a lot of employees retiring from the Development and Production departments. This means that management should focus on hiring and training employees for these departments. 
- Another table that could be helpful is to know how the number of mentors relates to the number of retirees.
~~~
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
~~~
- From this table we can see that the mentors are not spread around the departments that really need a lot of replacements equally. There is a lack of mentors in Quality Management which is something that management should look into as the "silver tsunami" approaches.
