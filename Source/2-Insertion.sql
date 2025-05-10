-- Use the correct database
-- USE ComputerScienceCollegeDB;

-- =========================================
-- 1. Insert into Departments
-- =========================================
IF NOT EXISTS (SELECT * FROM Departments WHERE department_id = 1)
BEGIN
INSERT INTO Departments (department_id, name, building, office_number, head_of_department)
VALUES 
(1, 'Computer Science', 'Tech Hall', '101', NULL),
(2, 'Information Technology', 'IT Tower', '202', NULL),
(3, 'Health Informatics', 'Medical Building', '303', NULL),
(4, 'Business Analysis', 'Business Center', '404', NULL),
(5, 'Data Science', 'Innovation Hub', '505', NULL),
(6, 'Cybersecurity', 'Security Tower', '606', NULL),
(7, 'Software Engineering', 'DevHub', '707', NULL);
END;
-- =========================================
-- 2. Insert into Faculty
-- =========================================
IF NOT EXISTS (SELECT * FROM Faculty WHERE faculty_id = 100)
BEGIN
INSERT INTO Faculty (faculty_id, first_name, last_name, email, phone_number, hire_date, title, department_id)
VALUES 
(100, 'Ahmed', 'Al-Mutairi', 'a.mutairi@cscollege.edu', '050-123-4567', '2012-09-01', 'Professor', 1),
(101, 'Sara', 'Al-Dosari', 's.dosari@cscollege.edu', '050-234-5678', '2016-01-15', 'Associate Professor', 2),
(102, 'Mohammed', 'Al-Qahtani', 'm.qahtani@cscollege.edu', '050-345-6789', '2019-03-10', 'Lecturer', 3),
(103, 'Fatimah', 'Al-Harbi', 'f.harbi@cscollege.edu', '050-456-7890', '2018-06-20', 'Senior Lecturer', 4),
(104, 'Khalid', 'Al-Fahad', 'k.fahad@cscollege.edu', '050-567-8901', '2020-08-30', 'Assistant Professor', 5),
(105, 'Rania', 'Al-Sabah', 'r.sabah@cscollege.edu', '050-678-9012', '2021-01-10', 'Lecturer', 6),
(106, 'Ali', 'Al-Khalid', 'a.khalid@cscollege.edu', '050-789-0123', '2022-04-12', 'Professor', 7);
END;
-- Update head of department after faculty is added
UPDATE Departments SET head_of_department = 100 WHERE department_id = 1;
UPDATE Departments SET head_of_department = 101 WHERE department_id = 2;
UPDATE Departments SET head_of_department = 102 WHERE department_id = 3;
UPDATE Departments SET head_of_department = 103 WHERE department_id = 4;
UPDATE Departments SET head_of_department = 104 WHERE department_id = 5;
UPDATE Departments SET head_of_department = 105 WHERE department_id = 6;
UPDATE Departments SET head_of_department = 106 WHERE department_id = 7;

-- =========================================
-- 3. Insert into Students
-- =========================================
IF NOT EXISTS (SELECT * FROM Students WHERE student_id = 2001)
BEGIN
INSERT INTO Students (student_id, first_name, last_name, email, phone_number, gender, date_of_birth, enrollment_year, department_id)
VALUES 
(2001, 'Hassan', 'Al-Amri', 'hassan.amri@student.cscollege.edu', '055-123-4567', 'Male', '2003-04-10', 2022, 1),
(2002, 'Laila', 'Al-Zahrani', 'laila.zahrani@student.cscollege.edu', '055-234-5678', 'Female', '2002-11-30', 2021, 2),
(2003, 'Fahad', 'Al-Shahrani', 'fahad.shahrani@student.cscollege.edu', '055-345-6789', 'Male', '2001-06-22', 2020, 3),
(2004, 'Noura', 'Al-Ghamdi', 'noura.ghamdi@student.cscollege.edu', '055-456-7890', 'Female', '2000-12-15', 2019, 4),
(2005, 'Yousef', 'Al-Shehri', 'yousef.shehri@student.cscollege.edu', '055-567-8901', 'Male', '2002-02-08', 2021, 5),
(2006, 'Reem', 'Al-Mansour', 'reem.mansour@student.cscollege.edu', '055-678-9012', 'Female', '2003-03-20', 2022, 1),
(2007, 'Omar', 'Al-Rashid', 'omar.rashid@student.cscollege.edu', '055-789-0123', 'Male', '2001-08-05', 2020, 2),
(2008, 'Ali', 'Al-Khaled', 'ali.khaled@student.cscollege.edu', '055-890-1234', 'Male', '2002-05-10', 2021, 1),  
(2009, 'Maha', 'Al-Shammari', 'maha.shammari@student.cscollege.edu', '055-901-2345', 'Female', '2003-07-15', 2022, 2),  
(2010, 'Ziad', 'Al-Bishi', 'ziad.bishi@student.cscollege.edu', '055-012-3456', 'Male', '2001-11-02', 2020, 1),  
(2011, 'Dana', 'Al-Sulaiman', 'dana.sulaiman@student.cscollege.edu', '055-123-4567', 'Female', '2003-01-20', 2022, 5);  
END;
-- =========================================
-- 4. Insert into Courses
-- =========================================
IF NOT EXISTS (SELECT * FROM Courses WHERE course_id = 3001)
BEGIN
INSERT INTO Courses (course_id, course_code, title, description, credits, level, department_id)
VALUES 
(3001, 'CS101', 'Introduction to Programming', 'Basic concepts of programming using Python.', 3, 'Undergraduate', 1),
(3002, 'IT202', 'Networking Fundamentals', 'Principles of computer networking.', 3, 'Undergraduate', 2),
(3003, 'HI301', 'Medical Data Systems', 'Managing digital health records and data.', 4, 'Undergraduate', 3),
(3004, 'BA210', 'Business Intelligence', 'Introduction to BI tools and practices.', 3, 'Undergraduate', 4),
(3005, 'DS310', 'Machine Learning', 'Core machine learning techniques and applications.', 4, 'Undergraduate', 5),
(3006, 'CS202', 'Advanced Cybersecurity', 'Advanced topics in cybersecurity including network defense and digital forensics.', 3, 'Undergraduate', 6),
(3007, 'SE320', 'Software Design', 'Principles of software engineering and design patterns.', 4, 'Undergraduate', 7);
END;
-- =========================================
-- 5. Insert into Classrooms
-- =========================================
IF NOT EXISTS (SELECT * FROM Classrooms WHERE room_id = 4001)
BEGIN
INSERT INTO Classrooms (room_id, building, room_number, capacity, is_lab, has_projector)
VALUES 
(4001, 'Tech Hall', 'TH101', 50, 0, 1),
(4002, 'IT Tower', 'ITT202', 35, 1, 1),
(4003, 'Medical Building', 'MB303', 30, 1, 1),
(4004, 'Business Center', 'BC404', 40, 0, 1),
(4005, 'Innovation Hub', 'IH505', 45, 1, 1),
(4006, 'Security Tower', 'ST606', 30, 1, 1),
(4007, 'DevHub', 'DH707', 40, 0, 1);
END;
-- =========================================
-- 6. Insert into Course_Offerings
-- =========================================
IF NOT EXISTS (SELECT * FROM Course_Offerings WHERE offering_id = 5001)
BEGIN
INSERT INTO Course_Offerings (offering_id, course_id, faculty_id, term, year, schedule_days, start_time, end_time, room)
VALUES 
(5001, 3001, 100, 'Fall', 2024, 'Sun/Tue', '08:00', '09:30', 'TH101'),
(5002, 3002, 101, 'Fall', 2024, 'Mon/Wed', '10:00', '11:30', 'ITT202'),
(5003, 3003, 102, 'Fall', 2024, 'Tue/Thu', '12:00', '13:30', 'MB303'),
(5004, 3004, 103, 'Fall', 2024, 'Sun/Tue', '14:00', '15:30', 'BC404'),
(5005, 3005, 104, 'Fall', 2024, 'Mon/Wed', '09:00', '10:30', 'IH505'),
(5006, 3006, 105, 'Fall', 2024, 'Mon/Wed', '08:00', '09:30', 'ST606'),
(5007, 3007, 106, 'Fall', 2024, 'Tue/Thu', '10:00', '11:30', 'DH707');
END;
-- =========================================
-- 7. Insert into Enrollments
-- =========================================
IF NOT EXISTS (SELECT * FROM Enrollments WHERE enrollment_id = 6001)
BEGIN
INSERT INTO Enrollments (enrollment_id, student_id, offering_id, enrollment_date, grade, status)
VALUES 
(6001, 2001, 5001, '2024-08-21', NULL, 'Enrolled'),
(6002, 2002, 5002, '2024-08-22', NULL, 'Enrolled'),
(6003, 2003, 5003, '2024-08-23', NULL, 'Enrolled'),
(6004, 2004, 5004, '2024-08-24', NULL, 'Enrolled'),
(6005, 2005, 5005, '2024-08-25', NULL, 'Enrolled'),
(6006, 2006, 5001, '2024-08-26', NULL, 'Enrolled'),
(6007, 2007, 5002, '2024-08-27', NULL, 'Enrolled'),
(6008, 2005, 5001, '2024-08-27', NULL, 'Enrolled'),
(6009, 2001, 5002, '2024-08-28', NULL, 'Enrolled'),  
(6010, 2001, 5003, '2024-08-29', NULL, 'Enrolled'),  
(6011, 2001, 5004, '2024-08-30', NULL, 'Enrolled'), 
(6012, 2006, 5005, '2024-08-29', NULL, 'Enrolled'),  
(6013, 2006, 5003, '2024-08-30', NULL, 'Enrolled'),
(6014, 2002, 5002, '2024-08-30', NULL, 'Enrolled'),  
(6015, 2003, 5002, '2024-08-31', NULL, 'Enrolled'),  
(6016, 2004, 5002, '2024-09-01', NULL, 'Enrolled');
END;
-- =========================================
-- Final Verification Queries
-- =========================================
SELECT 'Departments' AS TableName, * FROM Departments;
SELECT 'Faculty' AS TableName, * FROM Faculty;
SELECT 'Students' AS TableName, * FROM Students;
SELECT 'Courses' AS TableName, * FROM Courses;
SELECT 'Classrooms' AS TableName, * FROM Classrooms;
SELECT 'Course_Offerings' AS TableName, * FROM Course_Offerings;
SELECT 'Enrollments' AS TableName, * FROM Enrollments;
