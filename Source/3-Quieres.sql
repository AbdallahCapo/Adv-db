USE UniversityDB;
-- ================================================
-- 1. Query: List all students who have enrolled in more than 3 courses.
-- ================================================
SELECT 
    s.first_name AS student_first_name,
    s.last_name AS student_last_name,
    COUNT(e.enrollment_id) AS total_courses
FROM 
    Students s
JOIN 
    Enrollments e ON s.student_id = e.student_id
GROUP BY 
    s.student_id, s.first_name, s.last_name
HAVING 
    COUNT(e.enrollment_id) > 3;



-- ================================================
-- 2. Query: Find the average credits for each department's courses.
-- ================================================
SELECT 
    d.name AS department_name,
    AVG(c.credits) AS average_credits
FROM 
    Departments d
JOIN 
    Courses c ON d.department_id = c.department_id
GROUP BY 
    d.department_id, d.name;



-- ================================================
-- 3. Query: List the courses offered by a faculty member with the most enrollments.
-- ================================================
SELECT TOP 1
    f.first_name AS faculty_first_name,
    f.last_name AS faculty_last_name,
    c.title AS course_title,
    COUNT(e.enrollment_id) AS total_enrollments
FROM 
    Faculty f
JOIN 
    Course_Offerings co ON f.faculty_id = co.faculty_id
JOIN 
    Courses c ON co.course_id = c.course_id
JOIN 
    Enrollments e ON co.offering_id = e.offering_id
GROUP BY 
    f.faculty_id, f.first_name, f.last_name, c.course_id, c.title
ORDER BY 
    total_enrollments DESC;



-- ================================================
-- 4. Query: List all students who have never enrolled in a course.
-- ================================================
SELECT 
    s.first_name AS student_first_name,
    s.last_name AS student_last_name
FROM 
    Students s
LEFT JOIN 
    Enrollments e ON s.student_id = e.student_id
WHERE 
    e.enrollment_id IS NULL;



-- ================================================
-- 5. Query: Find the department with the most number of students.
-- ================================================
SELECT TOP 1
    d.name AS department_name,
    COUNT(s.student_id) AS total_students
FROM 
    Departments d
JOIN 
    Students s ON d.department_id = s.department_id
GROUP BY 
    d.department_id, d.name
ORDER BY 
    total_students DESC;



-- ================================================
-- 6. Query: List the courses that have no enrollments.
-- ================================================
SELECT 
    c.title AS course_title
FROM 
    Courses c
LEFT JOIN 
    Course_Offerings co ON c.course_id = co.course_id
LEFT JOIN 
    Enrollments e ON co.offering_id = e.offering_id
WHERE 
    e.enrollment_id IS NULL;



-- ================================================
-- 7. Query: Find the total number of students and total credits enrolled for each department.
-- ================================================
SELECT 
    d.name AS department_name,
    COUNT(DISTINCT s.student_id) AS total_students,
    SUM(c.credits) AS total_credits
FROM 
    Departments d
JOIN 
    Students s ON d.department_id = s.department_id
JOIN 
    Enrollments e ON s.student_id = e.student_id
JOIN 
    Course_Offerings co ON e.offering_id = co.offering_id
JOIN 
    Courses c ON co.course_id = c.course_id
GROUP BY 
    d.department_id, d.name;


-- ================================================
-- 8. Query: List all classrooms with a capacity greater than the average classroom capacity.
-- ================================================
SELECT 
    room_id, 
    building, 
    room_number, 
    capacity
FROM 
    Classrooms
WHERE 
    capacity > (SELECT AVG(capacity) FROM Classrooms);

