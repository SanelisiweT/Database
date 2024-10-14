CREATE DATABASE school;
USE school;
 
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DOB DATE,
    EnrollmentDate DATE
);
 
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Credits INT
);
 
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    Grade CHAR(2),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
-- Insert into Students
INSERT INTO Students (StudentID, FirstName, LastName, DOB, EnrollmentDate) VALUES
(1, 'Mzukiseni', 'Duze', '2000-01-15', '2024-09-01'),
(2, 'Candry', 'Smith', '1999-07-22', '2024-09-01'),
(3, 'Sane', 'Majali', '2001-03-30', '2024-09-01'),
(4, 'Mihle', 'Mandlakhe', '2002-11-25', '2024-09-01'),
(5, 'Asemahle', 'Tyelinzima', '2000-09-10', '2024-09-01');
 
-- Insert into Courses
INSERT INTO Courses (CourseID, CourseName, Credits) VALUES
(1, 'Mathematics', 3),
(2, 'Science', 4),
(3, 'History', 3);
 
-- Insert into Enrollments
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, Grade) VALUES
(1, 1, 1, 'A'),
(2, 1, 2, 'B'),
(3, 2, 1, 'C'),
(4, 2, 3, 'A'),
(5, 3, 2, 'B'),
(6, 3, 3, 'C'),
(7, 4, 1, 'B'),
(8, 4, 2, 'A'),
(9, 5, 1, 'A'),
(10, 5, 3, 'B');
 
CREATE VIEW StudentGrades AS
SELECT 
    s.StudentID,
    s.FirstName,
    s.LastName,
    e.CourseID,
    e.Grade
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID;
 
-- Get Student Grades
DELIMITER //
CREATE PROCEDURE GetStudentGrades(IN studentID INT)
BEGIN
    SELECT 
        s.FirstName,
        s.LastName,
        c.CourseName,
        e.Grade
    FROM Students s
    JOIN Enrollments e ON s.StudentID = e.StudentID
    JOIN Courses c ON e.CourseID = c.CourseID
    WHERE s.StudentID = studentID;
END //
DELIMITER ;
 
-- Add Enrollment
DELIMITER //
CREATE PROCEDURE AddEnrollment(IN enrollmentID INT, IN studentID INT, IN courseID INT, IN grade CHAR(2))
BEGIN
    INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, Grade) 
    VALUES (enrollmentID, studentID, courseID, grade);
END //
DELIMITER ;
 
 -- Update Courses 
 DELIMITER //

CREATE PROCEDURE UpdateCourses(
    IN p_CourseID INT,
    IN nw_CourseName VARCHAR(50),
    IN nw_Credits INT
)
BEGIN
    UPDATE Courses
    SET CourseName = p_CourseName,
        Credits = p_Credits
    WHERE CourseID = od_CourseID;
END //

DELIMITER ;

