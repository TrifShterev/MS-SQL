--PROCEDURES
--Task1
-- Submit in Judje without GO
CREATE PROC usp_GetEmployeesSalaryAbove35000
AS
	SELECT FirstName,LastName
	FROM Employees
	WHERE Salary> 35000
GO

--Task2 
CREATE PROC usp_GetEmployeesSalaryAboveNumber @Num DECIMAL(18,4)
AS
	SELECT FirstName,LastName
	FROM Employees
	WHERE Salary>= @Num
GO
EXEC usp_GetEmployeesSalaryAboveNumber 48100
GO
--Task3 
CREATE PROCEDURE usp_GetTownsStartingWith (@subName NVARCHAR(50))
AS
SELECT [Name]
FROM Towns
WHERE[Name] LIKE @subName + '%'

GO
EXEC usp_GetTownsStartingWith b

GO
--Task 4
CREATE PROC usp_GetEmployeesFromTown (@townName NVARCHAR(50))
AS
SELECT FirstName,LastName
	FROM Employees e
	JOIN Addresses a ON a.AddressID=e.AddressID
	JOIN Towns t ON t.TownID= a.TownID
	WHERE t.Name= @townName
GO

--Task5 FUNCTIONS
CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4)) 
RETURNS VARCHAR(50)
AS
BEGIN
DECLARE @Result VARCHAR(50)

	IF @salary < 30000
		SET @Result= 'Low'
	ELSE IF @salary BETWEEN 30000 AND 50000 
		SET @Result='Average'
	ELSE IF @salary > 50000
		SET @Result=  'High'	
	RETURN @Result
	
	END
GO
--Using of the above function
SELECT Salary, dbo.ufn_GetSalaryLevel(Salary) as SalaryLevel  FROM Employees
GO
--Task6 
CREATE PROC usp_EmployeesBySalaryLevel (@levelOfSalary VARCHAR(20))
AS
SELECT FirstName,LastName
FROM Employees
WHERE dbo.ufn_GetSalaryLevel(Salary)= @levelOfSalary
GO

EXEC usp_EmployeesBySalaryLevel 'Average'
GO
--Task7
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(MAX), @word VARCHAR(MAX))
RETURNS BIT 
BEGIN
DECLARE @count INT = 1;
WHILE(@count <= LEN(@word))
	BEGIN
	DECLARE @currentLetter CHAR(1) = SUBSTRING(@word,@count,1)

		IF(CHARINDEX(@currentLetter,@setOfLetters)=0)
		RETURN 0

	SET @count+=1
	END
RETURN 1
END

GO
--Task 8
CREATE PROC usp_DeleteEmployeesFromDepartment (@departmentId INT) 
AS
ALTER TABLE Departments
ALTER COLUMN ManagerID INT NULL

--TODO Delete all this projects
--SELECT ep.ProjectID
--FROM EmployeesProjects ep
--JOIN Employees e ON e.EmployeeID= ep.EmployeeID
--WHERE e.DepartmentID= 1

--Deletes Projects
DELETE FROM EmployeesProjects
WHERE EmployeeID IN (SELECT EmployeeID FROM Employees
					WHERE DepartmentID = @departmentId)

UPDATE Employees
SET ManagerID = NULL
WHERE EmployeeID IN (SELECT EmployeeID FROM Employees
					WHERE DepartmentID = @departmentId)
UPDATE Employees
SET ManagerID = NULL
WHERE ManagerID IN (SELECT EmployeeID FROM Employees
					WHERE DepartmentID = @departmentId)

UPDATE Departments
SET ManagerID = NULL
WHERE ManagerID IN (SELECT EmployeeID FROM Employees
					WHERE DepartmentID = @departmentId)
--TODO2
DELETE FROM Employees
WHERE DepartmentID= @departmentId

DELETE FROM Departments
WHERE DepartmentID= @departmentId

SELECT COUNT(*) FROM Employees WHERE DepartmentID = @departmentId

--CHECK
EXEC usp_DeleteEmployeesFromDepartment 2

GO

--Task 9 BankDB
CREATE PROC usp_GetHoldersFullName 
AS
SELECT FirstName + ' ' +LastName
FROM AccountHolders

GO
--Task10
CREATE PROC usp_GetHoldersWithBalanceHigherThan (@money DECIMAL(15,2))
AS
SELECT ah.FirstName, ah.LastName
FROM AccountHolders ah
JOIN Accounts a ON a.AccountHolderId = ah.Id
GROUP BY ah.FirstName, ah.LastName
HAVING SUM(a.Balance) > @money
ORDER BY FirstName, LastName

GO
--TASK 11
CREATE FUNCTION ufn_CalculateFutureValue (@sum DECIMAL(15,2), @yearly FLOAT,@years INT)
RETURNS DECIMAL(15,4)
BEGIN
	DECLARE @result DECIMAL(15,4)= (@sum*(POWER((1+@yearly),@years)))
	RETURN @result
END
GO
--CHECK
SELECT dbo.ufn_CalculateFutureValue(1000,0.1,5)

GO

--Task12 
CREATE PROC usp_CalculateFutureValue(@accountId INT, @interestRate FLOAT)
AS
SELECT a.Id, ah.FirstName, ah.LastName, a.Balance, dbo.ufn_CalculateFutureValue(a.Balance, @interestRate,5 ) 
FROM AccountHolders ah
JOIN Accounts a ON a.AccountHolderId = ah.Id
WHERE a.Id= @accountId

GO
--CHECK
EXEC usp_CalculateFutureValue 1, 0.1

GO

--Task13*
CREATE FUNCTION ufn_CashInUsersGames (@gameName VARCHAR(100))
RETURNS TABLE
AS
RETURN (SELECT SUM(k.TotalCash) as TotalCash
FROM(
SELECT Cash as TotalCash , ROW_NUMBER() OVER ( ORDER BY Cash DESC) as RowNumber
FROM Games g
JOIN UsersGames ug ON ug.GameId= g.Id
WHERE Name = @gameName
) as k
WHERE k.RowNumber % 2 = 1)

--CHECK
SELECT * FROM ufn_CashInUsersGames ('Love in a mist')
