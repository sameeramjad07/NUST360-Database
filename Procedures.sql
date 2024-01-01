-- Procedure to update attendance percentage in enrols table
DELIMITER //

CREATE PROCEDURE updateAttendanceInEnrols()
BEGIN
UPDATE enrols e
INNER JOIN (
    SELECT a.cms, a.cid,
           SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) AS present_count,
           COUNT(*) AS total_count,
           (SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS attendance_percentage
    FROM attendance a
    GROUP BY a.cms, a.cid
) a ON e.cms = a.cms AND e.cid = a.cid
SET e.attendancePercentAge = a.attendance_percentage; 
END;
//
DELIMITER ;

-- Procedure to update class average of each exam type of each course in Results table

DELIMITER //

CREATE PROCEDURE updateclassAverageInResults()
BEGIN
UPDATE Result r
JOIN (
    SELECT cid, exam_type, AVG(marks_obtained) AS avg_marks
    FROM Result
    GROUP BY cid, exam_type
) sub ON r.cid = sub.cid AND r.exam_type = sub.exam_type
SET r.class_avg = sub.avg_marks; 
END;
//
DELIMITER ;


-- Procedure to calculate grades for all students

DELIMITER //

CREATE PROCEDURE CalculateGradesForAllStudents()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE cms_val INT;
    DECLARE cid_val INT;
    DECLARE grade_val CHAR(1); -- Assuming the grade column is of type CHAR(1)
    DECLARE cur CURSOR FOR
        SELECT DISTINCT cms, cid FROM Result;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO cms_val, cid_val;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Calculate grade based on the final exam marks compared to averages
        SELECT 
            CASE
                WHEN (final_exam_marks - Average_Marks) > (Average_Marks * 0.10) THEN 'A'
                WHEN (final_exam_marks - Average_Marks) <= (Average_Marks * 0.10) THEN 'B'
                WHEN (final_exam_marks - Average_Marks) < 0 THEN 'C'
                ELSE 'F'
            END INTO grade_val
        FROM (
            SELECT
                AVG(CASE WHEN exam_type = 4 THEN marks_obtained ELSE 0 END) AS final_exam_marks,
                AVG(CASE WHEN exam_type IN (1, 2, 3, 4) THEN marks_obtained ELSE 0 END) AS Average_Marks
            FROM Result
            WHERE cms = cms_val AND cid = cid_val
        ) AS FinalExamComparison;

        -- Update enrols table with the calculated grade
        UPDATE enrols
        SET grade = grade_val
        WHERE cms = cms_val AND cid = cid_val;

    END LOOP;
    CLOSE cur;
END;
//
DELIMITER ;


-- Stored Procedure to Calculate GPA for a Student
DELIMITER //

CREATE PROCEDURE CalculateAndUpdateCGPA()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE cms_val INT;
    DECLARE cgpa_val DECIMAL(5, 2);

    DECLARE cur CURSOR FOR SELECT DISTINCT cms FROM enrols;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO cms_val;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SET cgpa_val = (
            SELECT ROUND(SUM(cgpa_points) / SUM(total_credit_hours), 2) AS cgpa
            FROM (
                SELECT
                    e.cms,
                    SUM(
                        CASE
                            WHEN e.grade = 'A' THEN 4.0 * c.credit_hours
                            WHEN e.grade = 'B' THEN 3.0 * c.credit_hours
                            WHEN e.grade = 'C' THEN 2.0 * c.credit_hours
                            WHEN e.grade = 'D' THEN 1.0 * c.credit_hours
                            ELSE 0.0
                        END
				) AS cgpa_points,
                    SUM(c.credit_hours) AS total_credit_hours
                FROM enrols e
                JOIN Course c ON e.cid = c.cid
                WHERE e.grade IN ('A', 'B', 'C', 'D') AND e.cms = cms_val
                GROUP BY e.cms
            ) AS grades
        );

        -- Update CGPA in Student table for the respective student
        UPDATE Student SET cgpa = cgpa_val WHERE cms = cms_val;

    END LOOP;
    CLOSE cur;
END //

DELIMITER ;

-- Procedure to insert encrypted password
DELIMITER //

CREATE PROCEDURE InsertUserWithEncryptedPassword(
    IN p_role VARCHAR(10),
    IN p_fname VARCHAR(30),
    IN p_lname VARCHAR(30),
    IN p_DOB DATE,
    IN p_password VARBINARY(255),
    IN p_profile_pic VARCHAR(255),
    IN p_phone_number VARCHAR(15),
    IN p_email VARCHAR(50),
    IN p_gender VARCHAR(10),
    IN p_cnic VARCHAR(15),
    IN p_nationality VARCHAR(20),
    IN p_religion VARCHAR(20),
    IN p_marital_status VARCHAR(10),
    IN p_age INT
)
BEGIN
    -- Encrypt the password
    DECLARE encrypted_password VARBINARY(255);
    SET encrypted_password = AES_ENCRYPT(p_password, 'secret_key');

    -- Insert user with encrypted password
    INSERT INTO User (
        `role`, fname, lname, DOB, `password`, profile_pic,
        phone_number, email, gender, cnic, nationality,
        religion, marital_status, age
    ) VALUES (
        p_role, p_fname, p_lname, p_DOB, encrypted_password,
        p_profile_pic, p_phone_number, p_email, p_gender,
        p_cnic, p_nationality, p_religion, p_marital_status, p_age
    );
END //

-- Procedure to get decrypted password
-- Procedure to get decrypted password
CREATE PROCEDURE GetUserPassword(
    IN p_uuid INT
)
BEGIN
    DECLARE decrypted_password VARBINARY(255);

    -- Get decrypted password
    SELECT AES_DECRYPT(`password`, 'secret_key') INTO decrypted_password
    FROM User
    WHERE uuid = p_uuid;

    -- Return the result
    SELECT CAST(decrypted_password AS CHAR) AS decrypted_password;
END;
