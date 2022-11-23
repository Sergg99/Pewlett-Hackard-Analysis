-- Deliverable 1:
-- Comments: Some of this data is based on the pre-work also located in the GitHub (Pwelett-Hackard-Analysis > "Module Pre-Work" > "Queries")

------------------------- Data Retrival-------------------------
SELECT e.emp_no,
	e.first_name, 
	e.last_name,
	t.title, 
	t.from_date, 
	t.to_date
INTO data_extraction
FROM employees as e
JOIN titles as t
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

SELECT * FROM data_extraction


--------------------- Removing duplicate rows ---------------------
SELECT DISTINCT ON (e.emp_no) e.emp_no,
		e.first_name,
		e.last_name,
		t.title,
		t.from_date,
		t.to_date

INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no ASC;

SELECT * FROM retirement_titles

----------- Excluding employees that have already left the company -----------
--------------------------- Creating Unique Titles ---------------------------
SELECT DISTINCT ON(e.emp_no)e.emp_no,
	e.first_name,
	e.last_name,
	t.title
INTO unique_titles
FROM employees AS e
	INNER JOIN dept_emp AS de
		ON (e.emp_no = de.emp_no)
			INNER JOIN titles AS t
				ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no, t.from_date DESC;

 ----------------------- Creating Retiring_titles Table  -----------------------
 
SELECT count(title) "count", title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

SELECT * FROM retiring_titles

--Deliverable 2:
----------------------- Creating Mentorship_elegibility Table  -----------------------
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees AS e
LEFT JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
LEFT JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

SELECT * FROM mentorship_eligibilty