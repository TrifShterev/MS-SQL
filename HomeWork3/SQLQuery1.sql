
--task1 ONE TO ONE RELATION
CREATE TABLE Passports(
PassportID INT PRIMARY KEY,
PassportNumber CHAR(8))


CREATE TABLE Persons(
PersonId INT PRIMARY KEY IDENTITY,
FirstName Nvarchar(30),
Salary Decimal(30,5),
PassportID INT UNIQUE FOREIGN KEY REFERENCES Passports(PassportID)
)

INSERT INTO dbo.Passports
(
    PassportID,
    PassportNumber
)
VALUES
(101,'N34FG21B'),
(102,'K65LO4R7'),
(103,'ZE657QP2')


INSERT INTO dbo.Persons

VALUES
( 'Roberto', 43300.00, 102 ),
( 'Tom', 56100.00, 103 ),
( 'Yana', 60200.00, 101 )


--Task 2 ONE to MANY RELATIONSHIP

CREATE TABLE Manufacturers
(
ManufacturerID INT PRIMARY KEY IDENTITY,
Name VARCHAR(50 ) NOT NULL,
EstablishedOn DATETIME

)

CREATE TABLE Models
(
ModelID INT PRIMARY KEY IDENTITY(101,1),
Name VARCHAR(50),
ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
)


INSERT Manufacturers VALUES
('BMW',  '07/03/1916'),
('Tesla','01/01/2003'),
('Lada','01/05/1966')

INSERT Models VALUES
('X1',1),
('i6',1),
('Model S',2),
('Model X',2),
('Model 3',2),
('Nova',3)

--TASK3 MANY to MANY RELATIONS

CREATE TABLE Students(
StudentID INT PRIMARY KEY IDENTITY,
Name VARCHAR(50) 
)

CREATE TABLE Exams
( 
ExamID INT PRIMARY KEY IDENTITY(101,1),
Name VARCHAR(50)
)

CREATE TABLE StudentsExams
(
StudentID INT,
ExamID INT
--тук създаваме двоен PK
CONSTRAINT PK_Students_Exams Primary key(StudentID,ExamID)
--Създаваме 2 FK Които да вържат другите 2 таблици с тази
CONSTRAINT FK_Students FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
CONSTRAINT FK_Exams FOREIGN KEY (ExamID) REFERENCES Exams(ExamID)
)

INSERT INTO dbo.Students
(
    --StudentID - column value is auto-generated
    [Name]
)
VALUES
('Mila'),
('Toni'),
('Ron')

INSERT dbo.Exams
(
    --ExamID - column value is auto-generated
    Name
)
VALUES
('SpringMVC'),
('Neo4j'),
('Oracle 11g')

INSERT dbo.StudentsExams
(
    StudentID,
    ExamID
)
VALUES
(1,101),
(1,102),
(2,101),
(3,103),
(2,102),
(2,103)

--Task 4 SELF REFERENCED TABLE

CREATE TABLE Teachers(
TeacherID INT PRIMARY KEY IDENTITY(101,1),
Name VARCHAR(50),
ManagerID INT FOREIGN KEY REFERENCES dbo.Teachers(TeacherID)
)

INSERT dbo.Teachers
(
    --TeacherID - column value is auto-generated
    Name,
    ManagerID
)
VALUES
('John',	NULL),
('Maya',	106),
('Silvia',	106),
('Ted',	105),
('Mark',	101),
('Greta',	101)


--Task 5 OnlineStore Database

CREATE DATABASE OnlineStore

USE OnlineStore
--винаги започваме от тази таблица която най малко юе зависи от другите
CREATE TABLE Cities
(CityID INT PRIMARY KEY IDENTITY,
Name VARCHAR(50)NOT NULL)

CREATE TABLE Customers
(CustomerID INT PRIMARY KEY IDENTITY,
Name VARCHAR(50)NOT NULL,
Birthdate DATE,
CityID INT FOREIGN KEY REFERENCES Cities(CityID)
)

CREATE TABLE Orders
(OrderID INT PRIMARY KEY IDENTITY,
CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID)
)

--Започваме втората половина от таблиците отново с най независимата от другите

CREATE TABLE ItemTypes
(ItemTypeID INT PRIMARY KEY IDENTITY,
Name VARCHAR(50)NOT NULL)

CREATE TABLE Items
(ItemID INT PRIMARY KEY IDENTITY,
Name VARCHAR(50)NOT NULL,
ItemTypeID INT Foreign Key References ItemTypes(ItemTypeID)
)

CREATE TABLE OrderItems 
(
OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
ItemID  INT FOREIGN KEY REFERENCES Items(ItemID),

CONSTRAINT PK_Order_Item PRIMARY KEY(OrderID,ItemID) 
)


--TASK 9* 
USE Geography
SELECT*
	FROM Mountains 
	Where MountainRange = 'Rila'

SELECT*
	FROM Peaks
	Where MountainId =17

SELECT Mountains.MountainRange, Peaks.PeakName, Peaks.Elevation
	FROM Mountains
	--така му казваме да обедини там където има съвпадение по дадения критерии(в случая от таблицата с Върховете където ИД-то на планината съвпада с ИД-то на планина от таблицата с Планините)
	JOIN Peaks ON Peaks.MountainId= Mountains.Id
	Where Mountains.MountainRange='Rila'
	ORDER BY Elevation DESC

