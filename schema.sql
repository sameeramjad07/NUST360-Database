drop database if exists nust360;
create database nust360;
use nust360;

-- Table schemas

create table if not exists User(
	uuid INT auto_increment NOT NULL,		-- PK
    `role` varchar(10) not null,
    fname varchar(30)  NOT NULL,
    mname varchar(30),
    lname varchar(30)  NOT NULL,
    DOB date NOT NULL,
    Username varchar(20),		-- creation at Trigger 
    `password` VARBINARY(255)  NOT NULL,
    profile_pic varchar(255)  NOT NULL,
    phone_number varchar(15) NOT NULL,
    email varchar(50) NOT NULL,
    emergency_contact varchar(15),
    gender varchar(10) NOT NULL,
    cnic varchar(15) NOT NULL,
    nationality varchar(20) NOT NULL,
    religion varchar(20) NOT NULL,
    marital_status varchar(10) NOT NULL,
    age INT NOT NULL,
    constraint uuid
    primary key(uuid)
);

create table if not exists Department (
	dept_id INT auto_increment NOT NULL,	-- PK
    dept_name varchar(50) NOT NULL,
    constraint dept_id
    primary key(dept_id)
);

create table if not exists Student(
	uuid INT NOT NULL,		-- FK
	cms INT auto_increment NOT NULL,	-- PK
    career varchar(30) NOT NULL,
    program varchar(30) NOT NULL,
    current_semester varchar(10) NOT NULL,
    cgpa decimal(4,2),		-- Calculated using Result
    inprogress_courses INT,	-- Calculated from enrols
    inprogress_credits INT,	-- Calculated from enrols
    batch varchar(15) NOT NULL,
    dept_id INT NOT NULL,		-- FK
    constraint cms
    primary key(cms),
    constraint studentUuid
    foreign key(uuid) references User(uuid),
    constraint studentDept_id
    foreign key(dept_id) references Department(dept_id)
);

create table if not exists Faculty(
	uuid INT NOT NULL,		-- FK
    emp_id INT auto_increment NOT NULL,		-- PK
    designation varchar(50) NOT NULL,
    salary INT NOT NULL,
    starting_year year NOT NULL,
    dept_id INT NOT NULL,		-- FK
    constraint emp_id
    primary key(emp_id),
    constraint facultyUuid
    foreign key(uuid) references User(uuid),
    constraint facultyDept_id
    foreign key(dept_id) references Department(dept_id)
);

create table if not exists Admin(
	uuid INT NOT NULL,		-- FK
    adminCode INT auto_increment NOT NULL,		-- PK
    constraint adminCode
    primary key(adminCode),
    constraint adminUuid
    foreign key(uuid) references User(uuid)
);

create table if not exists Course(
	cid INT auto_increment NOT NULL,		-- PK
    cname varchar(100) NOT NULL,
    credit_hours INT NOT NULL,
    constraint cid
    primary key(cid)
);

create table if not exists attendance(
	cms INT NOT NULL,		-- FK
    cid INT NOT NULL,		-- FK
	`date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    `status` varchar(15) NOT NULL,
    constraint attendanceCms
    foreign key(cms) references Student(cms),
    constraint attendanceCid
    foreign key(cid) references Course(cid)
);
create table if not exists enrols(
	cms INT NOT NULL,		-- FK
    cid INT NOT NULL,		-- FK
    term varchar(10) NOT NULL,
    `year` year NOT NULL,
    grade varchar(5),	-- Calculated using Result table
    attendancePercentAge decimal(8,2),	-- Calculated using attendance table
    constraint enrolsCms
    foreign key(cms) references Student(cms),
    constraint enrolsCid
    foreign key(cid) references Course(cid)
);

create table if not exists teaches(
	emp_id INT NOT NULL,		-- FK
    cid INT NOT NULL,			-- FK
    term varchar(10) NOT NULL,
    `year` year NOT NULL,
    constraint teachesEmp_id
    foreign key(emp_id) references Faculty(emp_id),
    constraint teachesCid
    foreign key(cid) references Course(cid)
);

create table if not exists examType(
		exam_type INT NOT NULL,		-- PK
        exam_name varchar(50) NOT NULL,
        weightage decimal(4,2) NOT NULL,
        constraint exam_type
        primary key(exam_type)
);

create table if not exists Result(
	cms INT NOT NULL,		-- FK
    cid INT NOT NULL,		-- FK
	exam_type INT NOT NULL,	-- FK
	total_marks INT NOT NULL,
	marks_obtained decimal(4,2) NOT NULL,
	class_avg decimal(4,2),	-- calculated by getting records of each student for a same ""course and examType""
	`dateTime` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	constraint resultCms
    foreign key(cms) references Student(cms),
    constraint resultCid
    foreign key(cid) references Course(cid),
    constraint resultExam_type
    foreign key(exam_type) references examType(exam_type)
);
create table if not exists Invoice(
	invID INT auto_increment NOT NULl,	-- PK
    invName varchar(50) NOT NULL,
    cms INT NOT NULL,		-- FK
    invIssueDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    invDueDate TIMESTAMP ,
    amount INT NOT NULL,
    `status` varchar(10) NOT NULL,
    constraint invID
    primary key(invID),
    constraint invoiceCms
    foreign key(cms) references Student(cms)
);

CREATE TABLE IF NOT EXISTS Notifications (
    notificationID INT AUTO_INCREMENT NOT NULL,
    senderID INT NOT NULL, -- FK to User(uuid)
    receiverID INT NOT NULL, -- FK to User(uuid)
    message TEXT NOT NULL,
    isRead BOOLEAN NOT NULL DEFAULT 0, -- 0 for unread, 1 for read
    notificationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    constraint notificationID
    primary key(notificationID),
    constraint fk_sender
    FOREIGN KEY (senderID) REFERENCES User(uuid),
    constraint fk_receiver
    FOREIGN KEY (receiverID) REFERENCES User(uuid)
);


create table if not exists Logs (
	logID INT,		-- PK
    uuid INT NOT NULL,	-- FK
    `role` varchar(30) NOT NULL,
    `action` varchar(255) NOT NULL,
    `timeStamp` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    constraint logID
    primary key(logID),
    constraint logsUuid 
    foreign key(uuid) REFERENCES User(uuid)
);