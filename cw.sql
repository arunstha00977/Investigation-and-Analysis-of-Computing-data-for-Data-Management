CREATE DATABASE IF NOT EXISTS CollegeClubs;
USE CollegeClubs;

CREATE TABLE IF NOT EXISTS Student (
    StudentID   INT          NOT NULL AUTO_INCREMENT,
    StudentName VARCHAR(100) NOT NULL,
    Email       VARCHAR(150) NOT NULL UNIQUE,
    PRIMARY KEY (StudentID)
);

CREATE TABLE IF NOT EXISTS Club (
    ClubID     VARCHAR(5)   NOT NULL,
    ClubName   VARCHAR(100) NOT NULL,
    ClubRoom   VARCHAR(50),
    ClubMentor VARCHAR(100),
    PRIMARY KEY (ClubID)
);

CREATE TABLE IF NOT EXISTS Membership (
    MembershipID INT        NOT NULL AUTO_INCREMENT,
    StudentID    INT        NOT NULL,
    ClubID       VARCHAR(5) NOT NULL,
    JoinDate     DATE       NOT NULL,
    PRIMARY KEY (MembershipID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ClubID) REFERENCES Club(ClubID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Step 3: Insert all original Club data

INSERT INTO Club (ClubID, ClubName, ClubRoom, ClubMentor) VALUES
('C01', 'Music Club',  'R101', 'Mr. Raman'),
('C02', 'Sports Club', 'R202', 'Ms. Sita'),
('C03', 'Drama Club',  'R303', 'Mr. Kiran'),
('C04', 'Coding Club', 'Lab1', 'Mr. Anil');

-- Step 4: Insert all original Student data

INSERT INTO Student (StudentID, StudentName, Email) VALUES
(1, 'Asha',   'asha@email.com'),
(2, 'Bikash', 'bikash@email.com'),
(3, 'Nisha',  'nisha@email.com'),
(4, 'Rohan',  'rohan@email.com'),
(5, 'Suman',  'suman@email.com'),
(6, 'Pooja',  'pooja@email.com'),
(7, 'Aman',   'aman@email.com');

-- Step 5: Insert all original Membership data

INSERT INTO Membership (StudentID, ClubID, JoinDate) VALUES
(1, 'C01', '2024-01-10'),
(1, 'C02', '2024-01-12'),
(2, 'C01', '2024-01-22'),
(2, 'C03', '2024-01-25'),
(3, 'C02', '2024-01-15'),
(3, 'C04', '2024-01-27'),
(4, 'C03', '2024-01-20'),
(5, 'C01', '2024-01-18'),
(6, 'C02', '2024-01-30'),
(7, 'C04', '2024-01-28');

-- Step 6: Add NEW student

INSERT INTO Student (StudentName, Email)
VALUES ('Priya', 'priya@email.com');



-- Enroll Priya in Music Club and Sports Club
INSERT INTO Membership (StudentID, ClubID, JoinDate)
VALUES (LAST_INSERT_ID(), 'C01', '2024-02-01');

INSERT INTO Membership (StudentID, ClubID, JoinDate)
VALUES (LAST_INSERT_ID(), 'C02', '2024-02-01');



-- Step 7: View all Students

SELECT * FROM Student;

-- Step 8: View all Clubs

SELECT * FROM Club;

-- Step 9: View all Memberships with JOIN

SELECT
    s.StudentID,
    s.StudentName,
    s.Email,
    c.ClubName,
    c.ClubRoom,
    c.ClubMentor,
    m.JoinDate
FROM
    Membership m
    JOIN Student s ON m.StudentID = s.StudentID
    JOIN Club    c ON m.ClubID    = c.ClubID
ORDER BY
    s.StudentID, m.JoinDate;

-- Step 10: View only the NEW student Priya

SELECT
    s.StudentID,
    s.StudentName,
    s.Email,
    c.ClubName,
    m.JoinDate
FROM
    Membership m
    JOIN Student s ON m.StudentID = s.StudentID
    JOIN Club    c ON m.ClubID    = c.ClubID
WHERE
    s.StudentName = 'Priya';