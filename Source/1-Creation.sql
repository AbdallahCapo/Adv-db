IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'UniversityDB')
BEGIN
    CREATE DATABASE UniversityDB;
END;


USE UniversityDB;

-- ================================================
-- 1. Create SQL Login and User
-- ================================================
IF NOT EXISTS (SELECT * FROM sys.sql_logins WHERE name = 'Abdallah')
BEGIN
    CREATE LOGIN Abdallah WITH PASSWORD = 'Capo2017';
END;

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'Abdallah')
BEGIN
    CREATE USER Abdallah FOR LOGIN Abdallah;
    EXEC sp_addrolemember 'db_owner', 'Abdallah';
END;

-- ================================================
-- 2. Drop existing tables to avoid conflicts
-- (Drop constraints before dropping tables)
-- ================================================
-- Drop foreign key constraints before dropping tables
IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Department_Head')
BEGIN
    ALTER TABLE Departments DROP CONSTRAINT FK_Department_Head;
END;

IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Faculty_Department')
BEGIN
    ALTER TABLE Faculty DROP CONSTRAINT FK_Faculty_Department;
END;

IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Student_Department')
BEGIN
    ALTER TABLE Students DROP CONSTRAINT FK_Student_Department;
END;

IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Course_Department')
BEGIN
    ALTER TABLE Courses DROP CONSTRAINT FK_Course_Department;
END;

IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_CourseOffering_Course')
BEGIN
    ALTER TABLE Course_Offerings DROP CONSTRAINT FK_CourseOffering_Course;
END;

IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_CourseOffering_Faculty')
BEGIN
    ALTER TABLE Course_Offerings DROP CONSTRAINT FK_CourseOffering_Faculty;
END;

IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Enrollment_Student')
BEGIN
    ALTER TABLE Enrollments DROP CONSTRAINT FK_Enrollment_Student;
END;

IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Enrollment_CourseOffering')
BEGIN
    ALTER TABLE Enrollments DROP CONSTRAINT FK_Enrollment_CourseOffering;
END;

-- Drop the tables
IF OBJECT_ID('Enrollments', 'U') IS NOT NULL DROP TABLE Enrollments;
IF OBJECT_ID('Course_Offerings', 'U') IS NOT NULL DROP TABLE Course_Offerings;
IF OBJECT_ID('Courses', 'U') IS NOT NULL DROP TABLE Courses;
IF OBJECT_ID('Classrooms', 'U') IS NOT NULL DROP TABLE Classrooms;
IF OBJECT_ID('Faculty', 'U') IS NOT NULL DROP TABLE Faculty;
IF OBJECT_ID('Students', 'U') IS NOT NULL DROP TABLE Students;
IF OBJECT_ID('Departments', 'U') IS NOT NULL DROP TABLE Departments;

-- ================================================
-- 3. Create Tables with Constraints & Cardinalities
-- ================================================
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    building VARCHAR(50),
    office_number VARCHAR(10),
    head_of_department INT NULL  -- Will be linked after Faculty is created
);

CREATE TABLE Faculty (
    faculty_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    hire_date DATE,
    title VARCHAR(50),
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Now we add the FK for head_of_department
ALTER TABLE Departments
ADD CONSTRAINT FK_Department_Head
    FOREIGN KEY (head_of_department) REFERENCES Faculty(faculty_id);

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    gender VARCHAR(10),
    date_of_birth DATE,
    enrollment_year INT,
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_code VARCHAR(15) UNIQUE NOT NULL,
    title VARCHAR(100),
    description TEXT,
    credits INT CHECK (credits BETWEEN 1 AND 10),
    level VARCHAR(20),
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Classrooms (
    room_id INT PRIMARY KEY,
    building VARCHAR(50),
    room_number VARCHAR(10),
    capacity INT CHECK (capacity > 0),
    is_lab BIT,
    has_projector BIT
);

CREATE TABLE Course_Offerings (
    offering_id INT PRIMARY KEY,
    course_id INT NOT NULL,
    faculty_id INT NOT NULL,
    term VARCHAR(10),       -- e.g., 'Fall'
    year INT,
    schedule_days VARCHAR(20),
    start_time TIME,
    end_time TIME,
    room VARCHAR(20),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id)
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    offering_id INT NOT NULL,
    enrollment_date DATE,
    grade VARCHAR(2),
    status VARCHAR(20),  -- e.g., 'Enrolled', 'Completed', 'Withdrawn'
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (offering_id) REFERENCES Course_Offerings(offering_id)
);
