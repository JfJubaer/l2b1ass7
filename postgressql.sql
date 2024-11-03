CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    age INT,
    email VARCHAR(255),
    frontend_mark INT,
    backend_mark INT,
    status VARCHAR(50)
);

INSERT INTO Students (student_id, student_name, age, email, frontend_mark, backend_mark, status)
VALUES
(1, 'Alice Johnson', 20, 'alice.johnson@example.com', 85, 90, NULL),
(2, 'Bob Smith', 22, 'bob.smith@example.com', 78, 82, NULL),
(3, 'Charlie Brown', 21, 'charlie.brown@example.com', 92, 88, NULL),
(4, 'Diana White', 19, 'diana.white@example.com', 80, 85, NULL),
(5, 'Edward Green', 23, 'edward.green@example.com', 76, 79, NULL);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);

INSERT INTO Courses (course_id, course_name, credits)
VALUES
(101, 'Introduction to Programming', 3),
(102, 'Database Management', 4),
(103, 'Web Development', 3),
(104, 'Data Structures', 4),
(105, 'Software Engineering', 3);

INSERT INTO Courses (course_id, course_name, credits)
VALUES
(106, 'Introduction to Programming for new', 3);


CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Enrollments (enrollment_id, student_id, course_id)
VALUES
(1, 1, 101),
(2, 2, 102),
(3, 3, 103),
(4, 4, 104),
(5, 5, 105);



-- query1

INSERT INTO Students (student_id, student_name, age, email, frontend_mark, backend_mark, status)
VALUES
(10, 'Alice Johnson', 20, 'alice.johnson@example.com', 85, 90, NULL);


-- query2

SELECT s.student_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Web Development';

UPDATE Students
SET status = 'Awarded'
WHERE student_id = (
    SELECT student_id
    FROM Students
    ORDER BY (frontend_mark + backend_mark) DESC
    LIMIT 1
);

 SELECT *
    FROM Courses c
    FULL JOIN Enrollments e ON c.course_id = e.course_id
    -- WHERE e.course_id IS NULL

DELETE FROM Courses
WHERE course_id IN (
    SELECT c.course_id
    FROM Courses c
    FULL JOIN Enrollments e ON c.course_id = e.course_id
    WHERE e.course_id IS NULL
);

SELECT student_name
FROM Students
ORDER BY student_id
LIMIT 2 OFFSET 2;

SELECT c.course_name, COUNT(e.student_id) AS number_of_students
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

SELECT AVG(age) AS average_age
FROM Students;

SELECT student_name
FROM Students
WHERE email LIKE '%edward.green@example.com%';









