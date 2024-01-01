-- Add all exam types
INSERT INTO examtype VALUES (1, 'Quiz', 0.10),
(2, 'Assignment', 0.10),
(3, 'MSE', 0.30),
(4, 'ESE', 0.50);

-- Add Department
INSERT INTO Department (dept_name) VALUES ('Computer Science');

-- Add Users
-- INSERT INTO User (role, fname, lname, DOB, password, profile_pic, phone_number, email, gender, cnic, nationality, religion, marital_status, age)
-- VALUES
-- ('student', 'Abdur', 'Rehman', '2003-11-23', 'password123', 'profile_pic1.jpg', '1234567890', 'abdurRehman@student.com', 'Male', '02345-6789123-4', 'Pakistani', 'Islam', 'Single', 20),
-- ('student', 'Muhammad', 'Saad', '2002-05-22', 'password456', 'profile_pic2.jpg', '9876543210', 'SaadDX@student.com', 'Male', '56789-1234567-0', 'Pakistani', 'Islam', 'Single', 22),
-- ('faculty', 'Dr.Shams', 'Qazi', '1978-08-10', 'facultyPass', 'profile_pic3.jpg', '5556667777', 'shamsQazi@seecs.com', 'Male', '98765-4321098-7', 'Pakistani', 'Islam', 'Married', 44),
-- ('admin', 'Admin', 'User', '1985-03-20', 'adminPass', 'profile_pic4.jpg', '1112223333', 'admin@example.com', 'Male', '11111-2222333-4', 'American', 'Islam', 'Married', 37);

-- Add Users using Encrypted Procedure
call InsertUserWithEncryptedPassword('student', 'Abdur', 'Rehman', '2003-11-23', 'password123', 'profile_pic1.jpg', '1234567890', 'abdurRehman@student.com', 'Male', '02345-6789123-4', 'Pakistani', 'Islam', 'Single', 20);
call InsertUserWithEncryptedPassword('student', 'Muhammad', 'Saad', '2002-05-22', 'password456', 'profile_pic2.jpg', '9876543210', 'SaadDX@student.com', 'Male', '56789-1234567-0', 'Pakistani', 'Islam', 'Single', 22);
call InsertUserWithEncryptedPassword('faculty', 'Dr.Shams', 'Qazi', '1978-08-10', 'facultyPass', 'profile_pic3.jpg', '5556667777', 'shamsQazi@seecs.com', 'Male', '98765-4321098-7', 'Pakistani', 'Islam', 'Married', 44);
call InsertUserWithEncryptedPassword('admin', 'Admin', 'User', '1985-03-20', 'adminPass', 'profile_pic4.jpg', '1112223333', 'admin@example.com', 'Male', '11111-2222333-4', 'American', 'Islam', 'Married', 37);

-- Add Entries in Respective Child Tables
INSERT INTO Student (uuid, cms, career, program, current_semester, batch, dept_id)
VALUES
(1, 408160, 'Computer Science', 'BS', 'Fall 2023', '2023-CS-01', 1),
(2, 422791, 'Computer Science', 'BS', 'Fall 2023', '2023-CS-02', 1);

INSERT INTO Faculty (uuid, emp_id, designation, salary, starting_year, dept_id)
VALUES
(3, 1, 'Professor', 80000, 2010, 1);

INSERT INTO Admin (uuid, adminCode)
VALUES
(4, 1);


-- Add Courses

INSERT INTO Course (cname, credit_hours) VALUES
('Introduction to Programming', 3),
('Database Systems', 4),
('Computer Networks', 3),
('Software Engineering', 4),
('Artificial Intelligence', 3);


-- Enroll Students in Courses

INSERT INTO enrols (cms, cid, term, `year`)
VALUES
(408160, 1, 'Fall', 2023),
(408160, 2, 'Fall', 2023),
(408160, 3, 'Fall', 2023),
(408160, 4, 'Fall', 2023),
(408160, 5, 'Fall', 2023),
(422791, 1, 'Fall', 2023),
(422791, 2, 'Fall', 2023),
(422791, 3, 'Fall', 2023),
(422791, 4, 'Fall', 2023),
(422791, 5, 'Fall', 2023);


-- Faculty Teaches Courses

INSERT INTO teaches (emp_id, cid, term, `year`)
VALUES (1, 1, 'Fall', 2023),
(1, 2, 'Fall', 2023),
(1, 3, 'Fall', 2023),
(1, 4, 'Fall', 2023),
(1, 5, 'Fall', 2023);


-- Add Attendance for 10 Days (Random Status)

INSERT INTO attendance (cms, cid, `date`, `status`)		-- run this multiple times to get more records of attendance
SELECT
    cms,
    cid,
    CURRENT_DATE - INTERVAL FLOOR(RAND() * 10) DAY,
    CASE WHEN RAND() > 0.5 THEN 'Present' ELSE 'Absent' END
FROM enrols
WHERE `year` = 2023 AND term = 'Fall';


-- Add Exam Results for each Exam Type of each course

INSERT INTO result (cms, cid, exam_type, total_marks, marks_obtained, dateTime)
VALUES
(408160, 1, 1, 10, 5, '2023-12-31 08:00:00'),
(408160, 1, 2, 10, 7, '2023-12-31 09:30:00'),
(408160, 1, 3, 50, 23, '2023-12-31 11:00:00'),
(408160, 1, 4, 100,55, '2023-12-31 13:30:00'),
(408160, 2, 1, 10, 3, '2023-12-31 08:00:00'),
(408160, 2, 2, 10, 5, '2023-12-31 09:30:00'),
(408160, 2, 3, 50, 33, '2023-12-31 11:00:00'),
(408160, 2, 4, 100,35, '2023-12-31 13:30:00'),
(408160, 3, 1, 10, 7, '2023-12-31 08:00:00'),
(408160, 3, 2, 10, 8, '2023-12-31 09:30:00'),
(408160, 3, 3, 50, 20, '2023-12-31 11:00:00'),
(408160, 3, 4, 100,85, '2023-12-31 13:30:00'),
(408160, 4, 1, 10, 4, '2023-12-31 08:00:00'),
(408160, 4, 2, 10, 9, '2023-12-31 09:30:00'),
(408160, 4, 3, 50, 40, '2023-12-31 11:00:00'),
(408160, 4, 4, 100,85, '2023-12-31 13:30:00'),
(408160, 5, 1, 10, 9, '2023-12-31 08:00:00'),
(408160, 5, 2, 10, 9, '2023-12-31 09:30:00'),
(408160, 5, 3, 50, 44, '2023-12-31 11:00:00'),
(408160, 5, 4, 100,34, '2023-12-31 13:30:00'),
(422791, 1, 1, 10, 3, '2023-12-31 08:00:00'),
(422791, 1, 2, 10, 8, '2023-12-31 09:30:00'),
(422791, 1, 3, 50, 43, '2023-12-31 11:00:00'),
(422791, 1, 4, 100,85, '2023-12-31 13:30:00'),
(422791, 2, 1, 10, 1, '2023-12-31 08:00:00'),
(422791, 2, 2, 10, 3, '2023-12-31 09:30:00'),
(422791, 2, 3, 50, 34, '2023-12-31 11:00:00'),
(422791, 2, 4, 100,67, '2023-12-31 13:30:00'),
(422791, 3, 1, 10, 4, '2023-12-31 08:00:00'),
(422791, 3, 2, 10, 5, '2023-12-31 09:30:00'),
(422791, 3, 3, 50, 34, '2023-12-31 11:00:00'),
(422791, 3, 4, 100,34, '2023-12-31 13:30:00'),
(422791, 4, 1, 10, 7, '2023-12-31 08:00:00'),
(422791, 4, 2, 10, 3, '2023-12-31 09:30:00'),
(422791, 4, 3, 50, 34, '2023-12-31 11:00:00'),
(422791, 4, 4, 100,99, '2023-12-31 13:30:00'),
(422791, 5, 1, 10, 3, '2023-12-31 08:00:00'),
(422791, 5, 2, 10, 3, '2023-12-31 09:30:00'),
(422791, 5, 3, 50, 24, '2023-12-31 11:00:00'),
(422791, 5, 4, 100,94, '2023-12-31 13:30:00');

-- Add Invoices for Each Student

INSERT INTO Invoice (invName, cms, amount, status,invIssueDate)
VALUES
('Tuition Fee', 408160, 151700, 'Issued','2023-12-30'),
('Hostel Fee', 408160, 33500, 'Issued','2023-12-30'),
('Tuition Fee', 422791, 151700, 'Issued','2023-12-30'),
('Hostel Fee', 422791, 33500, 'Issued','2023-12-30');

