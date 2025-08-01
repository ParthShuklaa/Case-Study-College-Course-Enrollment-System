CREate Database CollegeDB;
Use CollegeDB;

Create TABLE Student(
StudentID INT Primary key,
FullNAME VARCHAR(100) NOT NULL, 
Email VARCHAR(100) Unique NOT NULL,
Age INT CHECK( AGE >= 18)
);

CREATE TABLE Instructor(
InstructorID INT Primary KEY,
FullName VARCHAR(100),
Email VARCHAR(100) UNIQUE
);




Create TABLE Course(
courseID INT PRIMARY KEY,
FullName VARCHAR(100),
Email VARCHAR(100) UNIQUE
);
Drop Table Course; -- Dropping table will not work as F.K is implemented 
DROP Table Enrollment;

Create Table Course(
CourseID INT PRIMARY KEY,
CourseName VARCHAR(100),
InstructorID INT,
Foreign KEY (InstructorID) References Instructor( InstructorID)
);
Create TABLE Enrollment(
EnrollmentID int Primary Key,
StudentID INT,
CourseID INT,
EnrollmentDate Date Default GETDATE(),
FOREIGN KEY(StudentID) REFERENCES Student(StudentID),
FOREIGN KEY(CourseID) REFERENCES Course(CourseID)
);


-- Inserting in to above tables 
INSERT INTO Instructor VALUES(1,'Dr. Smith','Smith@gmail.com');

INSERT INTO Instructor VALUES(2,'Prof Mani','Mani@gmail.com');

-- inserting into course table 
INSERT inTO Course VALUES(101,'Data Science',1);

INSERT inTO Course VALUES(102,'.NET FSD with Azure Cloud ',2);

--inserting into Student
INSERT iNTO Student VALUES(1,'Rohit','Rohit@UCLA.UK',17); -- will not work as age is less than 18
INSERT iNTO Student VALUES(1,'Rohit','Rohit@UCLA.UK',19);
INSERT iNTO Student VALUES(2,'Rashi','Rohit@UCLA.UK',19); -- Will no accept as Email is not unique
INSERT iNTO Student VALUES(2,'Rashi','Rashi@UCLA.UK',19);
Select * FROM Student;

-- inserting vlaues with Enrollement 

INSERt into Enrollment VALUES( 1001,1,101,GETDATE());
INSERt into Enrollment VALUES( 1002,2,102,GETDATE());
INSERt into Enrollment VALUES( 1003,1,101,GETDATE());
Select * FROM Enrollment;

--GRANT and Revoke for auditor
GRANT SELECT ON Student to auditor;
GRANT SELECT on Enrollment  to auditor;

-- for above to work we have to create login and users
CREATE Login auditor with Password = 'StrongPassword123';
Create User auditor FOR LOGIN auditor;

Revoke SELECT ON Student FROM Auditor; -- for revoking access after some time 


-- Implementing a transaction with commmit and and roll back
BEGIN TRANSACTION;
INSERT INTO Student VALUES(3,'Alex','Alex@HWD.edu',20);
INSERT INTO Enrollment VALUES(1003,3,101,GETDATE());
COMMIT;

-- Rollback
BEGIN Transaction;
INSERT INTO Student VALUES(4,'Angel','Angel@UCLA.UK',17);
RollBACK;