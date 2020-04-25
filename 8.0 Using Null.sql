-- 01 lists the teachers who have NULL for their department
SELECT teacher.name
FROM teacher
WHERE dept IS NULL;

-- 02 INNER JOIN misses the teachers with no department and the departments with no teacher
SELECT teacher.name, dept.name
FROM teacher INNER JOIN dept ON teacher.dept = dept.id;

-- 03 different JOIN so that all teachers are listed
SELECT teacher.name, dept.name
FROM teacher LEFT JOIN dept ON teacher.dept = dept.id;

-- 04 different JOIN so that all departments are listed
SELECT teacher.name, dept.name
FROM teacher RIGHT JOIN dept ON teacher.dept = dept.id;

-- 05 shows teacher name and mobile number or '07986 444 2266'
SELECT teacher.name, COALESCE(teacher.mobile, '07986 444 2266')
FROM teacher;

-- 06 prints the teacher name and department name or 'None' where there is no department
SELECT teacher.name, COALESCE(dept.name, 'None')
FROM teacher LEFT JOIN dept ON teacher.dept = dept.id;

-- 07 shows the number of teachers and the number of mobile phones
SELECT COUNT(name), COUNT(mobile)
FROM teacher;

-- 08 shows each department and the number of staff
SELECT dept.name, COUNT(teacher.name)
FROM teacher RIGHT JOIN dept ON teacher.dept = dept.id
GROUP BY dept.name;

-- 09 shows the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise
SELECT teacher.name, CASE WHEN teacher.dept = 1 OR teacher.dept = 2 THEN 'Sci' ELSE 'Art' END
FROM teacher LEFT JOIN dept ON teacher.dept = dept.id;

-- 10 shows the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2, show 'Art' if the teacher's dept is 3 and 'None' otherwise
SELECT teacher.name, CASE WHEN teacher.dept = 1 OR teacher.dept = 2 THEN 'Sci' ELSE
                         CASE WHEN teacher.dept = 3 THEN 'Art' ELSE 'None' END END
FROM teacher LEFT JOIN dept ON teacher.dept = dept.id;
