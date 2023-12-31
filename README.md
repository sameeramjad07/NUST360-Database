# NUST360: NUST information management and attendance tracking engine

## **Brief Overview of the Project:**

The NUST360 project is a comprehensive educational management system designed to streamline and enhance the overall academic experience within the National University of Sciences and Technology (NUST). This project encompasses a robust database schema that efficiently manages user roles, academic departments, courses, attendance, exams, and more.

The project's central focus is on providing a centralized platform for students, faculty, and administrators to seamlessly interact with academic data, fostering an environment conducive to efficient information flow and collaboration.

## **Project Goals and Objectives:**

1. **Optimized Data Management:** Implement a well-structured database schema to manage diverse academic data efficiently.

2. **User-Friendly Interface:** Develop an intuitive interface for students, faculty, and administrators, ensuring a smooth and user-friendly experience.

3. **Enhanced Academic Processes:** Streamline academic processes, including course enrollment, attendance tracking, and result management.

4. **Real-time Information:** Provide real-time access to academic information, enabling stakeholders to make informed decisions promptly.

5. **Performance Optimization:** Implement measures to optimize database performance for quick and responsive data retrieval.

6. **Security Measures:** Prioritize the security of sensitive information by implementing robust access controls and data encryption.

7. **Automation of Workflows:** Incorporate triggers and stored procedures to automate routine tasks, reducing manual workload and minimizing errors.

8. **Future Scalability:** Design the system with future enhancements in mind, allowing for seamless integration of new features and functionalities.

## 1. **Schema Walkthrough:**

### 1. User Table
- **Primary Key:** `uuid` (Auto-incremented User ID)
- **Attributes:**
  - `role`: Role of the user (student, faculty, admin)
  - `fname`, `mname`, `lname`: First, middle, and last name
  - `DOB`: Date of birth
  - `Username`: User's username
  - `password`: User's password
  - `profile_pic`: URL to the user's profile picture
  - `phone_number`, `email`: Contact information
  - `emergency_contact`: Emergency contact number
  - `gender`, `cnic`, `nationality`, `religion`, `marital_status`: Personal information
  - `age`: Age of the user

### 2. Department Table
- **Primary Key:** `dept_id` (Auto-incremented Department ID)
- **Attributes:**
  - `dept_name`: Name of the department

### 3. Student Table
- **Primary Key:** `cms` (Auto-incremented Student ID)
- **Foreign Key:** `uuid` references User(uuid)
- **Foreign Key:** `dept_id` references Department(dept_id)
- **Attributes:**
  - `career`, `program`, `current_semester`, `cgpa`: Academic details
  - `inprogress_courses`, `inprogress_credits`: Calculated from enrols table
  - `batch`: Batch of the student

### 4. Faculty Table
- **Primary Key:** `emp_id` (Auto-incremented Employee ID)
- **Foreign Key:** `uuid` references User(uuid)
- **Foreign Key:** `dept_id` references Department(dept_id)
- **Attributes:**
  - `designation`, `salary`, `starting_year`: Employment details

### 5. Admin Table
- **Primary Key:** `adminCode` (Auto-incremented Admin Code)
- **Foreign Key:** `uuid` references User(uuid)

### 6. Course Table
- **Primary Key:** `cid` (Auto-incremented Course ID)
- **Attributes:**
  - `cname`: Course name
  - `credit_hours`: Credit hours for the course

### 7. Attendance Table
- **Foreign Key:** `cms` references Student(cms)
- **Foreign Key:** `cid` references Course(cid)
- **Attributes:**
  - `date`: Date of attendance
  - `status`: Attendance status (Present/Absent)

### 8. Enrols Table
- **Foreign Key:** `cms` references Student(cms)
- **Foreign Key:** `cid` references Course(cid)
- **Attributes:**
  - `term`, `year`: Academic term and year
  - `grade`: Calculated using Result table
  - `attendancePercentAge`: Calculated using attendance table

### 9. Teaches Table
- **Foreign Key:** `emp_id` references Faculty(emp_id)
- **Foreign Key:** `cid` references Course(cid)
- **Attributes:**
  - `term`, `year`: Academic term and year

### 10. ExamType Table
- **Primary Key:** `exam_type` (Exam Type ID)
- **Attributes:**
  - `exam_name`: Name of the exam
  - `weightage`: Weightage in the grade calculation

### 11. Result Table
- **Foreign Key:** `cms` references Student(cms)
- **Foreign Key:** `cid` references Course(cid)
- **Foreign Key:** `exam_type` references ExamType(exam_type)
- **Attributes:**
  - `total_marks`: Total marks in the exam
  - `marks_obtained`: Marks obtained by the student
  - `class_avg`: Calculated for each course and exam type
  - `dateTime`: Date and time of the result

### 12. Invoice Table
- **Primary Key:** `invID` (Auto-incremented Invoice ID)
- **Foreign Key:** `cms` references Student(cms)
- **Attributes:**
  - `invName`: Invoice name
  - `invIssueDate`: Date of issuing the invoice
  - `invDueDate`: Due date of the invoice
  - `amount`: Amount in the invoice
  - `status`: Invoice status (issued, paid, overdue)

### 13. Notifications Table
- **Primary Key:** `notificationID` (Auto-incremented Notification ID)
- **Foreign Key:** `senderID` references User(uuid)
- **Foreign Key:** `receiverID` references User(uuid)
- **Attributes:**
  - `message`: Notification message
  - `isRead`: Read status (0 for unread, 1 for read)
  - `notificationDate`: Date and time of the notification

### 14. Logs Table
- **Primary Key:** `logID` (Log ID)
- **Foreign Key:** `uuid` references User(uuid)
- **Attributes:**
  - `role`: Role of the user
  - `action`: Log action
  - `timeStamp`: Timestamp of the log entry

## 2. **Business Rules:**


## 3. **Sample Queries:**

**Below are some sample queries for your database schema. These queries cover various operations such as retrieving information, filtering data, and aggregating results.**

### 1. **Retrieve Student Information:**
   - Retrieve information about a specific student and their enrolled courses.

   ```sql
   SELECT U.fname, U.lname, S.program, S.batch, C.cname
   FROM User U
   JOIN Student S ON U.uuid = S.uuid
   JOIN enrols E ON S.cms = E.cms
   JOIN Course C ON E.cid = C.cid
   WHERE U.uuid = [Student_UUID];
   ```

### 2. **Retrieve Faculty Information:**
   - Retrieve information about a specific faculty member and the courses they teach.

   ```sql
   SELECT U.fname, U.lname, F.designation, C.cname
   FROM User U
   JOIN Faculty F ON U.uuid = F.uuid
   JOIN teaches T ON F.emp_id = T.emp_id
   JOIN Course C ON T.cid = C.cid
   WHERE U.uuid = [Faculty_UUID];
   ```

### 3. **Calculate Student GPA:**
   - Calculate the GPA of a specific student based on their enrolled courses and grades.

   ```sql
   SELECT U.fname, U.lname, S.program, S.batch, AVG(C.credit_hours * CASE E.grade
     WHEN 'A' THEN 4.0
     WHEN 'B' THEN 3.0
     WHEN 'C' THEN 2.0
     WHEN 'D' THEN 1.0
     ELSE 0.0 END) AS GPA
   FROM User U
   JOIN Student S ON U.uuid = S.uuid
   JOIN enrols E ON S.cms = E.cms
   JOIN Course C ON E.cid = C.cid
   WHERE U.uuid = [Student_UUID]
   GROUP BY U.fname, U.lname, S.program, S.batch;
   ```

### 4. **Retrieve Notifications:**
   - Retrieve unread notifications for a specific user.

   ```sql
   SELECT N.notificationID, U.fname, U.lname, N.message, N.notificationDate
   FROM Notifications N
   JOIN User U ON N.senderID = U.uuid
   WHERE N.receiverID = [User_UUID] AND N.isRead = 0
   ORDER BY N.notificationDate DESC;
   ```

### 5. **Update Student Grade:**
   - Update the grade of a student for a specific course.

   ```sql
   UPDATE enrols
   SET grade = 'A'
   WHERE cms = [Student_CMS] AND cid = [Course_ID] AND term = 'Fall' AND year = 2023;
   ```

### 6. **Calculate Average Class Marks:**
   - Calculate the average marks for a specific exam type in a course.

   ```sql
   SELECT cid, exam_type, AVG(marks_obtained) AS avg_marks
   FROM Result
   WHERE exam_type = [Exam_Type_ID]
   GROUP BY cid, exam_type;
   ```

### 7. **Retrieve Log Entries:**
   - Retrieve log entries for a specific user.

   ```sql
   SELECT L.logID, U.fname, U.lname, L.action, L.timeStamp
   FROM Logs L
   JOIN User U ON L.uuid = U.uuid
   WHERE L.uuid = [User_UUID]
   ORDER BY L.timeStamp DESC;
   ```

### 8. **Retrieve Overdue Invoices:**
   - Retrieve overdue invoices for a specific student.

   ```sql
   SELECT I.invID, U.fname, U.lname, I.invName, I.amount, I.invDueDate
   FROM Invoice I
   JOIN User U ON I.cms = U.uuid
   WHERE I.cms = [Student_UUID] AND I.status = 'overdue'
   ORDER BY I.invDueDate DESC;
   ```

## 4. **Triggers:**

#### 1. `set_username_trigger`:
   - **Purpose:** Automatically generates a username for a new user if not provided.
   - **Explanation:** This trigger fires before inserting a new record into the `User` table. If the `Username` field is NULL or empty, it concatenates the lowercase first name, last name, and UUID to create a unique username.

#### 2. `set_due_date_trigger`:
   - **Purpose:** Sets the due date of an invoice 7 days in advance based on the issue date.
   - **Explanation:** This trigger is executed before inserting a new record into the `Invoice` table. It calculates the due date by adding 7 days to the issue date and sets it for the new record.

#### 3. `update_inprogress_details_trigger`:
   - **Purpose:** Updates in-progress credit hours and courses in the `Student` table when a new enrollment occurs.
   - **Explanation:** Triggered after inserting a new record into the `enrols` table. It updates the `inprogress_courses` and `inprogress_credits` fields in the `Student` table for the student (CMS) associated with the new enrollment. It counts the distinct courses and calculates the sum of credit hours for that student.

These triggers contribute to maintaining data consistency and automate the population of certain fields, making your database more user-friendly and reducing the likelihood of manual errors.

Ensure that these triggers are tested thoroughly under different scenarios to confirm their reliability and correctness in various use cases. Also, consider adding error handling or logging mechanisms within triggers to capture unexpected scenarios and facilitate debugging if needed.

## 5. **Stored Procedures:**
Below is an overview and explanation of each stored procedure:

#### 1. `updateAttendanceInEnrols()`:
   - **Purpose:** Updates the `attendancePercentAge` in the `enrols` table based on attendance records.
   - **Explanation:** This procedure uses an UPDATE statement with a JOIN on a subquery that calculates attendance percentages for each student in each course. It then sets the calculated percentage in the `enrols` table.

#### 2. `updateclassAverageInResults()`:
   - **Purpose:** Updates the `class_avg` in the `Result` table based on exam results.
   - **Explanation:** Similar to the first procedure, this one updates the `class_avg` in the `Result` table by joining with a subquery that calculates the average marks for each course and exam type.

#### 3. `CalculateGradesForAllStudents()`:
   - **Purpose:** Calculates grades for all students based on final exam marks and updates the `enrols` table.
   - **Explanation:** This procedure uses a cursor to iterate over distinct combinations of CMS and CID in the `Result` table. It calculates grades based on final exam marks and updates the `enrols` table accordingly.

#### 4. `CalculateAndUpdateCGPA()`:
   - **Purpose:** Calculates and updates the CGPA for each student.
   - **Explanation:** This procedure iterates over distinct CMS values in the `enrols` table, calculating CGPA by summing CGPA points and dividing by total credit hours. It then updates the `Student` table with the calculated CGPA.

#### 5. `InsertUserWithEncryptedPassword()`:
   - **Purpose:** Inserts a new user with an encrypted password.
   - **Explanation:** This procedure encrypts the provided password using AES_ENCRYPT and inserts a new user into the `User` table with the encrypted password.

#### 6. `GetUserPassword()`:
   - **Purpose:** Retrieves the decrypted password for a given user.
   - **Explanation:** This procedure retrieves the encrypted password from the `User` table, decrypts it using AES_DECRYPT, and returns the result.

## 6. **Calculated Fields:**
   - Clearly define fields that are calculated and explain the logic behind their calculations.

## 7. **Data Population Scripts:**
   - Some Sample data is provided in the `data.sql` file

## 8. **Views:**
   - Below are some examples of views that could be used when you want to add abstraction in your project:

#### 1. **StudentView:**
   - **Purpose:** Provide a view for students with relevant information about their courses, grades, and invoices.

```sql
CREATE VIEW StudentView AS
SELECT
    S.cms,
    S.fname,
    S.lname,
    C.cname AS course_name,
    E.grade,
    E.attendancePercentAge,
    I.invName,
    I.amount,
    I.invDueDate
FROM
    Student S
JOIN enrols E ON S.cms = E.cms
JOIN Course C ON E.cid = C.cid
LEFT JOIN Invoice I ON S.cms = I.cms;
```

#### 2. **FacultyView:**
   - **Purpose:** Provide a view for faculty members with information about courses they teach and student grades.

```sql
CREATE VIEW FacultyView AS
SELECT
    F.emp_id,
    F.fname,
    F.lname,
    C.cname AS course_name,
    E.grade,
    E.attendancePercentAge
FROM
    Faculty F
JOIN teaches T ON F.emp_id = T.emp_id
JOIN Course C ON T.cid = C.cid
JOIN enrols E ON T.cid = E.cid;
```

#### 3. **AdminView:**
   - **Purpose:** Provide a view for administrators with information about all users, courses, and system logs.

```sql
CREATE VIEW AdminView AS
SELECT
    U.uuid,
    U.fname,
    U.lname,
    U.`role`,
    D.dept_name,
    C.cname AS course_name,
    L.action,
    L.timeStamp
FROM
    User U
LEFT JOIN Student S ON U.uuid = S.uuid
LEFT JOIN Faculty F ON U.uuid = F.uuid
LEFT JOIN Admin A ON U.uuid = A.uuid
LEFT JOIN Department D ON S.dept_id = D.dept_id OR F.dept_id = D.dept_id
LEFT JOIN teaches T ON F.emp_id = T.emp_id
LEFT JOIN Course C ON T.cid = C.cid
LEFT JOIN Logs L ON U.uuid = L.uuid;
```

#### 4. **StudentCourseView:**
   - **Purpose:** Provide a view for students with detailed information about their enrolled courses.

```sql
CREATE VIEW StudentCourseView AS
SELECT
    S.cms,
    S.fname,
    S.lname,
    C.cname AS course_name,
    E.grade,
    E.attendancePercentAge,
    R.total_marks,
    R.marks_obtained,
    R.class_avg
FROM
    Student S
JOIN enrols E ON S.cms = E.cms
JOIN Course C ON E.cid = C.cid
LEFT JOIN Result R ON S.cms = R.cms AND E.cid = R.cid;
```


## 9. **Constraints:**
   - List and explain any constraints applied to ensure data integrity.

## 10. **Backup and Recovery Procedures:**
   - Below is the  `.bat` file code to create a backup and recovery feature along with explanations for the changes you need to make according to your machine and database:

```batch
@echo off

rem Set the path to the MySQL server bin folder
cd "C:\Program Files\MySQL\MySQL Server 8.0\bin"

rem Set the credentials to connect to the MySQL server
set mysql_user=your_username
set mysql_password=your_password

rem Set the backup folder path
set backup_path=F:\New Folder\MySQL Backup

rem Set the backup name with a timestamp
set timestamp=%date:~-4%_%date:~3,2%_%date:~0,2%_%time:~0,2%_%time:~3,2%_%time:~6,2%
set backup_name=my-all-databases_%timestamp%

rem Set the MySQL dump command
set mysqldump_command=mysqldump --user=%mysql_user% --password=%mysql_password% --all-databases --routines --events --result-file="%backup_path%\%backup_name%.sql"

rem Backup creation
%mysqldump_command%
if %ERRORLEVEL% neq 0 (
    (echo Backup failed: error during dump creation) >> "%backup_path%\mysql_backup_log.txt"
) else (echo Backup successful) >> "%backup_path%\mysql_backup_log.txt"

pause
```

Explanation of Changes you need to make while creating the `.bat` file:
1. **Set Your MySQL Credentials:**
   - Modify the `mysql_user` and `mysql_password` variables with your MySQL username and password.

2. **Set Backup Folder Path:**
   - Modify the `backup_path` variable to the desired path where you want to store your backups.

3. **Timestamp Backup Name:**
   - Added a timestamp to the `backup_name` variable to make each backup file unique. This ensures that each backup has a distinct name.

4. **MySQL Dump Command:**
   - Created a variable `mysqldump_command` to store the MySQL dump command. This makes it easier to modify the command if needed.

5. **Backup Creation:**
   - Used the `%mysqldump_command%` variable to execute the MySQL dump command.
   - Checked the `%ERRORLEVEL%` after the backup creation and logged the result in the `mysql_backup_log.txt` file.

### Procedure for Scheduled Backups using Task Scheduler:

1. **Create a Batch File:**
   - Save the modified bat file code into a `.bat` file, e.g., `backup_script.bat`.

2. **Open Task Scheduler:**
   - Open the Windows Task Scheduler.

3. **Create a New Task:**
   - Click on "Create Basic Task" or "Create Task" in the Actions pane.

4. **Set Task Details:**
   - Provide a name and description for your task.
   - Choose the trigger type (daily, weekly, or monthly) and set the appropriate settings.

5. **Set Action:**
   - Choose "Start a Program" as the action.
   - Browse and select the `backup_script.bat` file.

6. **Configure Conditions (Optional):**
   - Set any additional conditions as per your requirements.

7. **Review and Finish:**
   - Review your settings and click "Finish" to create the task.

By following these steps, the Task Scheduler will execute your backup script at the specified intervals. Adjust the task settings or modify the script as needed. You can also create separate tasks for daily, weekly, or monthly backups.

## 11. **Future Development Plans:**
   - Mention any planned enhancements or features for the database.
   - (working on it)

## 12. **Acknowledgments:**
   - Give credit to contributors or sources of inspiration for your database design.
   - (working on it)

## 13. **References:**
   - Include references to external resources, libraries, or frameworks used in the project.
   - (working on it)

## 14. **Appendices:**
   - Attach any supplementary materials, such as additional diagrams or detailed explanations.
   - (working on it)

