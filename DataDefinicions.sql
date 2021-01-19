--CREATE DATABASE Minions


--CREATE TABLE Minions(
--    id INT PRIMARY KEY NOT NULL,
--	[Name] NVARCHAR(50) NOT NULL,
--	Age TINYINT

--)

--CREATE TABLE Towns(
--	id INT PRIMARY KEY NOT NULL,
--	[Name] NVARCHAR NOT NULL)


------Създава нова колона TownId в MInions и прави (foreign key)референция към (primary key)колоната id на таблица Towns
--ALTER TABLE Minions
--	ADD TownId INT FOREIGN KEY REFERENCES Towns(id)


--INSERT INTO Towns(id,[Name])
--	VALUES
--			(1,'Sofia'),
--			(2, 'Plovdiv'),
--			(3, 'Varna')



--INSERT INTO Minions(id, [Name], Age, TownId)
--	VALUES (1,'Kevin', 22, 1),
--			(2,'Bob', 15, 3),
--			(3,'Steward', NULL, 2)

--			SELECT * FROM Minions
----Показва ни таблицата
--			SELECT * FROM Towns
----Премахва всичко данни от таблицата
--TRUNCATE TABLE Minions
----Трие таблицата, първо се трие таблицата с foreign key-a/ DROP може да трие и цялата база но не и докато сме в нея, трябва да го направем докато сме в друга база данни
--DROP TABLE Minions
--DROP TABLE Towns


CREATE TABLE Users( Id bigint PRIMARY KEY IDENTITY NOT NULL,
					Username VARCHAR(30) UNIQUE NOT NULL,
					[Password] VARCHAR(26) NOT NULL,
					--DATALENGTH(изчислява в bite- 1bite=1024kb) чрез CHECK ще провери дали големината на фаила е 900кб
					ProfilePicture VARBINARY(MAX) CHECK(DATALENGTH(ProfilePicture)<=900*1024),
					LastLogingTime DATETIME2 NOT NULL,
					IsDeleted bit NOT NULL
					)
		
INSERT INTO Users
(
    --Id - column value is auto-generated
    Username,
    Password,   
	LastLogingTime,
	IsDeleted
)
VALUES
(
    -- Id - bigint
    'Pesho', -- Username - VARCHAR
    '1234', -- Password - VARCHAR
   '01.12.2021',
   0
),
(
    -- Id - bigint
    'Ivan', -- Username - VARCHAR
    '4321', -- Password - VARCHAR
   '01.10.2021',
   1
),(
    -- Id - bigint
    'Stoyan', -- Username - VARCHAR
    'qweert', -- Password - VARCHAR
   '01.12.2020',
   0
),(
    -- Id - bigint
    'Dragan', -- Username - VARCHAR
    '1q2w', -- Password - VARCHAR
   '01.12.2020',
   0
),(
    -- Id - bigint
    'Petkan', -- Username - VARCHAR
    'qwer', -- Password - VARCHAR
   '01.11.2021',
   1
)
ALTER TABLE Users
DROP CONSTRAINT [PK__Users__3214EC079FA948FF]

ALTER TABLE Users
ADD CONSTRAINT PK_IdUSername PRIMARY KEY (Id, Username)

ALTER TABLE Users
DROP CONSTRAINT PK_IdUSername 

ALTER TABLE Users
ADD CONSTRAINT PK_Id PRIMARY KEY (Id)

ALTER TABLE Users
ADD CONSTRAINT CH_PassIsAtLeast5Symbols CHECK (LEN(Password) >5)

ALTER TABLE Users
ADD CONSTRAINT CH_UsernameIsAtLeast3Symbols CHECK (LEN(Username) >3)

ALTER TABLE Users
ADD CONSTRAINT Df_LastLoginTime DEFAULT GETDATE() FOR LastLogingTime 


CREATE DATABASE Hotel

USE Hotel

CREATE TABLE Employees
(	Id INT PRIMARY KEY,
	FirstName VARCHAR(90) NOT NULL,
	LastName VARCHAR(90) NOT NULL,
	Title VARCHAR(90) NOT NULL,
	Notes VARCHAR(MAX)
)

CREATE TABLE Customers
(	AccountNumber INT PRIMARY KEY,
	FirstName VARCHAR(90) NOT NULL,
	LastName VARCHAR(90) NOT NULL,
	PhoneNumber CHAR(90) NOT NULL,
	EmergencyName VARCHAR(90) NOT NULL,
	EmergencyNumber CHAR(10) NOT NULL,
	Notes varchar(max) 
)

CREATE TABLE RoomStatus
(
RoomStatus BIT NOT NULL,
Notes varchar(max)
)

CREATE TABLE RoomTypes
(
RoomType varchar(20) NOT NULL,
Notes varchar(max)
)

CREATE TABLE BedTypes
(
BedType varchar(20) NOT NULL,
Notes varchar(max)
)

CREATE TABLE Rooms
(
RoomNumber INT PRIMARY KEY,
RoomType VARCHAR(20) NOT NULL,
BedType VARCHAR(20) NOT NULL,
Rate INT,
RoomStatus BIT NOT NULL,
Notes VARCHAR(MAX)
)

CREATE TABLE Payments
(
Id INT PRIMARY KEY,
EmplyeeId INT NOT NULL,
PaymentDate DATETIME NOT NULL,
AccountNumber INT NOT NULL,
FirstDateOccupied DATETIME NOT NULL,
LastDateOccupied DATETIME NOT NULL,
TotalDays INT NOT NULL,
AmountCharged DECIMAL(15,2),
TaxRate INT,
TaxAmount INT,
PaymentTotal Decimal(15,2),
Notes VARCHAR(MAX)
)

CREATE TABLE Occupancies
(
Id INT PRIMARY KEY,
EmplyeedId INT,
DateOccupied DATETIME,
AccountNumber INT,
RoomNumber INT,
RateApplied INT,
PhoneCharge DECIMAL(15,2),
Notes VARCHAR(MAX)
)

INSERT INTO Employees(Id, FirstName,LastName,Title, Notes)
VALUES (1,'Gosho','Goshev','CEO', NULL),
		(2,'Ivan','Ivanov','CFO','Random note'),
		(3,'Petur','Petrov','CSFO','BLABLA')

		INSERT INTO Customers
VALUES (123,'G','G','12345678', 'T', '1432455',NULL),
		(13,'G','G','12345678', 'T', '1432455',NULL),
		(1213,'G','G','12345678', 'T', '1432455',NULL)

INSERT RoomStatus 
VALUES( 0,'Empty'),
	( 1,'Full')

INSERT RoomTypes 
VALUES( 1,'Normal'),
	( 0,'Big')

INSERT INTO Rooms VALUES
(120, 'Apartment', 'Single',10,1,NULL),
(121, 'Room', 'Double',15,0,NULL),
(122, 'Room', 'Single',10,1,NULL)

INSERT INTO Payments
VALUES
( 1, 1,GETDATE(),120, '5/5/2020', '5/8/2012', 3, 450.23, NULL, NULL,  45.23, NULL ),
( 2, 1,GETDATE(),120, '1/4/2020', '5/3/2012', 3, 4530.23, NULL, NULL,  453.23, NULL ),
( 3, 1,GETDATE(),120, '5/5/2020', '5/3/2012', 3, 4520.23, NULL, NULL,  42345.23, NULL )

INSERT INTO dbo.Occupancies
(
    Id,
    EmplyeedId,
    DateOccupied,
    AccountNumber,
    RoomNumber,
    RateApplied,
    PhoneCharge,
    Notes
)
VALUES
(
    1, -- Id - INT
    120, -- EmplyeedId - INT
    '2021-01-12 22:57:07', -- DateOccupied - DATETIME
    120, -- AccountNumber - INT
    120, -- RoomNumber - INT
    0, -- RateApplied - INT
    0, -- PhoneCharge - DECIMAL
    NULL -- Notes - VARCHAR
),
(
    2, -- Id - INT
    122, -- EmplyeedId - INT
    '2021-01-12 22:57:07', -- DateOccupied - DATETIME
    122, -- AccountNumber - INT
    123, -- RoomNumber - INT
    0, -- RateApplied - INT
    0, -- PhoneCharge - DECIMAL
    NULL -- Notes - VARCHAR
),(
    3, -- Id - INT
    123, -- EmplyeedId - INT
    '2021-01-12 22:57:07', -- DateOccupied - DATETIME
    123, -- AccountNumber - INT
    123, -- RoomNumber - INT
    1, -- RateApplied - INT
    23.25, -- PhoneCharge - DECIMAL
    NULL -- Notes - VARCHAR
)
   