USE UniversityDB;

-- ================================================
-- 1. Drop existing views to avoid conflicts (if any)
-- ================================================
IF EXISTS (SELECT * FROM sys.views WHERE name = 'StudentProgress')
BEGIN
    DROP VIEW StudentProgress;
END;

IF EXISTS (SELECT * FROM sys.views WHERE name = 'InstructorLoad')
BEGIN
    DROP VIEW InstructorLoad;
END;

IF EXISTS (SELECT * FROM sys.views WHERE name = 'DepartmentOverview')
BEGIN
    DROP VIEW DepartmentOverview;
END;

GO -- Batch separator

-- ================================================
-- 2. Create Student Progress View
-- ================================================
CREATE VIEW StudentProgress AS
SELECT 
    s.student_id,
    s.first_name AS student_first_name,
    s.last_name AS student_last_name,
    c.course_code,
    c.title AS course_title,
    e.grade,
    e.status AS enrollment_status,
    e.enrollment_date
FROM 
    Students s
JOIN 
    Enrollments e ON s.student_id = e.student_id
JOIN 
    Course_Offerings co ON e.offering_id = co.offering_id
JOIN 
    Courses c ON co.course_id = c.course_id;
GO -- Batch separator

-- ================================================
-- 3. Create Instructor Load View
-- ================================================
CREATE VIEW InstructorLoad AS
SELECT 
    f.faculty_id,
    f.first_name AS instructor_first_name,
    f.last_name AS instructor_last_name,
    c.course_code,
    c.title AS course_title,
    COUNT(e.student_id) AS enrolled_students
FROM 
    Faculty f
JOIN 
    Course_Offerings co ON f.faculty_id = co.faculty_id
JOIN 
    Courses c ON co.course_id = c.course_id
LEFT JOIN 
    Enrollments e ON co.offering_id = e.offering_id
GROUP BY 
    f.faculty_id, f.first_name, f.last_name, c.course_code, c.title;
GO -- Batch separator

-- ================================================
-- 3. Create Department Overview View
-- ================================================
CREATE VIEW DepartmentOverview AS
SELECT 
    d.department_id,
    d.name AS department_name,
    d.building AS department_building,
    f.first_name AS head_first_name,
    f.last_name AS head_last_name,
    COUNT(DISTINCT f.faculty_id) AS total_faculty,
    COUNT(DISTINCT s.student_id) AS total_students
FROM 
    Departments d
LEFT JOIN 
    Faculty f ON d.head_of_department = f.faculty_id
LEFT JOIN 
    Faculty f2 ON d.department_id = f2.department_id
LEFT JOIN 
    Students s ON d.department_id = s.department_id
GROUP BY 
    d.department_id, d.name, d.building, f.first_name, f.last_name;
GO -- Batch separator

-- ================================================
-- 5. Select the output from the views to verify the data
-- ================================================
-- Get the student progress details
SELECT * FROM StudentProgress;
GO

-- Get the instructor load details
SELECT * FROM InstructorLoad;
GO

-- Get the department overview details
SELECT * FROM DepartmentOverview;
GO
