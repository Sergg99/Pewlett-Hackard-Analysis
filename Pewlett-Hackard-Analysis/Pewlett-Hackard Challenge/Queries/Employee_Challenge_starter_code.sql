-- NOT THE SUBMISSION QUERY

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (e.emp_no) e.emp_no,
		e.first_name,
		e.last_name,
		t.title,
		t.from_date,
		t.to_date

-- INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no ASC;

SELECT * FROM retirement_titles

-- Unique Titles Excluding employees that have already left the company by filtering on to_date 
SELECT DISTINCT ON(e.emp_no)e.emp_no,
	e.first_name,
	e.last_name,
	t.title
--INTO unique_titles
FROM employees AS e
	INNER JOIN dept_emp AS de
		ON (e.emp_no = de.emp_no)
			INNER JOIN titles AS t
				ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no, t.from_date DESC;

-- Retiring_titles


SELECT count(title) "count", title
--INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

SELECT * FROM retiring_titles












-- Retry for filtering employees that have left
SELECT DISTINCT ON (emp_no) e.emp_no, 
e.first_name, 
e.last_name, 
e.birth_date, 
de.from_date, 
de.to_date, 
t.title
--INTO mentorship_eligibility
FROM employees as e
JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no ASC;


