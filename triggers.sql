-- for the user here is a trigger function     
-- Create a trigger to set Username for new records
DELIMITER //
CREATE TRIGGER set_username_trigger
BEFORE INSERT ON User
FOR EACH ROW
BEGIN
    IF NEW.Username IS NULL OR NEW.Username = '' THEN
        SET NEW.Username = CONCAT(lower(NEW.fname), NEW.lname, '_', NEW.uuid);
    END IF;
END;
//
DELIMITER ;


-- for setting invoice due date mene trigger function bnaya h    
-- use this code for invoice data insertion 
-- Created a trigger to set invDueDate 7 days in advance based on invIssueDate


DELIMITER //
CREATE TRIGGER set_due_date_trigger
BEFORE INSERT ON Invoice
FOR EACH ROW
BEGIN
    SET NEW.invDueDate = DATE_ADD(NEW.invIssueDate, INTERVAL 7 DAY);
END;
//
DELIMITER ;


-- trigger to update inprogress credit hours and courses in Student Table

DELIMITER //
CREATE TRIGGER update_inprogress_details_trigger AFTER INSERT ON enrols
FOR EACH ROW
BEGIN
    UPDATE Student s
    SET
        inprogress_courses = (
            SELECT COUNT(DISTINCT e.cid)
            FROM enrols e
            WHERE e.cms = NEW.cms -- Match by cms from the newly inserted row
        ),
        inprogress_credits = (
            SELECT SUM(c.credit_hours)
            FROM enrols e
            JOIN Course c ON e.cid = c.cid
            WHERE e.cms = NEW.cms -- Match by cms from the newly inserted row
        )
    WHERE s.cms = NEW.cms; -- Match by cms from the newly inserted row
END;
//
DELIMITER ;




-- trigger that automatically updates the attendancePercentAge in the enrols table 
-- when new records are inserted into the attendance table for each cms and cid combination

-- DELIMITER //
-- CREATE TRIGGER update_attendance_trigger AFTER INSERT ON attendance
-- FOR EACH ROW
-- BEGIN
--     UPDATE enrols e
--     INNER JOIN (
--         SELECT a.cms, a.cid,
--                SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) AS present_count,
--                COUNT(*) AS total_count,
--                (SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS attendance_percentage
--         FROM attendance a
--         WHERE a.cms = NEW.cms AND a.cid = NEW.cid
--         GROUP BY a.cms, a.cid
--     ) a ON e.cms = a.cms AND e.cid = a.cid
--     SET e.attendancePercentAge = a.attendance_percentage;
-- END;
-- //
-- DELIMITER ;


-- trigger to update class average in each exam type of each course in Results table
-- for all pre-exisiting records and for future records

-- DELIMITER //

-- CREATE TRIGGER update_class_average_trigger AFTER INSERT ON Result
-- FOR EACH ROW
-- BEGIN
--     DECLARE avg_marks DECIMAL(10,2);

--     -- Calculate the class average for the specific cid and exam_type
--     SELECT AVG(marks_obtained)
--     INTO avg_marks
--     FROM Result
--     WHERE cid = NEW.cid AND exam_type = NEW.exam_type;

--     -- Update the class_avg for the inserted record
--     UPDATE Result
--     SET class_avg = avg_marks
--     WHERE cid = NEW.cid AND exam_type = NEW.exam_type AND id = NEW.id; -- Assuming 'id' as a unique identifier
-- END;
-- //
-- DELIMITER ;

