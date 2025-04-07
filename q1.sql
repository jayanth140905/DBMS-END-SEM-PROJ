-- 1. Create Database
CREATE DATABASE IF NOT EXISTS student_database;
USE student_database;

-- 2. Create Department Table
CREATE TABLE Department (
    department_id VARCHAR(20) PRIMARY KEY,
    department_name VARCHAR(100)
);

-- 3. Create Department Heads Table
CREATE TABLE Department_Heads (
    department_head_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    department_id VARCHAR(20),
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- 4. Create Courses Table
CREATE TABLE Courses (
    course_id VARCHAR(20) PRIMARY KEY,
    course_name VARCHAR(100),
    department_id VARCHAR(20),
    total_credits Decimal(3,1),
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- 5. Create Instructors Table
CREATE TABLE Instructors (
    instructor_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100),
    gender VARCHAR(10),
    contact_number VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    department_id VARCHAR(20),
    course_id VARCHAR(20),  
    joining_date DATE,
    FOREIGN KEY (department_id) REFERENCES Department(department_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE SET NULL  
);

-- 6. Create Boys Hostel Table
CREATE TABLE Boys_Hostel (
    hostel_id VARCHAR(20) PRIMARY KEY,
    hostel_name VARCHAR(100),
    capacity INT,
    available_capacity INT
);

-- 7. Create Girls Hostel Table
CREATE TABLE Girls_Hostel (
    hostel_id VARCHAR(20) PRIMARY KEY,
    hostel_name VARCHAR(100),
    capacity INT,
    available_capacity INT
);

-- 8. Create Wardens Table
CREATE TABLE Hostel_Wardens (
    warden_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100),
    gender VARCHAR(10),
    contact_number VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    boys_hostel_id VARCHAR(20) NULL,
    girls_hostel_id VARCHAR(20) NULL,
    is_head_warden BOOLEAN,
    FOREIGN KEY (boys_hostel_id) REFERENCES Boys_Hostel(hostel_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (girls_hostel_id) REFERENCES Girls_Hostel(hostel_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 9. Create Students Table
CREATE TABLE Students (
    student_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100),
    gender VARCHAR(10),
    dob DATE,
    contact_number VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    hostler_or_day ENUM('Hostler', 'Day Scholar'),
    avails_bus BOOLEAN,
    department_id VARCHAR(20),
    boys_hostel_id VARCHAR(20) NULL,
    girls_hostel_id VARCHAR(20) NULL,
    FOREIGN KEY (department_id) REFERENCES Department(department_id),
    FOREIGN KEY (boys_hostel_id) REFERENCES Boys_Hostel(hostel_id) ON DELETE CASCADE,
    FOREIGN KEY (girls_hostel_id) REFERENCES Girls_Hostel(hostel_id) ON DELETE CASCADE
);

-- 10. Create Office Staff Table
CREATE TABLE Office_Staff (
    staff_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100),
    contact_number VARCHAR(15),
    email VARCHAR(100) UNIQUE
);

-- 11. Create Salary Table
CREATE TABLE Salary (
    salary_id VARCHAR(20) PRIMARY KEY,
    salary_amount DECIMAL(10, 2)
);

-- 12. Create Users Table
CREATE TABLE Users (
    user_id VARCHAR(20) PRIMARY KEY,
    password VARCHAR(100),
    role ENUM('Admin', 'Student', 'Instructor', 'Hostel Warden', 'Office Staff', 'Department Head'),
    student_id VARCHAR(20),
    staff_id VARCHAR(20),
    warden_id VARCHAR(20),
    department_head_id VARCHAR(20),
    instructor_id VARCHAR(20),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (staff_id) REFERENCES Office_Staff(staff_id),
    FOREIGN KEY (warden_id) REFERENCES Hostel_Wardens(warden_id),
    FOREIGN KEY (department_head_id) REFERENCES Department_Heads(department_head_id),
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id)
);

-- 13. Create Sports Table
CREATE TABLE Sports (
    student_id VARCHAR(20),
    sport_name VARCHAR(100),
    team_position VARCHAR(50),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

-- 14. Create Grades Table
CREATE TABLE Grades (
    grade_id VARCHAR(20) PRIMARY KEY,
    student_id VARCHAR(20),
    course_id VARCHAR(20),
    total_course_credits decimal(3,1),
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- 15. Create Pass Requests Table
CREATE TABLE Pass_Requests (
    pass_id VARCHAR(20) PRIMARY KEY,
    student_id VARCHAR(20),
    pass_type ENUM('Home', 'City'),
    start_date DATE,
    end_date DATE,
    approval_status ENUM('Pending', 'Approved', 'Rejected'),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

-- 16. Create Hostel Payments Table
CREATE TABLE Hostel_Payments (
    payment_id VARCHAR(20) PRIMARY KEY,
    student_id VARCHAR(20),
    hostel_fee_paid DECIMAL(10, 2),
    mess_fee_paid DECIMAL(10, 2),
    payment_date DATE,
    payment_due_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

-- 17. Create Education Payments Table
CREATE TABLE Education_Payments (
    payment_id VARCHAR(20) PRIMARY KEY,
    student_id VARCHAR(20),
    tuition_fee_paid DECIMAL(10, 2),
    payment_date DATE,
    payment_due_date DATE,
    payment_type ENUM('Tuition'),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

-- 18. Create Day Scholar Payments Table
CREATE TABLE Day_Scholar_Payments (
    payment_id VARCHAR(20) PRIMARY KEY,
    student_id VARCHAR(20),
    bus_fee_paid DECIMAL(10, 2),
    payment_date DATE,
    payment_due_date DATE,
    payment_type ENUM('Bus'),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);


-- 18. Create Hostel Allocations Table
CREATE TABLE Hostel_Allocations (
    allocation_id VARCHAR(20) PRIMARY KEY,
    student_id VARCHAR(20),
    boys_hostel_id VARCHAR(20) NULL,
    girls_hostel_id VARCHAR(20) NULL,
    room_number VARCHAR(10),
    allocation_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (boys_hostel_id) REFERENCES Boys_Hostel(hostel_id) ON DELETE CASCADE,
    FOREIGN KEY (girls_hostel_id) REFERENCES Girls_Hostel(hostel_id) ON DELETE CASCADE
);


ALTER TABLE Department_Heads
ADD COLUMN salary_id VARCHAR(20),
ADD FOREIGN KEY (salary_id) REFERENCES Salary(salary_id);

ALTER TABLE Instructors
ADD COLUMN salary_id VARCHAR(20),
ADD FOREIGN KEY (salary_id) REFERENCES Salary(salary_id);

ALTER TABLE Office_Staff
ADD COLUMN salary_id VARCHAR(20),
ADD FOREIGN KEY (salary_id) REFERENCES Salary(salary_id);


ALTER TABLE Hostel_Wardens
ADD COLUMN salary_id VARCHAR(20),
ADD FOREIGN KEY (salary_id) REFERENCES Salary(salary_id);

INSERT INTO Department (department_id, department_name) VALUES
('CSE', 'Computer Science and Engineering'),
('ECE', 'Electronics and Communication Engineering'),
('EEE', 'Electrical and Electronics Engineering'),
('MECH', 'Mechanical Engineering'),
('CIVIL', 'Civil Engineering');

INSERT INTO Salary (salary_id, salary_amount) VALUES
-- Office Staff Salary IDs (SAL3027 to SAL3019)
('SAL3027', 0.00), -- Jayanth (Chief Administrator)
('SAL3028', 0.00), -- Dharneesh (Chief Administrator)
('SAL3029', 0.00), -- Vishal (Chief Administrator)
('SAL3013', 55000.00), -- Rajesh Verma (Finance Officer)
('SAL3014', 40000.00), -- Anjali Sharma (Accountant)
('SAL3015', 35000.00), -- Vikram Mehta (Billing Clerk)
('SAL3016', 45000.00), -- Priya Iyer (Payroll Manager)
('SAL3017', 60000.00), -- Ramesh Gupta (Office Head)
('SAL3018', 35000.00), -- Manoj Chatterjee (Office Assistant)
('SAL3019', 35000.00), -- Sneha Kulkarni (Office Assistant)

-- Department Heads Salary IDs (SAL1001 to SAL1005)
('SAL1001', 80000.00), -- Amit Sharma (CSE)
('SAL1002', 80000.00), -- Rajesh Verma (ECE)
('SAL1003', 80000.00), -- Sandeep Kumar (MECH)
('SAL1004', 80000.00), -- Vikram Singh (CIVIL)
('SAL1005', 80000.00), -- Priya Iyer (EEE)

-- Instructors Salary IDs (SAL1006 to SAL1030)
('SAL1006', 75000.00), -- Ravi Sharma (CSE)
('SAL1007', 75000.00), -- Anjali Verma (CSE)
('SAL1008', 75000.00), -- Vivek Gupta (CSE)
('SAL1009', 75000.00), -- Neha Joshi (CSE)
('SAL1010', 75000.00), -- Amit Mehta (CSE)

('SAL1011', 75000.00), -- Priya Nair (ECE)
('SAL1012', 75000.00), -- Vikram Rao (ECE)
('SAL1013', 75000.00), -- Kavita Iyer (ECE)
('SAL1014', 75000.00), -- Rohan Das (ECE)
('SAL1015', 75000.00), -- Sonia Kapoor (ECE)

('SAL1016', 75000.00), -- Rajesh Patil (MECH)
('SAL1017', 75000.00), -- Sandeep Kumar (MECH)
('SAL1018', 75000.00), -- Harshita Reddy (MECH)
('SAL1019', 75000.00), -- Manoj Yadav (MECH)
('SAL1020', 75000.00), -- Divya Bansal (MECH)

('SAL1021', 75000.00), -- Vikrant Singh (CIVIL)
('SAL1022', 75000.00), -- Pooja Malhotra (CIVIL)
('SAL1023', 75000.00), -- Nitin Garg (CIVIL)
('SAL1024', 75000.00), -- Swati Choudhary (CIVIL)
('SAL1025', 75000.00), -- Arjun Kapoor (CIVIL)

-- EEE Instructors Salary IDs (SAL1026 to SAL1030)
('SAL1026', 75000.00), -- Ramesh Iyer (EEE)
('SAL1027', 75000.00), -- Sneha Patel (EEE)
('SAL1028', 75000.00), -- Vikram Malhotra (EEE)
('SAL1029', 75000.00), -- Anjali Desai (EEE)
('SAL1030', 75000.00), -- Suresh Chawla (EEE)

-- Hostel Wardens Salary IDs (SAL3001 to SAL3012)
('SAL3001', 60000.00), -- Ravi Sharma (Vasant Boys Hostel Head)
('SAL3002', 50000.00), -- Amit Kumar (Vasant Boys Hostel)
('SAL3003', 50000.00), -- Suresh Patil (Vasant Boys Hostel)

('SAL3004', 60000.00), -- Manoj Verma (Taj Boys Hostel Head)
('SAL3005', 50000.00), -- Rajesh Singh (Taj Boys Hostel)
('SAL3006', 50000.00), -- Anil Yadav (Taj Boys Hostel)

('SAL3007', 60000.00), -- Sunita Reddy (Ganga Girls Hostel Head)
('SAL3008', 50000.00), -- Meena Joshi (Ganga Girls Hostel)
('SAL3009', 50000.00), -- Priya Nair (Ganga Girls Hostel)

('SAL3010', 60000.00), -- Kavita Rao (Yamuna Girls Hostel Head)
('SAL3011', 50000.00), -- Pooja Iyer (Yamuna Girls Hostel)
('SAL3012', 50000.00); -- Anita Desai (Yamuna Girls Hostel)

INSERT INTO Department_Heads (department_head_id, name, email, department_id, salary_id) VALUES 
    ('CSE1000', 'Amit Sharma', 'amit.sharma@univ.edu', 'CSE', 'SAL1001'),
    ('ECE1000', 'Rajesh Verma', 'rajesh.verma@univ.edu', 'ECE', 'SAL1002'),
    ('MECH1000', 'Sandeep Kumar', 'sandeep.kumar@univ.edu', 'MECH', 'SAL1003'),
    ('CIVIL1000', 'Vikram Singh', 'vikram.singh@univ.edu', 'CIVIL', 'SAL1004'),
    ('EEE1000', 'Priya Iyer', 'priya.iyer@univ.edu', 'EEE', 'SAL1005');


INSERT INTO Courses (course_id, course_name, department_id, total_credits) VALUES
    ('CSE20001', 'Data Structures', 'CSE', 4),
    ('CSE20002', 'Algorithms', 'CSE', 3),
    ('CSE20003', 'Database Management', 'CSE', 4),
    ('CSE20004', 'Operating Systems', 'CSE', 3),
    ('CSE20005', 'Computer Networks', 'CSE', 4),

    ('ECE20001', 'Digital Circuits', 'ECE', 3),
    ('ECE20002', 'Analog Electronics', 'ECE', 4),
    ('ECE20003', 'Microprocessors', 'ECE', 3),
    ('ECE20004', 'Communication Systems', 'ECE', 4),
    ('ECE20005', 'Embedded Systems', 'ECE', 3),

    ('MECH20001', 'Engineering Mechanics', 'MECH', 4),
    ('MECH20002', 'Thermodynamics', 'MECH', 3),
    ('MECH20003', 'Fluid Mechanics', 'MECH', 4),
    ('MECH20004', 'Manufacturing Processes', 'MECH', 3),
    ('MECH20005', 'Automobile Engineering', 'MECH', 4),

    ('CIVIL20001', 'Structural Analysis', 'CIVIL', 3),
    ('CIVIL20002', 'Geotechnical Engineering', 'CIVIL', 4),
    ('CIVIL20003', 'Transportation Engineering', 'CIVIL', 3),
    ('CIVIL20004', 'Water Resources Engineering', 'CIVIL', 4),
    ('CIVIL20005', 'Environmental Engineering', 'CIVIL', 3),

    ('EEE20001', 'Electrical Machines', 'EEE', 4),
    ('EEE20002', 'Power Systems', 'EEE', 3),
    ('EEE20003', 'Control Systems', 'EEE', 4),
    ('EEE20004', 'Electrical Measurements', 'EEE', 3),
    ('EEE20005', 'High Voltage Engineering', 'EEE', 4);

INSERT INTO Instructors (instructor_id, name, gender, contact_number, email, department_id, course_id, joining_date, salary_id) VALUES
    -- CSE Instructors
    ('CSE10001', 'Ravi Sharma', 'Male', '9876543210', 'ravi.sharma@univ.edu', 'CSE', 'CSE20001', '2020-08-01', 'SAL1006'),
    ('CSE10002', 'Anjali Verma', 'Female', '9765432109', 'anjali.verma@univ.edu', 'CSE', 'CSE20002', '2021-07-15', 'SAL1007'),
    ('CSE10003', 'Vivek Gupta', 'Male', '9654321098', 'vivek.gupta@univ.edu', 'CSE', 'CSE20003', '2019-05-20', 'SAL1008'),
    ('CSE10004', 'Neha Joshi', 'Female', '9543210987', 'neha.joshi@univ.edu', 'CSE', 'CSE20004', '2022-06-12', 'SAL1009'),
    ('CSE10005', 'Amit Mehta', 'Male', '9432109876', 'amit.mehta@univ.edu', 'CSE', 'CSE20005', '2018-11-30', 'SAL1010'),

    -- ECE Instructors
    ('ECE10001', 'Priya Nair', 'Female', '9321098765', 'priya.nair@univ.edu', 'ECE', 'ECE20001', '2017-09-25', 'SAL1011'),
    ('ECE10002', 'Vikram Rao', 'Male', '9210987654', 'vikram.rao@univ.edu', 'ECE', 'ECE20002', '2019-08-14', 'SAL1012'),
    ('ECE10003', 'Kavita Iyer', 'Female', '9109876543', 'kavita.iyer@univ.edu', 'ECE', 'ECE20003', '2020-12-10', 'SAL1013'),
    ('ECE10004', 'Rohan Das', 'Male', '9098765432', 'rohan.das@univ.edu', 'ECE', 'ECE20004', '2021-04-05', 'SAL1014'),
    ('ECE10005', 'Sonia Kapoor', 'Female', '8987654321', 'sonia.kapoor@univ.edu', 'ECE', 'ECE20005', '2018-07-22', 'SAL1015'),

    -- EEE Instructors (Newly Added)
    ('EEE10001', 'Rajiv Menon', 'Male', '8876901234', 'rajiv.menon@univ.edu', 'EEE', 'EEE20001', '2016-08-10', 'SAL1026'),
    ('EEE10002', 'Anusha Shetty', 'Female', '8765784321', 'anusha.shetty@univ.edu', 'EEE', 'EEE20002', '2017-05-18', 'SAL1027'),
    ('EEE10003', 'Prakash Naik', 'Male', '8654678901', 'prakash.naik@univ.edu', 'EEE', 'EEE20003', '2019-11-02', 'SAL1028'),
    ('EEE10004', 'Sneha Kulkarni', 'Female', '8543567890', 'sneha.kulkarni@univ.edu', 'EEE', 'EEE20004', '2020-03-14', 'SAL1029'),
    ('EEE10005', 'Arvind Iyer', 'Male', '8432456789', 'arvind.iyer@univ.edu', 'EEE', 'EEE20005', '2021-07-22', 'SAL1030'),

    -- MECH Instructors
    ('MECH10001', 'Rajesh Patil', 'Male', '8876543210', 'rajesh.patil@univ.edu', 'MECH', 'MECH20001', '2016-10-30', 'SAL1016'),
    ('MECH10002', 'Sandeep Kumar', 'Male', '8765432109', 'sandeep.kumar@univ.edu', 'MECH', 'MECH20002', '2017-12-15', 'SAL1017'),
    ('MECH10003', 'Harshita Reddy', 'Female', '8654321098', 'harshita.reddy@univ.edu', 'MECH', 'MECH20003', '2019-09-10', 'SAL1018'),
    ('MECH10004', 'Manoj Yadav', 'Male', '8543210987', 'manoj.yadav@univ.edu', 'MECH', 'MECH20004', '2021-02-25', 'SAL1019'),
    ('MECH10005', 'Divya Bansal', 'Female', '8432109876', 'divya.bansal@univ.edu', 'MECH', 'MECH20005', '2020-11-18', 'SAL1020'),

    -- CIVIL Instructors
    ('CIVIL10001', 'Vikrant Singh', 'Male', '8321098765', 'vikrant.singh@univ.edu', 'CIVIL', 'CIVIL20001', '2015-07-05', 'SAL1021'),
    ('CIVIL10002', 'Pooja Malhotra', 'Female', '8210987654', 'pooja.malhotra@univ.edu', 'CIVIL', 'CIVIL20002', '2016-06-20', 'SAL1022'),
    ('CIVIL10003', 'Nitin Garg', 'Male', '8109876543', 'nitin.garg@univ.edu', 'CIVIL', 'CIVIL20003', '2018-05-15', 'SAL1023'),
    ('CIVIL10004', 'Swati Choudhary', 'Female', '8098765432', 'swati.choudhary@univ.edu', 'CIVIL', 'CIVIL20004', '2020-08-25', 'SAL1024'),
    ('CIVIL10005', 'Arjun Kapoor', 'Male', '7987654321', 'arjun.kapoor@univ.edu', 'CIVIL', 'CIVIL20005', '2019-10-12', 'SAL1025');



INSERT INTO Boys_Hostel (hostel_id, hostel_name, capacity, available_capacity) VALUES
    ('HOSB001', 'Vasant Boys Hostel', 50, 5),
    ('HOSB002', 'Taj Boys Hostel', 50, 2);
INSERT INTO Girls_Hostel (hostel_id, hostel_name, capacity, available_capacity) VALUES
    ('HOSG001', 'Ganga Girls Hostel', 50, 8),
    ('HOSG002', 'Yamuna Girls Hostel', 50, 4);

INSERT INTO Hostel_Wardens (warden_id, name, gender, contact_number, email, boys_hostel_id, girls_hostel_id, is_head_warden, salary_id) VALUES
    -- Vasant Boys Hostel (HOSB001) - 3 Male Wardens
    ('WB001', 'Ravi Sharma', 'Male', '9876543210', 'ravi.sharma@hostel.com', 'HOSB001', NULL, TRUE, 'SAL3001'),
    ('WB002', 'Amit Kumar', 'Male', '9876543211', 'amit.kumar@hostel.com', 'HOSB001', NULL, FALSE, 'SAL3002'),
    ('WB003', 'Suresh Patil', 'Male', '9876543212', 'suresh.patil@hostel.com', 'HOSB001', NULL, FALSE, 'SAL3003'),

    -- Taj Boys Hostel (HOSB002) - 3 Male Wardens
    ('WB004', 'Manoj Verma', 'Male', '9876543213', 'manoj.verma@hostel.com', 'HOSB002', NULL, TRUE, 'SAL3004'),
    ('WB005', 'Rajesh Singh', 'Male', '9876543214', 'rajesh.singh@hostel.com', 'HOSB002', NULL, FALSE, 'SAL3005'),
    ('WB006', 'Anil Yadav', 'Male', '9876543215', 'anil.yadav@hostel.com', 'HOSB002', NULL, FALSE, 'SAL3006'),

    -- Ganga Girls Hostel (HOSG001) - 3 Female Wardens
    ('WG001', 'Sunita Reddy', 'Female', '9876543216', 'sunita.reddy@hostel.com', NULL, 'HOSG001', TRUE, 'SAL3007'),
    ('WG002', 'Meena Joshi', 'Female', '9876543217', 'meena.joshi@hostel.com', NULL, 'HOSG001', FALSE, 'SAL3008'),
    ('WG003', 'Priya Nair', 'Female', '9876543218', 'priya.nair@hostel.com', NULL, 'HOSG001', FALSE, 'SAL3009'),

    -- Yamuna Girls Hostel (HOSG002) - 3 Female Wardens
    ('WG004', 'Kavita Rao', 'Female', '9876543219', 'kavita.rao@hostel.com', NULL, 'HOSG002', TRUE, 'SAL3010'),
    ('WG005', 'Pooja Iyer', 'Female', '9876543220', 'pooja.iyer@hostel.com', NULL, 'HOSG002', FALSE, 'SAL3011'),
    ('WG006', 'Anita Desai', 'Female', '9876543221', 'anita.desai@hostel.com', NULL, 'HOSG002', FALSE, 'SAL3012');


INSERT INTO Students (student_id, name, gender, dob, contact_number, email, hostler_or_day, avails_bus, department_id, boys_hostel_id, girls_hostel_id) VALUES
-- Boys in CSE (18)
('CSE240001', 'Aarav Sharma', 'Male', '2004-05-12', '9876543210', 'CSE240001@college.edu', 'Hostler', FALSE, 'CSE', 'HOSB001', NULL),
('CSE240002', 'Vihaan Verma', 'Male', '2004-06-22', '9876543211', 'CSE240002@college.edu', 'Hostler', FALSE, 'CSE', 'HOSB001', NULL),
('CSE240003', 'Reyansh Joshi', 'Male', '2004-07-10', '9876543212', 'CSE240003@college.edu', 'Hostler', FALSE, 'CSE', 'HOSB001', NULL),
('CSE240004', 'Shaurya Singh', 'Male', '2004-08-14', '9876543213', 'CSE240004@college.edu', 'Hostler', FALSE, 'CSE', 'HOSB001', NULL),
('CSE240005', 'Ayaan Gupta', 'Male', '2004-09-25', '9876543214', 'CSE240005@college.edu', 'Hostler', FALSE, 'CSE', 'HOSB001', NULL),
('CSE240006', 'Kabir Mehta', 'Male', '2004-10-03', '9876543215', 'CSE240006@college.edu', 'Hostler', FALSE, 'CSE', 'HOSB001', NULL),
('CSE240007', 'Arjun Rao', 'Male', '2004-11-11', '9876543216', 'CSE240007@college.edu', 'Hostler', FALSE, 'CSE', 'HOSB001', NULL),
('CSE240008', 'Krishna Malhotra', 'Male', '2004-12-30', '9876543217', 'CSE240008@college.edu', 'Hostler', FALSE, 'CSE', 'HOSB001', NULL),
('CSE240009', 'Atharv Bhat', 'Male', '2005-01-20', '9876543218', 'CSE240009@college.edu', 'Hostler', FALSE, 'CSE', 'HOSB001', NULL),
('CSE240010', 'Dev Patel', 'Male', '2005-02-14', '9876543219', 'CSE240010@college.edu', 'Hostler', FALSE, 'CSE', 'HOSB002', NULL),
('CSE240011', 'Vivaan Trivedi', 'Male', '2005-03-18', '9876543220', 'CSE240011@college.edu', 'Hostler', FALSE, 'CSE', 'HOSB002', NULL),
('CSE240012', 'Mihir Kapoor', 'Male', '2005-04-25', '9876543221', 'CSE240012@college.edu', 'Hostler', FALSE, 'CSE', 'HOSB002', NULL),
('CSE240013', 'Samar Iyer', 'Male', '2005-05-06', '9876543222', 'CSE240013@college.edu', 'Hostler', FALSE, 'CSE', 'HOSB002', NULL),
('CSE240014', 'Harsh Choudhary', 'Male', '2005-06-19', '9876543223', 'CSE240014@college.edu', 'Hostler', FALSE, 'CSE', 'HOSB002', NULL),
('CSE240015', 'Ritvik Das', 'Male', '2005-07-30', '9876543224', 'CSE240015@college.edu', 'Hostler', FALSE, 'CSE', 'HOSB002', NULL),
('CSE240016', 'Yug Tiwari', 'Male', '2005-08-12', '9876543225', 'CSE240016@college.edu', 'Hostler', FALSE, 'CSE', 'HOSB002', NULL),
('CSE240017', 'Shivansh Sinha', 'Male', '2005-09-26', '9876543226', 'CSE240017@college.edu', 'Hostler', FALSE, 'CSE', 'HOSB002', NULL),
('CSE240018', 'Tanishq Saxena', 'Male', '2005-10-29', '9876543227', 'CSE240018@college.edu', 'Hostler', FALSE, 'CSE', 'HOSB002', NULL),

-- Girls in CSE (18)
('CSE240019', 'Ananya Mishra', 'Female', '2004-05-10', '9876543228', 'CSE240019@college.edu', 'Hostler', FALSE, 'CSE', NULL, 'HOSG001'),
('CSE240020', 'Ishika Nair', 'Female', '2004-06-15', '9876543229', 'CSE240020@college.edu', 'Hostler', FALSE, 'CSE', NULL, 'HOSG001'),
('CSE240021', 'Saanvi Reddy', 'Female', '2004-07-22', '9876543230', 'CSE240021@college.edu', 'Hostler', FALSE, 'CSE', NULL, 'HOSG001'),
('CSE240022', 'Aadhya Iyer', 'Female', '2004-08-08', '9876543231', 'CSE240022@college.edu', 'Hostler', FALSE, 'CSE', NULL, 'HOSG001'),
('CSE240023', 'Myra Shah', 'Female', '2004-09-18', '9876543232', 'CSE240023@college.edu', 'Hostler', FALSE, 'CSE', NULL, 'HOSG001'),
('CSE240024', 'Tisha Pillai', 'Female', '2004-10-27', '9876543233', 'CSE240024@college.edu', 'Hostler', FALSE, 'CSE', NULL, 'HOSG001'),
('CSE240025', 'Riya Banerjee', 'Female', '2004-11-05', '9876543234', 'CSE240025@college.edu', 'Hostler', FALSE, 'CSE', NULL, 'HOSG001'),
('CSE240026', 'Tanisha Bose', 'Female', '2004-12-14', '9876543235', 'CSE240026@college.edu', 'Hostler', FALSE, 'CSE', NULL, 'HOSG001'),
('CSE240027', 'Esha Mukherjee', 'Female', '2005-01-30', '9876543236', 'CSE240027@college.edu', 'Hostler', FALSE, 'CSE', NULL, 'HOSG001'),
('CSE240028', 'Simran Batra', 'Female', '2005-02-22', '9876543237', 'CSE240028@college.edu', 'Hostler', FALSE, 'CSE', NULL, 'HOSG002'),
('CSE240029', 'Priya Chatterjee', 'Female', '2005-03-16', '9876543238', 'CSE240029@college.edu', 'Hostler', FALSE, 'CSE', NULL, 'HOSG002'),
('CSE240030', 'Meera Dutta', 'Female', '2005-04-28', '9876543239', 'CSE240030@college.edu', 'Hostler', FALSE, 'CSE', NULL, 'HOSG002'),
('CSE240031', 'Aarohi Sengupta', 'Female', '2005-05-08', '9876543240', 'CSE240031@college.edu', 'Hostler', FALSE, 'CSE', NULL, 'HOSG002'),
('CSE240032', 'Jhanvi Ghosh', 'Female', '2005-06-10', '9876543241', 'CSE240032@college.edu', 'Hostler', FALSE, 'CSE', NULL, 'HOSG002'),
('CSE240033', 'Diya Basu', 'Female', '2005-07-21', '9876543242', 'CSE240033@college.edu', 'Hostler', FALSE, 'CSE', NULL, 'HOSG002'),
('CSE240034', 'Shanaya Sen', 'Female', '2005-08-30', '9876543243', 'CSE240034@college.edu', 'Hostler', FALSE, 'CSE', NULL, 'HOSG002'),
('CSE240035', 'Avni Chakraborty', 'Female', '2005-09-14', '9876543244', 'CSE240035@college.edu', 'Hostler', FALSE, 'CSE', NULL, 'HOSG002'),
('CSE240036', 'Ishani Roy', 'Female', '2005-10-05', '9876543245', 'CSE240036@college.edu', 'Hostler', FALSE, 'CSE', NULL, 'HOSG002');

INSERT INTO Students (student_id, name, gender, dob, contact_number, email, hostler_or_day, avails_bus, department_id, boys_hostel_id, girls_hostel_id) VALUES
-- Boys in HOSB001
('ECE240001', 'Aarav Mehta', 'Male', '2005-01-12', '9876543101', 'ECE240001@college.edu', 'Hostler', FALSE, 'ECE', 'HOSB001', NULL),
('ECE240002', 'Kabir Reddy', 'Male', '2005-02-15', '9876543102', 'ECE240002@college.edu', 'Hostler', FALSE, 'ECE', 'HOSB001', NULL),
('ECE240003', 'Rohan Das', 'Male', '2005-03-20', '9876543103', 'ECE240003@college.edu', 'Hostler', FALSE, 'ECE', 'HOSB001', NULL),
('ECE240004', 'Vihaan Sharma', 'Male', '2005-04-25', '9876543104', 'ECE240004@college.edu', 'Hostler', FALSE, 'ECE', 'HOSB001', NULL),
('ECE240005', 'Arjun Gupta', 'Male', '2005-05-10', '9876543105', 'ECE240005@college.edu', 'Hostler', FALSE, 'ECE', 'HOSB001', NULL),
('ECE240006', 'Ishaan Bajaj', 'Male', '2005-06-18', '9876543106', 'ECE240006@college.edu', 'Hostler', FALSE, 'ECE', 'HOSB001', NULL),
('ECE240007', 'Ritvik Chawla', 'Male', '2005-07-22', '9876543107', 'ECE240007@college.edu', 'Hostler', FALSE, 'ECE', 'HOSB001', NULL),
('ECE240008', 'Dev Patel', 'Male', '2005-08-30', '9876543108', 'ECE240008@college.edu', 'Hostler', FALSE, 'ECE', 'HOSB001', NULL),
('ECE240009', 'Shreyas Malhotra', 'Male', '2005-09-05', '9876543109', 'ECE240009@college.edu', 'Hostler', FALSE, 'ECE', 'HOSB001', NULL),

-- Boys in HOSB002
('ECE240010', 'Yash Nair', 'Male', '2005-10-11', '9876543110', 'ECE240010@college.edu', 'Hostler', FALSE, 'ECE', 'HOSB002', NULL),
('ECE240011', 'Aditya Sinha', 'Male', '2005-11-16', '9876543111', 'ECE240011@college.edu', 'Hostler', FALSE, 'ECE', 'HOSB002', NULL),
('ECE240012', 'Rudra Kapoor', 'Male', '2005-12-21', '9876543112', 'ECE240012@college.edu', 'Hostler', FALSE, 'ECE', 'HOSB002', NULL),
('ECE240013', 'Kunal Joshi', 'Male', '2006-01-05', '9876543113', 'ECE240013@college.edu', 'Hostler', FALSE, 'ECE', 'HOSB002', NULL),
('ECE240014', 'Tanishq Saxena', 'Male', '2006-02-12', '9876543114', 'ECE240014@college.edu', 'Hostler', FALSE, 'ECE', 'HOSB002', NULL),
('ECE240015', 'Shaurya Khanna', 'Male', '2006-03-19', '9876543115', 'ECE240015@college.edu', 'Hostler', FALSE, 'ECE', 'HOSB002', NULL),
('ECE240016', 'Vivaan Ahuja', 'Male', '2006-04-27', '9876543116', 'ECE240016@college.edu', 'Hostler', FALSE, 'ECE', 'HOSB002', NULL),
('ECE240017', 'Atharv Grover', 'Male', '2006-05-30', '9876543117', 'ECE240017@college.edu', 'Hostler', FALSE, 'ECE', 'HOSB002', NULL),
('ECE240018', 'Harsh Bhatt', 'Male', '2006-06-07', '9876543118', 'ECE240018@college.edu', 'Hostler', FALSE, 'ECE', 'HOSB002', NULL),

-- Girls in HOSG001
('ECE240019', 'Ananya Iyer', 'Female', '2005-01-14', '9876543119', 'ECE240019@college.edu', 'Hostler', FALSE, 'ECE', NULL, 'HOSG001'),
('ECE240020', 'Sanya Menon', 'Female', '2005-02-18', '9876543120', 'ECE240020@college.edu', 'Hostler', FALSE, 'ECE', NULL, 'HOSG001'),
('ECE240021', 'Pihu Bansal', 'Female', '2005-03-23', '9876543121', 'ECE240021@college.edu', 'Hostler', FALSE, 'ECE', NULL, 'HOSG001'),
('ECE240022', 'Mahika Arora', 'Female', '2005-04-28', '9876543122', 'ECE240022@college.edu', 'Hostler', FALSE, 'ECE', NULL, 'HOSG001'),
('ECE240023', 'Esha Kulkarni', 'Female', '2005-05-15', '9876543123', 'ECE240023@college.edu', 'Hostler', FALSE, 'ECE', NULL, 'HOSG001'),
('ECE240024', 'Rhea Tandon', 'Female', '2005-06-20', '9876543124', 'ECE240024@college.edu', 'Hostler', FALSE, 'ECE', NULL, 'HOSG001'),
('ECE240025', 'Naina Aggarwal', 'Female', '2005-07-25', '9876543125', 'ECE240025@college.edu', 'Hostler', FALSE, 'ECE', NULL, 'HOSG001'),
('ECE240026', 'Tara Rao', 'Female', '2005-08-31', '9876543126', 'ECE240026@college.edu', 'Hostler', FALSE, 'ECE', NULL, 'HOSG001'),
('ECE240027', 'Suhani Deshmukh', 'Female', '2005-09-10', '9876543127', 'ECE240027@college.edu', 'Hostler', FALSE, 'ECE', NULL, 'HOSG001'),

-- Girls in HOSG002
('ECE240028', 'Jhanvi Shah', 'Female', '2005-10-15', '9876543128', 'ECE240028@college.edu', 'Hostler', FALSE, 'ECE', NULL, 'HOSG002'),
('ECE240029', 'Meher Choudhury', 'Female', '2005-11-22', '9876543129', 'ECE240029@college.edu', 'Hostler', FALSE, 'ECE', NULL, 'HOSG002'),
('ECE240030', 'Sara Venkatesh', 'Female', '2005-12-29', '9876543130', 'ECE240030@college.edu', 'Hostler', FALSE, 'ECE', NULL, 'HOSG002'),
('ECE240031', 'Avni Pillai', 'Female', '2006-01-06', '9876543131', 'ECE240031@college.edu', 'Hostler', FALSE, 'ECE', NULL, 'HOSG002'),
('ECE240032', 'Yashika Jain', 'Female', '2006-02-14', '9876543132', 'ECE240032@college.edu', 'Hostler', FALSE, 'ECE', NULL, 'HOSG002'),
('ECE240033', 'Sharvani Nair', 'Female', '2006-03-22', '9876543133', 'ECE240033@college.edu', 'Hostler', FALSE, 'ECE', NULL, 'HOSG002'),
('ECE240034', 'Prisha Talwar', 'Female', '2006-04-30', '9876543134', 'ECE240034@college.edu', 'Hostler', FALSE, 'ECE', NULL, 'HOSG002'),
('ECE240035', 'Manya Verma', 'Female', '2006-05-07', '9876543135', 'ECE240035@college.edu', 'Hostler', FALSE, 'ECE', NULL, 'HOSG002'),
('ECE240036', 'Ishani Sengupta', 'Female', '2006-06-13', '9876543136', 'ECE240036@college.edu', 'Hostler', FALSE, 'ECE', NULL, 'HOSG002');

INSERT INTO Students (student_id, name, gender, dob, contact_number, email, hostler_or_day, avails_bus, department_id, boys_hostel_id, girls_hostel_id) VALUES
-- Boys in HOSB001
('MECH240001', 'Amit Rathore', 'Male', '2005-01-20', '9876543201', 'MECH240001@college.edu', 'Hostler', FALSE, 'MECH', 'HOSB001', NULL),
('MECH240002', 'Pranav Kulkarni', 'Male', '2005-02-25', '9876543202', 'MECH240002@college.edu', 'Hostler', FALSE, 'MECH', 'HOSB001', NULL),
('MECH240003', 'Raghav Kapoor', 'Male', '2005-03-15', '9876543203', 'MECH240003@college.edu', 'Hostler', FALSE, 'MECH', 'HOSB001', NULL),
('MECH240004', 'Sarthak Tiwari', 'Male', '2005-04-10', '9876543204', 'MECH240004@college.edu', 'Hostler', FALSE, 'MECH', 'HOSB001', NULL),
('MECH240005', 'Nishant Sharma', 'Male', '2005-05-18', '9876543205', 'MECH240005@college.edu', 'Hostler', FALSE, 'MECH', 'HOSB001', NULL),
('MECH240006', 'Harsh Trivedi', 'Male', '2005-06-22', '9876543206', 'MECH240006@college.edu', 'Hostler', FALSE, 'MECH', 'HOSB001', NULL),
('MECH240007', 'Aryan Verma', 'Male', '2005-07-30', '9876543207', 'MECH240007@college.edu', 'Hostler', FALSE, 'MECH', 'HOSB001', NULL),
('MECH240008', 'Shivam Bansal', 'Male', '2005-08-05', '9876543208', 'MECH240008@college.edu', 'Hostler', FALSE, 'MECH', 'HOSB001', NULL),
('MECH240009', 'Aniket Mishra', 'Male', '2005-09-12', '9876543209', 'MECH240009@college.edu', 'Hostler', FALSE, 'MECH', 'HOSB001', NULL),

-- Boys in HOSB002
('MECH240010', 'Rahul Nair', 'Male', '2005-10-15', '9876543210', 'MECH240010@college.edu', 'Hostler', FALSE, 'MECH', 'HOSB002', NULL),
('MECH240011', 'Kunal Singh', 'Male', '2005-11-28', '9876543211', 'MECH240011@college.edu', 'Hostler', FALSE, 'MECH', 'HOSB002', NULL),
('MECH240012', 'Devansh Choudhury', 'Male', '2005-12-03', '9876543212', 'MECH240012@college.edu', 'Hostler', FALSE, 'MECH', 'HOSB002', NULL),
('MECH240013', 'Varun Malhotra', 'Male', '2006-01-09', '9876543213', 'MECH240013@college.edu', 'Hostler', FALSE, 'MECH', 'HOSB002', NULL),
('MECH240014', 'Tushar Joshi', 'Male', '2006-02-14', '9876543214', 'MECH240014@college.edu', 'Hostler', FALSE, 'MECH', 'HOSB002', NULL),
('MECH240015', 'Gaurav Saxena', 'Male', '2006-03-21', '9876543215', 'MECH240015@college.edu', 'Hostler', FALSE, 'MECH', 'HOSB002', NULL),
('MECH240016', 'Sandeep Khanna', 'Male', '2006-04-27', '9876543216', 'MECH240016@college.edu', 'Hostler', FALSE, 'MECH', 'HOSB002', NULL),
('MECH240017', 'Anshul Ahuja', 'Male', '2006-05-06', '9876543217', 'MECH240017@college.edu', 'Hostler', FALSE, 'MECH', 'HOSB002', NULL),
('MECH240018', 'Vikram Bhatt', 'Male', '2006-06-12', '9876543218', 'MECH240018@college.edu', 'Hostler', FALSE, 'MECH', 'HOSB002', NULL),

-- Girls in HOSG001
('MECH240019', 'Neha Iyer', 'Female', '2005-01-11', '9876543219', 'MECH240019@college.edu', 'Hostler', FALSE, 'MECH', NULL, 'HOSG001'),
('MECH240020', 'Shreya Menon', 'Female', '2005-02-19', '9876543220', 'MECH240020@college.edu', 'Hostler', FALSE, 'MECH', NULL, 'HOSG001'),
('MECH240021', 'Priya Bansal', 'Female', '2005-03-24', '9876543221', 'MECH240021@college.edu', 'Hostler', FALSE, 'MECH', NULL, 'HOSG001'),
('MECH240022', 'Megha Arora', 'Female', '2005-04-29', '9876543222', 'MECH240022@college.edu', 'Hostler', FALSE, 'MECH', NULL, 'HOSG001'),
('MECH240023', 'Simran Kulkarni', 'Female', '2005-05-16', '9876543223', 'MECH240023@college.edu', 'Hostler', FALSE, 'MECH', NULL, 'HOSG001'),
('MECH240024', 'Divya Tandon', 'Female', '2005-06-21', '9876543224', 'MECH240024@college.edu', 'Hostler', FALSE, 'MECH', NULL, 'HOSG001'),
('MECH240025', 'Ritika Aggarwal', 'Female', '2005-07-26', '9876543225', 'MECH240025@college.edu', 'Hostler', FALSE, 'MECH', NULL, 'HOSG001'),
('MECH240026', 'Tanya Rao', 'Female', '2005-08-31', '9876543226', 'MECH240026@college.edu', 'Hostler', FALSE, 'MECH', NULL, 'HOSG001'),
('MECH240027', 'Sneha Deshmukh', 'Female', '2005-09-10', '9876543227', 'MECH240027@college.edu', 'Hostler', FALSE, 'MECH', NULL, 'HOSG001'),

-- Girls in HOSG002
('MECH240028', 'Jhanvi Shah', 'Female', '2005-10-15', '9876543228', 'MECH240028@college.edu', 'Hostler', FALSE, 'MECH', NULL, 'HOSG002'),
('MECH240029', 'Meher Choudhury', 'Female', '2005-11-22', '9876543229', 'MECH240029@college.edu', 'Hostler', FALSE, 'MECH', NULL, 'HOSG002'),
('MECH240030', 'Sara Venkatesh', 'Female', '2005-12-29', '9876543230', 'MECH240030@college.edu', 'Hostler', FALSE, 'MECH', NULL, 'HOSG002'),
('MECH240031', 'Avni Pillai', 'Female', '2006-01-06', '9876543231', 'MECH240031@college.edu', 'Hostler', FALSE, 'MECH', NULL, 'HOSG002'),
('MECH240032', 'Yashika Jain', 'Female', '2006-02-14', '9876543232', 'MECH240032@college.edu', 'Hostler', FALSE, 'MECH', NULL, 'HOSG002'),
('MECH240033', 'Sharvani Nair', 'Female', '2006-03-22', '9876543233', 'MECH240033@college.edu', 'Hostler', FALSE, 'MECH', NULL, 'HOSG002'),
('MECH240034', 'Ishita Reddy', 'Female', '2006-04-15', '9876543234', 'MECH240034@college.edu', 'Hostler', FALSE, 'MECH', NULL, 'HOSG002'),
('MECH240035', 'Ananya Patel', 'Female', '2006-05-20', '9876543235', 'MECH240035@college.edu', 'Hostler', FALSE, 'MECH', NULL, 'HOSG002'),
('MECH240036', 'Mitali Goswami', 'Female', '2006-06-25', '9876543236', 'MECH240036@college.edu', 'Hostler', FALSE, 'MECH', NULL, 'HOSG002');

-- HOSB001 - 9 Boys
INSERT INTO Students (student_id, name, gender, dob, contact_number, email, hostler_or_day, avails_bus, department_id, boys_hostel_id, girls_hostel_id) VALUES
('EEE240001', 'Aarav Verma', 'Male', '2006-02-10', '9876543301', 'EEE240001@college.edu', 'Hostler', FALSE, 'EEE', 'HOSB001', NULL),
('EEE240002', 'Rohan Patel', 'Male', '2006-03-15', '9876543302', 'EEE240002@college.edu', 'Hostler', FALSE, 'EEE', 'HOSB001', NULL),
('EEE240003', 'Karthik Nair', 'Male', '2006-04-20', '9876543303', 'EEE240003@college.edu', 'Hostler', FALSE, 'EEE', 'HOSB001', NULL),
('EEE240004', 'Vikram Sharma', 'Male', '2006-05-25', '9876543304', 'EEE240004@college.edu', 'Hostler', FALSE, 'EEE', 'HOSB001', NULL),
('EEE240005', 'Harsh Mehta', 'Male', '2006-06-10', '9876543305', 'EEE240005@college.edu', 'Hostler', FALSE, 'EEE', 'HOSB001', NULL),
('EEE240006', 'Aditya Joshi', 'Male', '2006-07-15', '9876543306', 'EEE240006@college.edu', 'Hostler', FALSE, 'EEE', 'HOSB001', NULL),
('EEE240007', 'Siddharth Iyer', 'Male', '2006-08-20', '9876543307', 'EEE240007@college.edu', 'Hostler', FALSE, 'EEE', 'HOSB001', NULL),
('EEE240008', 'Rajat Bhardwaj', 'Male', '2006-09-25', '9876543308', 'EEE240008@college.edu', 'Hostler', FALSE, 'EEE', 'HOSB001', NULL),
('EEE240009', 'Tushar Bansal', 'Male', '2006-10-10', '9876543309', 'EEE240009@college.edu', 'Hostler', FALSE, 'EEE', 'HOSB001', NULL);

-- HOSB002 - 10 Boys
INSERT INTO Students VALUES
('EEE240010', 'Aryan Khanna', 'Male', '2006-02-05', '9876543310', 'EEE240010@college.edu', 'Hostler', FALSE, 'EEE', 'HOSB002', NULL),
('EEE240011', 'Kabir Saxena', 'Male', '2006-03-10', '9876543311', 'EEE240011@college.edu', 'Hostler', FALSE, 'EEE', 'HOSB002', NULL),
('EEE240012', 'Shubham Malhotra', 'Male', '2006-04-15', '9876543312', 'EEE240012@college.edu', 'Hostler', FALSE, 'EEE', 'HOSB002', NULL),
('EEE240013', 'Rudra Chatterjee', 'Male', '2006-05-20', '9876543313', 'EEE240013@college.edu', 'Hostler', FALSE, 'EEE', 'HOSB002', NULL),
('EEE240014', 'Yashwant Rao', 'Male', '2006-06-25', '9876543314', 'EEE240014@college.edu', 'Hostler', FALSE, 'EEE', 'HOSB002', NULL),
('EEE240015', 'Nitin Goyal', 'Male', '2006-07-30', '9876543315', 'EEE240015@college.edu', 'Hostler', FALSE, 'EEE', 'HOSB002', NULL),
('EEE240016', 'Varun Pandey', 'Male', '2006-08-05', '9876543316', 'EEE240016@college.edu', 'Hostler', FALSE, 'EEE', 'HOSB002', NULL),
('EEE240017', 'Anmol Yadav', 'Male', '2006-09-10', '9876543317', 'EEE240017@college.edu', 'Hostler', FALSE, 'EEE', 'HOSB002', NULL),
('EEE240018', 'Kunal Thakur', 'Male', '2006-10-15', '9876543318', 'EEE240018@college.edu', 'Hostler', FALSE, 'EEE', 'HOSB002', NULL),
('EEE240019', 'Manish Kapoor', 'Male', '2006-11-20', '9876543319', 'EEE240019@college.edu', 'Hostler', FALSE, 'EEE', 'HOSB002', NULL);

-- HOSG001 - 7 Girls
INSERT INTO Students VALUES
('EEE240020', 'Nisha Gupta', 'Female', '2006-02-08', '9876543320', 'EEE240020@college.edu', 'Hostler', FALSE, 'EEE', NULL, 'HOSG001'),
('EEE240021', 'Sneha Menon', 'Female', '2006-03-12', '9876543321', 'EEE240021@college.edu', 'Hostler', FALSE, 'EEE', NULL, 'HOSG001'),
('EEE240022', 'Priya Sharma', 'Female', '2006-04-18', '9876543322', 'EEE240022@college.edu', 'Hostler', FALSE, 'EEE', NULL, 'HOSG001'),
('EEE240023', 'Tanisha Bose', 'Female', '2006-05-24', '9876543323', 'EEE240023@college.edu', 'Hostler', FALSE, 'EEE', NULL, 'HOSG001'),
('EEE240024', 'Simran Kaur', 'Female', '2006-06-30', '9876543324', 'EEE240024@college.edu', 'Hostler', FALSE, 'EEE', NULL, 'HOSG001'),
('EEE240025', 'Aditi Chawla', 'Female', '2006-07-07', '9876543325', 'EEE240025@college.edu', 'Hostler', FALSE, 'EEE', NULL, 'HOSG001'),
('EEE240026', 'Pooja Mishra', 'Female', '2006-08-14', '9876543326', 'EEE240026@college.edu', 'Hostler', FALSE, 'EEE', NULL, 'HOSG001');

-- HOSG002 - 9 Girls
INSERT INTO Students VALUES
('EEE240027', 'Ritika Saxena', 'Female', '2006-02-22', '9876543327', 'EEE240027@college.edu', 'Hostler', FALSE, 'EEE', NULL, 'HOSG002'),
('EEE240028', 'Sanya Kapoor', 'Female', '2006-03-30', '9876543328', 'EEE240028@college.edu', 'Hostler', FALSE, 'EEE', NULL, 'HOSG002'),
('EEE240029', 'Meghna Rao', 'Female', '2006-04-05', '9876543329', 'EEE240029@college.edu', 'Hostler', FALSE, 'EEE', NULL, 'HOSG002'),
('EEE240030', 'Ishani Tripathi', 'Female', '2006-05-10', '9876543330', 'EEE240030@college.edu', 'Hostler', FALSE, 'EEE', NULL, 'HOSG002'),
('EEE240031', 'Suhani Verma', 'Female', '2006-06-15', '9876543331', 'EEE240031@college.edu', 'Hostler', FALSE, 'EEE', NULL, 'HOSG002'),
('EEE240032', 'Neha Chauhan', 'Female', '2006-07-20', '9876543332', 'EEE240032@college.edu', 'Hostler', FALSE, 'EEE', NULL, 'HOSG002'),
('EEE240033', 'Rashmi Naidu', 'Female', '2006-08-25', '9876543333', 'EEE240033@college.edu', 'Hostler', FALSE, 'EEE', NULL, 'HOSG002'),
('EEE240034', 'Ira Bhat', 'Female', '2006-09-30', '9876543334', 'EEE240034@college.edu', 'Hostler', FALSE, 'EEE', NULL, 'HOSG002'),
('EEE240035', 'Diya Sen', 'Female', '2006-10-05', '9876543335', 'EEE240035@college.edu', 'Hostler', FALSE, 'EEE', NULL, 'HOSG002');

-- 9 Boys in HOSB001
INSERT INTO Students (student_id, name, gender, dob, contact_number, email, hostler_or_day, avails_bus, department_id, boys_hostel_id, girls_hostel_id) VALUES
('CIVIL240001', 'Aarav Sharma', 'Male', '2006-01-15', '9876544001', 'CIVIL240001@college.edu', 'Hostler', FALSE, 'CIVIL', 'HOSB001', NULL),
('CIVIL240002', 'Vivaan Verma', 'Male', '2006-02-18', '9876544002', 'CIVIL240002@college.edu', 'Hostler', FALSE, 'CIVIL', 'HOSB001', NULL),
('CIVIL240003', 'Rohan Malhotra', 'Male', '2006-03-10', '9876544003', 'CIVIL240003@college.edu', 'Hostler', FALSE, 'CIVIL', 'HOSB001', NULL),
('CIVIL240004', 'Kabir Khanna', 'Male', '2006-04-05', '9876544004', 'CIVIL240004@college.edu', 'Hostler', FALSE, 'CIVIL', 'HOSB001', NULL),
('CIVIL240005', 'Samar Mehta', 'Male', '2006-05-22', '9876544005', 'CIVIL240005@college.edu', 'Hostler', FALSE, 'CIVIL', 'HOSB001', NULL),
('CIVIL240006', 'Raghav Iyer', 'Male', '2006-06-30', '9876544006', 'CIVIL240006@college.edu', 'Hostler', FALSE, 'CIVIL', 'HOSB001', NULL),
('CIVIL240007', 'Aniket Joshi', 'Male', '2006-07-25', '9876544007', 'CIVIL240007@college.edu', 'Hostler', FALSE, 'CIVIL', 'HOSB001', NULL),
('CIVIL240008', 'Neel Ray', 'Male', '2006-08-17', '9876544008', 'CIVIL240008@college.edu', 'Hostler', FALSE, 'CIVIL', 'HOSB001', NULL),
('CIVIL240009', 'Harsh Choudhary', 'Male', '2006-09-05', '9876544009', 'CIVIL240009@college.edu', 'Hostler', FALSE, 'CIVIL', 'HOSB001', NULL);

-- 11 Boys in HOSB002
INSERT INTO Students VALUES
('CIVIL240010', 'Tanishq Sinha', 'Male', '2006-01-25', '9876544010', 'CIVIL240010@college.edu', 'Hostler', FALSE, 'CIVIL', 'HOSB002', NULL),
('CIVIL240011', 'Yug Kapoor', 'Male', '2006-02-15', '9876544011', 'CIVIL240011@college.edu', 'Hostler', FALSE, 'CIVIL', 'HOSB002', NULL),
('CIVIL240012', 'Ishaan Bakshi', 'Male', '2006-03-05', '9876544012', 'CIVIL240012@college.edu', 'Hostler', FALSE, 'CIVIL', 'HOSB002', NULL),
('CIVIL240013', 'Dev Patel', 'Male', '2006-04-18', '9876544013', 'CIVIL240013@college.edu', 'Hostler', FALSE, 'CIVIL', 'HOSB002', NULL),
('CIVIL240014', 'Manan Thakur', 'Male', '2006-05-30', '9876544014', 'CIVIL240014@college.edu', 'Hostler', FALSE, 'CIVIL', 'HOSB002', NULL),
('CIVIL240015', 'Arjun Rao', 'Male', '2006-06-10', '9876544015', 'CIVIL240015@college.edu', 'Hostler', FALSE, 'CIVIL', 'HOSB002', NULL),
('CIVIL240016', 'Shreyansh Sharma', 'Male', '2006-07-22', '9876544016', 'CIVIL240016@college.edu', 'Hostler', FALSE, 'CIVIL', 'HOSB002', NULL),
('CIVIL240017', 'Aayush Jain', 'Male', '2006-08-08', '9876544017', 'CIVIL240017@college.edu', 'Hostler', FALSE, 'CIVIL', 'HOSB002', NULL),
('CIVIL240018', 'Aditya Narayan', 'Male', '2006-09-14', '9876544018', 'CIVIL240018@college.edu', 'Hostler', FALSE, 'CIVIL', 'HOSB002', NULL),
('CIVIL240019', 'Daksh Kulkarni', 'Male', '2006-10-02', '9876544019', 'CIVIL240019@college.edu', 'Hostler', FALSE, 'CIVIL', 'HOSB002', NULL),
('CIVIL240020', 'Ritwik Chatterjee', 'Male', '2006-11-11', '9876544020', 'CIVIL240020@college.edu', 'Hostler', FALSE, 'CIVIL', 'HOSB002', NULL);

-- 8 Girls in HOSG001
INSERT INTO Students VALUES
('CIVIL240021', 'Ananya Mishra', 'Female', '2006-01-10', '9876544021', 'CIVIL240021@college.edu', 'Hostler', FALSE, 'CIVIL', NULL, 'HOSG001'),
('CIVIL240022', 'Suhani Kapoor', 'Female', '2006-02-22', '9876544022', 'CIVIL240022@college.edu', 'Hostler', FALSE, 'CIVIL', NULL, 'HOSG001'),
('CIVIL240023', 'Ishita Nair', 'Female', '2006-03-13', '9876544023', 'CIVIL240023@college.edu', 'Hostler', FALSE, 'CIVIL', NULL, 'HOSG001'),
('CIVIL240024', 'Simran Kaur', 'Female', '2006-04-25', '9876544024', 'CIVIL240024@college.edu', 'Hostler', FALSE, 'CIVIL', NULL, 'HOSG001'),
('CIVIL240025', 'Pooja Yadav', 'Female', '2006-05-30', '9876544025', 'CIVIL240025@college.edu', 'Hostler', FALSE, 'CIVIL', NULL, 'HOSG001'),
('CIVIL240026', 'Riya Sen', 'Female', '2006-06-17', '9876544026', 'CIVIL240026@college.edu', 'Hostler', FALSE, 'CIVIL', NULL, 'HOSG001'),
('CIVIL240027', 'Aditi Singh', 'Female', '2006-07-09', '9876544027', 'CIVIL240027@college.edu', 'Hostler', FALSE, 'CIVIL', NULL, 'HOSG001'),
('CIVIL240028', 'Priyanka Das', 'Female', '2006-08-05', '9876544028', 'CIVIL240028@college.edu', 'Hostler', FALSE, 'CIVIL', NULL, 'HOSG001');

INSERT INTO Students (student_id, name, gender, dob, contact_number, email, hostler_or_day, avails_bus, department_id, boys_hostel_id, girls_hostel_id) VALUES
('CIVIL240029', 'Neha Reddy', 'Female', '2006-01-28', '9876544029', 'CIVIL240029@college.edu', 'Hostler', FALSE, 'CIVIL', NULL, 'HOSG002'),
('CIVIL240030', 'Kavya Sharma', 'Female', '2006-02-14', '9876544030', 'CIVIL240030@college.edu', 'Hostler', FALSE, 'CIVIL', NULL, 'HOSG002'),
('CIVIL240031', 'Tanya Bhatt', 'Female', '2006-03-07', '9876544031', 'CIVIL240031@college.edu', 'Hostler', FALSE, 'CIVIL', NULL, 'HOSG002'),
('CIVIL240032', 'Ritika Menon', 'Female', '2006-04-11', '9876544032', 'CIVIL240032@college.edu', 'Hostler', FALSE, 'CIVIL', NULL, 'HOSG002'),
('CIVIL240033', 'Swati Pillai', 'Female', '2006-05-22', '9876544033', 'CIVIL240033@college.edu', 'Hostler', FALSE, 'CIVIL', NULL, 'HOSG002'),
('CIVIL240034', 'Nidhi Agarwal', 'Female', '2006-06-15', '9876544034', 'CIVIL240034@college.edu', 'Hostler', FALSE, 'CIVIL', NULL, 'HOSG002'),
('CIVIL240035', 'Sneha Deshmukh', 'Female', '2006-07-03', '9876544035', 'CIVIL240035@college.edu', 'Hostler', FALSE, 'CIVIL', NULL, 'HOSG002'),
('CIVIL240036', 'Anushka Bansal', 'Female', '2006-08-18', '9876544036', 'CIVIL240036@college.edu', 'Hostler', FALSE, 'CIVIL', NULL, 'HOSG002'),
('CIVIL240037', 'Pallavi Choudhary', 'Female', '2006-09-25', '9876544037', 'CIVIL240037@college.edu', 'Hostler', FALSE, 'CIVIL', NULL, 'HOSG002'),
('CIVIL240038', 'Megha Jain', 'Female', '2006-10-12', '9876544038', 'CIVIL240038@college.edu', 'Hostler', FALSE, 'CIVIL', NULL, 'HOSG002');

INSERT INTO Students (student_id, name, gender, dob, contact_number, email, hostler_or_day, avails_bus, department_id, boys_hostel_id, girls_hostel_id) VALUES
('CSE240037', 'Rahul Nair', 'Male', '2006-01-15', '9876544039', 'CSE240037@college.edu', 'Day Scholar', TRUE, 'CSE', NULL, NULL),
('CSE240038', 'Ananya Mishra', 'Female', '2006-02-22', '9876544040', 'CSE240038@college.edu', 'Day Scholar', FALSE, 'CSE', NULL, NULL),
('CSE240039', 'Varun Gupta', 'Male', '2006-03-10', '9876544041', 'CSE240039@college.edu', 'Day Scholar', FALSE, 'CSE', NULL, NULL),
('CSE240040', 'Simran Kaur', 'Female', '2006-04-05', '9876544042', 'CSE240040@college.edu', 'Day Scholar', TRUE, 'CSE', NULL, NULL),
('CSE240041', 'Kartik Iyer', 'Male', '2006-05-18', '9876544043', 'CSE240041@college.edu', 'Day Scholar', FALSE, 'CSE', NULL, NULL),
('CSE240042', 'Riya Sharma', 'Female', '2006-06-20', '9876544044', 'CSE240042@college.edu', 'Day Scholar', FALSE, 'CSE', NULL, NULL),
('CSE240043', 'Amit Verma', 'Male', '2006-07-07', '9876544045', 'CSE240043@college.edu', 'Day Scholar', TRUE, 'CSE', NULL, NULL),
('CSE240044', 'Priya Menon', 'Female', '2006-08-09', '9876544046', 'CSE240044@college.edu', 'Day Scholar', FALSE, 'CSE', NULL, NULL),
('CSE240045', 'Siddharth Rao', 'Male', '2006-09-12', '9876544047', 'CSE240045@college.edu', 'Day Scholar', FALSE, 'CSE', NULL, NULL),
('CSE240046', 'Megha Joshi', 'Female', '2006-10-30', '9876544048', 'CSE240046@college.edu', 'Day Scholar', TRUE, 'CSE', NULL, NULL),
('CSE240047', 'Rohit Das', 'Male', '2006-11-25', '9876544049', 'CSE240047@college.edu', 'Day Scholar', FALSE, 'CSE', NULL, NULL),
('CSE240048', 'Neha Kapoor', 'Female', '2006-12-05', '9876544050', 'CSE240048@college.edu', 'Day Scholar', FALSE, 'CSE', NULL, NULL),
('CSE240049', 'Arjun Reddy', 'Male', '2006-01-17', '9876544051', 'CSE240049@college.edu', 'Day Scholar', TRUE, 'CSE', NULL, NULL),
('CSE240050', 'Ishita Singh', 'Female', '2006-02-28', '9876544052', 'CSE240050@college.edu', 'Day Scholar', FALSE, 'CSE', NULL, NULL),
('CSE240051', 'Nikhil Jain', 'Male', '2006-03-19', '9876544053', 'CSE240051@college.edu', 'Day Scholar', FALSE, 'CSE', NULL, NULL),
('CSE240052', 'Sanya Bhatia', 'Female', '2006-04-22', '9876544054', 'CSE240052@college.edu', 'Day Scholar', TRUE, 'CSE', NULL, NULL),
('CSE240053', 'Vivek Saxena', 'Male', '2006-05-09', '9876544055', 'CSE240053@college.edu', 'Day Scholar', FALSE, 'CSE', NULL, NULL),
('CSE240054', 'Pooja Mehta', 'Female', '2006-06-14', '9876544056', 'CSE240054@college.edu', 'Day Scholar', FALSE, 'CSE', NULL, NULL),
('CSE240055', 'Rohan Kulkarni', 'Male', '2006-07-11', '9876544057', 'CSE240055@college.edu', 'Day Scholar', TRUE, 'CSE', NULL, NULL),
('CSE240056', 'Tanya Goel', 'Female', '2006-08-08', '9876544058', 'CSE240056@college.edu', 'Day Scholar', FALSE, 'CSE', NULL, NULL),
('CSE240057', 'Manoj Desai', 'Male', '2006-09-03', '9876544059', 'CSE240057@college.edu', 'Day Scholar', FALSE, 'CSE', NULL, NULL),
('CSE240058', 'Divya Malhotra', 'Female', '2006-10-06', '9876544060', 'CSE240058@college.edu', 'Day Scholar', TRUE, 'CSE', NULL, NULL),
('CSE240059', 'Rajat Kumar', 'Male', '2006-11-15', '9876544061', 'CSE240059@college.edu', 'Day Scholar', FALSE, 'CSE', NULL, NULL),
('CSE240060', 'Kritika Chawla', 'Female', '2006-12-20', '9876544062', 'CSE240060@college.edu', 'Day Scholar', FALSE, 'CSE', NULL, NULL);

INSERT INTO Students (student_id, name, gender, dob, contact_number, email, hostler_or_day, avails_bus, department_id, boys_hostel_id, girls_hostel_id) VALUES
('ECE240037', 'Aarav Bansal', 'Male', '2006-01-11', '9876544063', 'ECE240037@college.edu', 'Day Scholar', TRUE, 'ECE', NULL, NULL),
('ECE240038', 'Sneha Pillai', 'Female', '2006-02-14', '9876544064', 'ECE240038@college.edu', 'Day Scholar', FALSE, 'ECE', NULL, NULL),
('ECE240039', 'Rohan Khanna', 'Male', '2006-03-19', '9876544065', 'ECE240039@college.edu', 'Day Scholar', FALSE, 'ECE', NULL, NULL),
('ECE240040', 'Meera Sinha', 'Female', '2006-04-28', '9876544066', 'ECE240040@college.edu', 'Day Scholar', TRUE, 'ECE', NULL, NULL),
('ECE240041', 'Vikram Das', 'Male', '2006-05-15', '9876544067', 'ECE240041@college.edu', 'Day Scholar', FALSE, 'ECE', NULL, NULL),
('ECE240042', 'Ankita Verma', 'Female', '2006-06-22', '9876544068', 'ECE240042@college.edu', 'Day Scholar', FALSE, 'ECE', NULL, NULL),
('ECE240043', 'Harsh Mehta', 'Male', '2006-07-05', '9876544069', 'ECE240043@college.edu', 'Day Scholar', TRUE, 'ECE', NULL, NULL),
('ECE240044', 'Tanya Roy', 'Female', '2006-08-09', '9876544070', 'ECE240044@college.edu', 'Day Scholar', FALSE, 'ECE', NULL, NULL),
('ECE240045', 'Siddharth Joshi', 'Male', '2006-09-16', '9876544071', 'ECE240045@college.edu', 'Day Scholar', FALSE, 'ECE', NULL, NULL),
('ECE240046', 'Neha Chopra', 'Female', '2006-10-30', '9876544072', 'ECE240046@college.edu', 'Day Scholar', TRUE, 'ECE', NULL, NULL),
('ECE240047', 'Karthik Reddy', 'Male', '2006-11-25', '9876544073', 'ECE240047@college.edu', 'Day Scholar', FALSE, 'ECE', NULL, NULL),
('ECE240048', 'Ritu Sharma', 'Female', '2006-12-06', '9876544074', 'ECE240048@college.edu', 'Day Scholar', FALSE, 'ECE', NULL, NULL),
('ECE240049', 'Aryan Kumar', 'Male', '2006-01-13', '9876544075', 'ECE240049@college.edu', 'Day Scholar', TRUE, 'ECE', NULL, NULL),
('ECE240050', 'Simran Kaur', 'Female', '2006-02-28', '9876544076', 'ECE240050@college.edu', 'Day Scholar', FALSE, 'ECE', NULL, NULL),
('ECE240051', 'Manoj Deshmukh', 'Male', '2006-03-19', '9876544077', 'ECE240051@college.edu', 'Day Scholar', FALSE, 'ECE', NULL, NULL),
('ECE240052', 'Aisha Siddiqui', 'Female', '2006-04-22', '9876544078', 'ECE240052@college.edu', 'Day Scholar', TRUE, 'ECE', NULL, NULL),
('ECE240053', 'Vivek Agarwal', 'Male', '2006-05-09', '9876544079', 'ECE240053@college.edu', 'Day Scholar', FALSE, 'ECE', NULL, NULL),
('ECE240054', 'Sonia Malhotra', 'Female', '2006-06-14', '9876544080', 'ECE240054@college.edu', 'Day Scholar', FALSE, 'ECE', NULL, NULL),
('ECE240055', 'Rohan Kulkarni', 'Male', '2006-07-11', '9876544081', 'ECE240055@college.edu', 'Day Scholar', TRUE, 'ECE', NULL, NULL),
('ECE240056', 'Tanvi Goel', 'Female', '2006-08-08', '9876544082', 'ECE240056@college.edu', 'Day Scholar', FALSE, 'ECE', NULL, NULL),
('ECE240057', 'Amit Patil', 'Male', '2006-09-03', '9876544083', 'ECE240057@college.edu', 'Day Scholar', FALSE, 'ECE', NULL, NULL),
('ECE240058', 'Divya Mahajan', 'Female', '2006-10-06', '9876544084', 'ECE240058@college.edu', 'Day Scholar', TRUE, 'ECE', NULL, NULL),
('ECE240059', 'Rajat Kapoor', 'Male', '2006-11-15', '9876544085', 'ECE240059@college.edu', 'Day Scholar', FALSE, 'ECE', NULL, NULL),
('ECE240060', 'Kritika Chawla', 'Female', '2006-12-20', '9876544086', 'ECE240060@college.edu', 'Day Scholar', FALSE, 'ECE', NULL, NULL);

INSERT INTO Students (student_id, name, gender, dob, contact_number, email, hostler_or_day, avails_bus, department_id, boys_hostel_id, girls_hostel_id) VALUES
('MECH240037', 'Ankit Sharma', 'Male', '2006-01-10', '9876544101', 'MECH240037@college.edu', 'Day Scholar', TRUE, 'MECH', NULL, NULL),
('MECH240038', 'Priya Iyer', 'Female', '2006-02-15', '9876544102', 'MECH240038@college.edu', 'Day Scholar', FALSE, 'MECH', NULL, NULL),
('MECH240039', 'Ravi Patel', 'Male', '2006-03-20', '9876544103', 'MECH240039@college.edu', 'Day Scholar', FALSE, 'MECH', NULL, NULL),
('MECH240040', 'Swati Joshi', 'Female', '2006-04-25', '9876544104', 'MECH240040@college.edu', 'Day Scholar', TRUE, 'MECH', NULL, NULL),
('MECH240041', 'Sandeep Reddy', 'Male', '2006-05-12', '9876544105', 'MECH240041@college.edu', 'Day Scholar', FALSE, 'MECH', NULL, NULL),
('MECH240042', 'Neha Kulkarni', 'Female', '2006-06-30', '9876544106', 'MECH240042@college.edu', 'Day Scholar', FALSE, 'MECH', NULL, NULL),
('MECH240043', 'Amit Khurana', 'Male', '2006-07-05', '9876544107', 'MECH240043@college.edu', 'Day Scholar', TRUE, 'MECH', NULL, NULL),
('MECH240044', 'Tanisha Mehta', 'Female', '2006-08-08', '9876544108', 'MECH240044@college.edu', 'Day Scholar', FALSE, 'MECH', NULL, NULL),
('MECH240045', 'Varun Bhatia', 'Male', '2006-09-17', '9876544109', 'MECH240045@college.edu', 'Day Scholar', FALSE, 'MECH', NULL, NULL),
('MECH240046', 'Ritika Anand', 'Female', '2006-10-24', '9876544110', 'MECH240046@college.edu', 'Day Scholar', TRUE, 'MECH', NULL, NULL),
('MECH240047', 'Karthik Nair', 'Male', '2006-11-19', '9876544111', 'MECH240047@college.edu', 'Day Scholar', FALSE, 'MECH', NULL, NULL),
('MECH240048', 'Pooja Singh', 'Female', '2006-12-10', '9876544112', 'MECH240048@college.edu', 'Day Scholar', FALSE, 'MECH', NULL, NULL),
('MECH240049', 'Arjun Deshmukh', 'Male', '2006-01-14', '9876544113', 'MECH240049@college.edu', 'Day Scholar', TRUE, 'MECH', NULL, NULL),
('MECH240050', 'Sneha Kapoor', 'Female', '2006-02-26', '9876544114', 'MECH240050@college.edu', 'Day Scholar', FALSE, 'MECH', NULL, NULL),
('MECH240051', 'Rahul Saxena', 'Male', '2006-03-21', '9876544115', 'MECH240051@college.edu', 'Day Scholar', FALSE, 'MECH', NULL, NULL),
('MECH240052', 'Aishwarya Gupta', 'Female', '2006-04-29', '9876544116', 'MECH240052@college.edu', 'Day Scholar', TRUE, 'MECH', NULL, NULL),
('MECH240053', 'Vivek Yadav', 'Male', '2006-05-07', '9876544117', 'MECH240053@college.edu', 'Day Scholar', FALSE, 'MECH', NULL, NULL),
('MECH240054', 'Sonia Malhotra', 'Female', '2006-06-12', '9876544118', 'MECH240054@college.edu', 'Day Scholar', FALSE, 'MECH', NULL, NULL),
('MECH240055', 'Rohan Kulkarni', 'Male', '2006-07-09', '9876544119', 'MECH240055@college.edu', 'Day Scholar', TRUE, 'MECH', NULL, NULL),
('MECH240056', 'Tanvi Goel', 'Female', '2006-08-05', '9876544120', 'MECH240056@college.edu', 'Day Scholar', FALSE, 'MECH', NULL, NULL),
('MECH240057', 'Amit Patil', 'Male', '2006-09-02', '9876544121', 'MECH240057@college.edu', 'Day Scholar', FALSE, 'MECH', NULL, NULL),
('MECH240058', 'Divya Mahajan', 'Female', '2006-10-07', '9876544122', 'MECH240058@college.edu', 'Day Scholar', TRUE, 'MECH', NULL, NULL),
('MECH240059', 'Rajat Kapoor', 'Male', '2006-11-16', '9876544123', 'MECH240059@college.edu', 'Day Scholar', FALSE, 'MECH', NULL, NULL),
('MECH240060', 'Kritika Chawla', 'Female', '2006-12-18', '9876544124', 'MECH240060@college.edu', 'Day Scholar', FALSE, 'MECH', NULL, NULL);

INSERT INTO Students (student_id, name, gender, dob, contact_number, email, hostler_or_day, avails_bus, department_id, boys_hostel_id, girls_hostel_id) VALUES
('EEE240036', 'Akash Verma', 'Male', '2006-01-05', '9876544201', 'EEE240036@college.edu', 'Day Scholar', TRUE, 'EEE', NULL, NULL),
('EEE240037', 'Neha Sharma', 'Female', '2006-02-10', '9876544202', 'EEE240037@college.edu', 'Day Scholar', FALSE, 'EEE', NULL, NULL),
('EEE240038', 'Rohan Das', 'Male', '2006-03-15', '9876544203', 'EEE240038@college.edu', 'Day Scholar', FALSE, 'EEE', NULL, NULL),
('EEE240039', 'Simran Kaur', 'Female', '2006-04-20', '9876544204', 'EEE240039@college.edu', 'Day Scholar', TRUE, 'EEE', NULL, NULL),
('EEE240040', 'Vikas Mehta', 'Male', '2006-05-12', '9876544205', 'EEE240040@college.edu', 'Day Scholar', FALSE, 'EEE', NULL, NULL),
('EEE240041', 'Ananya Gupta', 'Female', '2006-06-18', '9876544206', 'EEE240041@college.edu', 'Day Scholar', FALSE, 'EEE', NULL, NULL),
('EEE240042', 'Rahul Nair', 'Male', '2006-07-22', '9876544207', 'EEE240042@college.edu', 'Day Scholar', TRUE, 'EEE', NULL, NULL),
('EEE240043', 'Sanya Kapoor', 'Female', '2006-08-08', '9876544208', 'EEE240043@college.edu', 'Day Scholar', FALSE, 'EEE', NULL, NULL),
('EEE240044', 'Varun Joshi', 'Male', '2006-09-14', '9876544209', 'EEE240044@college.edu', 'Day Scholar', FALSE, 'EEE', NULL, NULL),
('EEE240045', 'Megha Reddy', 'Female', '2006-10-30', '9876544210', 'EEE240045@college.edu', 'Day Scholar', TRUE, 'EEE', NULL, NULL),
('EEE240046', 'Rajat Malhotra', 'Male', '2006-11-25', '9876544211', 'EEE240046@college.edu', 'Day Scholar', FALSE, 'EEE', NULL, NULL),
('EEE240047', 'Kritika Jain', 'Female', '2006-12-05', '9876544212', 'EEE240047@college.edu', 'Day Scholar', FALSE, 'EEE', NULL, NULL),
('EEE240048', 'Siddharth Bansal', 'Male', '2006-01-14', '9876544213', 'EEE240048@college.edu', 'Day Scholar', TRUE, 'EEE', NULL, NULL),
('EEE240049', 'Aditi Saxena', 'Female', '2006-02-26', '9876544214', 'EEE240049@college.edu', 'Day Scholar', FALSE, 'EEE', NULL, NULL),
('EEE240050', 'Rohan Kulkarni', 'Male', '2006-03-21', '9876544215', 'EEE240050@college.edu', 'Day Scholar', FALSE, 'EEE', NULL, NULL),
('EEE240051', 'Pooja Mahajan', 'Female', '2006-04-29', '9876544216', 'EEE240051@college.edu', 'Day Scholar', TRUE, 'EEE', NULL, NULL),
('EEE240052', 'Vivek Yadav', 'Male', '2006-05-07', '9876544217', 'EEE240052@college.edu', 'Day Scholar', FALSE, 'EEE', NULL, NULL),
('EEE240053', 'Sneha Kapoor', 'Female', '2006-06-12', '9876544218', 'EEE240053@college.edu', 'Day Scholar', FALSE, 'EEE', NULL, NULL),
('EEE240054', 'Arjun Desai', 'Male', '2006-07-09', '9876544219', 'EEE240054@college.edu', 'Day Scholar', TRUE, 'EEE', NULL, NULL),
('EEE240055', 'Tanvi Goel', 'Female', '2006-08-05', '9876544220', 'EEE240055@college.edu', 'Day Scholar', FALSE, 'EEE', NULL, NULL),
('EEE240056', 'Amit Patil', 'Male', '2006-09-02', '9876544221', 'EEE240056@college.edu', 'Day Scholar', FALSE, 'EEE', NULL, NULL),
('EEE240057', 'Divya Chawla', 'Female', '2006-10-07', '9876544222', 'EEE240057@college.edu', 'Day Scholar', TRUE, 'EEE', NULL, NULL),
('EEE240058', 'Rajat Kapoor', 'Male', '2006-11-16', '9876544223', 'EEE240058@college.edu', 'Day Scholar', FALSE, 'EEE', NULL, NULL),
('EEE240059', 'Kritika Arora', 'Female', '2006-12-18', '9876544224', 'EEE240059@college.edu', 'Day Scholar', FALSE, 'EEE', NULL, NULL),
('EEE240060', 'Riya Mehta', 'Female', '2006-01-28', '9876544225', 'EEE240060@college.edu', 'Day Scholar', FALSE, 'EEE', NULL, NULL);

INSERT INTO Students (student_id, name, gender, dob, contact_number, email, hostler_or_day, avails_bus, department_id, boys_hostel_id, girls_hostel_id) VALUES
('CIVIL240039', 'Rahul Verma', 'Male', '2005-03-15', '9876545101', 'CIV240039@college.edu', 'Day Scholar', TRUE, 'CIVIL', NULL, NULL),
('CIVIL240040', 'Ananya Sharma', 'Female', '2006-06-20', '9876545102', 'CIV240040@college.edu', 'Day Scholar', FALSE, 'CIVIL', NULL, NULL),
('CIVIL240041', 'Kunal Gupta', 'Male', '2005-08-25', '9876545103', 'CIV240041@college.edu', 'Day Scholar', FALSE, 'CIVIL', NULL, NULL),
('CIVIL240042', 'Meera Iyer', 'Female', '2006-04-12', '9876545104', 'CIV240042@college.edu', 'Day Scholar', TRUE, 'CIVIL', NULL, NULL),
('CIVIL240043', 'Varun Yadav', 'Male', '2005-09-10', '9876545105', 'CIV240043@college.edu', 'Day Scholar', FALSE, 'CIVIL', NULL, NULL),
('CIVIL240044', 'Priya Nair', 'Female', '2006-07-05', '9876545106', 'CIV240044@college.edu', 'Day Scholar', FALSE, 'CIVIL', NULL, NULL),
('CIVIL240045', 'Amit Tiwari', 'Male', '2005-11-22', '9876545107', 'CIV240045@college.edu', 'Day Scholar', TRUE, 'CIVIL', NULL, NULL),
('CIVIL240046', 'Sonia Patel', 'Female', '2006-10-10', '9876545108', 'CIV240046@college.edu', 'Day Scholar', FALSE, 'CIVIL', NULL, NULL),
('CIVIL240047', 'Nikhil Reddy', 'Male', '2005-12-15', '9876545109', 'CIV240047@college.edu', 'Day Scholar', FALSE, 'CIVIL', NULL, NULL),
('CIVIL240048', 'Divya Menon', 'Female', '2006-08-18', '9876545110', 'CIV240048@college.edu', 'Day Scholar', TRUE, 'CIVIL', NULL, NULL),
('CIVIL240049', 'Rohan Das', 'Male', '2005-06-25', '9876545111', 'CIV240049@college.edu', 'Day Scholar', FALSE, 'CIVIL', NULL, NULL),
('CIVIL240050', 'Neha Bansal', 'Female', '2006-12-05', '9876545112', 'CIV240050@college.edu', 'Day Scholar', FALSE, 'CIVIL', NULL, NULL),
('CIVIL240051', 'Saurabh Joshi', 'Male', '2005-07-30', '9876545113', 'CIV240051@college.edu', 'Day Scholar', TRUE, 'CIVIL', NULL, NULL),
('CIVIL240052', 'Kavita Rao', 'Female', '2006-09-22', '9876545114', 'CIV240052@college.edu', 'Day Scholar', FALSE, 'CIVIL', NULL, NULL),
('CIVIL240053', 'Arjun Malhotra', 'Male', '2005-10-08', '9876545115', 'CIV240053@college.edu', 'Day Scholar', FALSE, 'CIVIL', NULL, NULL),
('CIVIL240054', 'Ritika Shah', 'Female', '2006-05-28', '9876545116', 'CIV240054@college.edu', 'Day Scholar', TRUE, 'CIVIL', NULL, NULL),
('CIVIL240055', 'Deepak Kumar', 'Male', '2005-02-18', '9876545117', 'CIV240055@college.edu', 'Day Scholar', FALSE, 'CIVIL', NULL, NULL),
('CIVIL240056', 'Meghna Sinha', 'Female', '2006-03-14', '9876545118', 'CIV240056@college.edu', 'Day Scholar', FALSE, 'CIVIL', NULL, NULL),
('CIVIL240057', 'Pranav Dixit', 'Male', '2005-01-29', '9876545119', 'CIV240057@college.edu', 'Day Scholar', TRUE, 'CIVIL', NULL, NULL),
('CIVIL240058', 'Swati Agarwal', 'Female', '2006-06-10', '9876545120', 'CIV240058@college.edu', 'Day Scholar', FALSE, 'CIVIL', NULL, NULL),
('CIVIL240059', 'Vivek Chauhan', 'Male', '2005-07-17', '9876545121', 'CIV240059@college.edu', 'Day Scholar', FALSE, 'CIVIL', NULL, NULL),
('CIVIL240060', 'Ishita Kapoor', 'Female', '2006-11-01', '9876545122', 'CIV240060@college.edu', 'Day Scholar', TRUE, 'CIVIL', NULL, NULL);

INSERT INTO Office_Staff (staff_id, name, position, contact_number, email, salary_id) VALUES
    ('OFFICE0001', 'Jayanth ', 'Chief Administrator', '9876543201', 'office0001@college.edu', 'SAL3027'),
    ('OFFICE0002', 'Dharneesh ', 'Chief Administrator', '9876543202', 'office0002@college.edu', 'SAL3028'),
    ('OFFICE0003', 'Vishal', 'Chief Administrator', '9876543203', 'office0003@college.edu', 'SAL3029');

INSERT INTO Users (user_id, password, role, student_id)
SELECT student_id, CONCAT('pass', student_id), 'Student', student_id FROM Students;


INSERT INTO Users (user_id, password, role, warden_id, student_id, staff_id, department_head_id, instructor_id)
SELECT warden_id, CONCAT('pass', warden_id), 'Hostel Warden', warden_id, NULL, NULL, NULL, NULL FROM Hostel_Wardens;
INSERT INTO Users (user_id, password, role, staff_id, student_id, warden_id, department_head_id, instructor_id) 
SELECT staff_id, CONCAT('pass', staff_id), 'Office Staff', staff_id, NULL, NULL, NULL, NULL FROM Office_Staff;

INSERT INTO Users (user_id, password, role, department_head_id, student_id, staff_id, warden_id, instructor_id) 
SELECT department_head_id, CONCAT('pass', department_head_id), 'Department Head', department_head_id, NULL, NULL, NULL, NULL 
FROM Department_Heads;

INSERT INTO Users (user_id, password, role, instructor_id, student_id, staff_id, warden_id, department_head_id) 
SELECT instructor_id, CONCAT('pass', instructor_id), 'Instructor', instructor_id, NULL, NULL, NULL, NULL 
FROM Instructors;

INSERT INTO Sports (student_id, sport_name, team_position)
SELECT student_id, 'Cricket', 
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY gender ORDER BY RAND()) = 1 THEN 'Captain'
        WHEN RAND() < 0.2 THEN 'Bowler'
        WHEN RAND() < 0.4 THEN 'Batsman'
        ELSE 'All-Rounder'
    END
FROM Students 
WHERE gender = 'Male'
ORDER BY RAND()
LIMIT 15;

INSERT INTO Sports (student_id, sport_name, team_position)
SELECT student_id, 'Cricket', 
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY gender ORDER BY RAND()) = 1 THEN 'Captain'
        WHEN RAND() < 0.2 THEN 'Bowler'
        WHEN RAND() < 0.4 THEN 'Batsman'
        ELSE 'All-Rounder'
    END
FROM Students 
WHERE gender = 'Female'
ORDER BY RAND()
LIMIT 15;

INSERT INTO Sports (student_id, sport_name, team_position)
SELECT student_id, 'Football', 
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY gender ORDER BY RAND()) = 1 THEN 'Captain'
        WHEN RAND() < 0.2 THEN 'Goalkeeper'
        WHEN RAND() < 0.4 THEN 'Defender'
        ELSE 'Midfielder'
    END
FROM Students 
WHERE gender = 'Male'
ORDER BY RAND()
LIMIT 15;

INSERT INTO Sports (student_id, sport_name, team_position)
SELECT student_id, 'Football', 
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY gender ORDER BY RAND()) = 1 THEN 'Captain'
        WHEN RAND() < 0.2 THEN 'Goalkeeper'
        WHEN RAND() < 0.4 THEN 'Defender'
        ELSE 'Midfielder'
    END
FROM Students 
WHERE gender = 'Female'
ORDER BY RAND()
LIMIT 15;

INSERT INTO Sports (student_id, sport_name, team_position)
SELECT student_id, 'Volleyball', 
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY gender ORDER BY RAND()) = 1 THEN 'Captain'
        WHEN RAND() < 0.3 THEN 'Spiker'
        WHEN RAND() < 0.6 THEN 'Blocker'
        ELSE 'Setter'
    END
FROM Students 
WHERE gender = 'Male'
ORDER BY RAND()
LIMIT 10;

INSERT INTO Sports (student_id, sport_name, team_position)
SELECT student_id, 'Volleyball', 
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY gender ORDER BY RAND()) = 1 THEN 'Captain'
        WHEN RAND() < 0.3 THEN 'Spiker'
        WHEN RAND() < 0.6 THEN 'Blocker'
        ELSE 'Setter'
    END
FROM Students 
WHERE gender = 'Female'
ORDER BY RAND()
LIMIT 10;
ALTER TABLE Grades MODIFY COLUMN grade_id VARCHAR(50);

INSERT INTO Grades (grade_id, student_id, course_id, total_course_credits, grade)
SELECT 
    CONCAT(student_id, '_', course_id) AS grade_id,
    student_id,
    course_id,
    total_credits,
    ELT(FLOOR(1 + (RAND() * 9)), 'F', 'P', 'C', 'C+', 'B', 'B+', 'A', 'A+', 'O') AS grade
FROM Students 
JOIN Courses ON Students.department_id = Courses.department_id;

INSERT INTO Pass_Requests (pass_id, student_id, pass_type, start_date, end_date, approval_status)
SELECT  
    CONCAT(student_id, 'PASS', LPAD(FLOOR(1000 + RAND() * 9000), 4, '0')) AS pass_id,  -- Unique pass ID  
    student_id,  
    pass_type,  
    start_date,  
    CASE  
        WHEN pass_type = 'Home' THEN DATE_ADD(start_date, INTERVAL 5 DAY)  
        ELSE DATE_ADD(start_date, INTERVAL 1 DAY)  
    END AS end_date,  
    ELT(FLOOR(1 + (RAND() * 3)), 'Pending', 'Approved', 'Rejected') AS approval_status  -- Random status  
FROM (  
    SELECT  
        student_id,  
        CASE WHEN RAND() < 0.5 THEN 'Home' ELSE 'City' END AS pass_type,  
        DATE(CONCAT('2025-', LPAD(FLOOR(1 + RAND() * 12), 2, '0'), '-', LPAD(FLOOR(1 + RAND() * 28), 2, '0'))) AS start_date  
    FROM Students  
    WHERE hostler_or_day = 'Hostler'  
    ORDER BY RAND()  
    LIMIT 60  -- Select 60 unique students  
) AS temp;


INSERT INTO Hostel_Payments (payment_id, student_id, hostel_fee_paid, mess_fee_paid, payment_date, payment_due_date)
SELECT 
    CONCAT(student_id, '_HOSPAY') AS payment_id, 
    student_id,
    CASE WHEN RAND() < 0.7 THEN 50000 ELSE 0 END AS hostel_fee_paid,  -- 70% chance of full payment
    CASE WHEN RAND() < 0.8 THEN 10000 ELSE 0 END AS mess_fee_paid,  -- 80% chance of full payment
    DATE_SUB('2025-04-01', INTERVAL FLOOR(RAND() * 30) DAY) AS payment_date, -- Random date before due date
    '2025-04-01' AS payment_due_date -- Fixed due date
FROM Students
WHERE hostler_or_day = 'Hostler';

INSERT INTO Education_Payments (payment_id, student_id, tuition_fee_paid, payment_date, payment_due_date, payment_type)
SELECT 
    CONCAT(student_id, '_EDUPAY') AS payment_id, 
    student_id,
    CASE WHEN RAND() < 0.75 THEN 150000 ELSE 0 END AS tuition_fee_paid, -- 75% chance of full payment
    DATE_SUB('2025-06-01', INTERVAL FLOOR(RAND() * 30) DAY) AS payment_date, -- Random date before due date
    '2025-06-01' AS payment_due_date, -- Fixed due date
    'Tuition'
FROM Students;

INSERT INTO Day_Scholar_Payments (payment_id, student_id, bus_fee_paid, payment_date, payment_due_date, payment_type)
SELECT 
    CONCAT(student_id, '_BUSPAY') AS payment_id, 
    student_id,
    CASE WHEN RAND() < 0.6 THEN 40000 ELSE 0 END AS bus_fee_paid, -- 60% chance of full payment
    DATE_SUB('2025-03-01', INTERVAL FLOOR(RAND() * 30) DAY) AS payment_date, -- Random date before due date
    '2025-03-01' AS payment_due_date, -- Fixed due date
    'Bus'
FROM Students
WHERE avails_bus = 1;  -- Only students who avail the bus


INSERT INTO Hostel_Allocations (allocation_id, student_id, boys_hostel_id, girls_hostel_id, room_number, allocation_date)
SELECT 
    CONCAT(student_id, '_HOSALLOC') AS allocation_id, 
    student_id,
    CASE WHEN gender = 'Male' THEN boys_hostel_id ELSE NULL END AS boys_hostel_id,
    CASE WHEN gender = 'Female' THEN girls_hostel_id ELSE NULL END AS girls_hostel_id,
    LPAD(CEIL(ROW_NUMBER() OVER (PARTITION BY COALESCE(boys_hostel_id, girls_hostel_id) ORDER BY RAND()) / 2), 2, '0') AS room_number, 
    CURDATE() AS allocation_date
FROM Students
WHERE hostler_or_day = 'Hostler';




-- Retrieve all records from each table
SELECT * FROM Department;
SELECT * FROM Department_Heads;
SELECT * FROM Courses;
SELECT * FROM Instructors;
SELECT * FROM Boys_Hostel;
SELECT * FROM Girls_Hostel;
SELECT * FROM Hostel_Wardens;
SELECT * FROM Students;
SELECT * FROM Office_Staff;
SELECT * FROM Salary;
SELECT * FROM Users;
SELECT * FROM Sports;
SELECT * FROM Grades;
SELECT * FROM Pass_Requests;
SELECT * FROM Hostel_Payments;
SELECT * FROM Education_Payments;
SELECT * FROM Day_Scholar_Payments;
SELECT * FROM Hostel_Allocations;