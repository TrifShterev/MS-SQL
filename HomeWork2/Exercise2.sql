
--Събира стойностите от 2 колони в 3-та
SELECT FirstName,LastName, CONCAT(FirstName, '.', LastName,'@softuni.bg') [Full Email Address]
FROM Employees

--събира имената на всички в новата колона Full Name със заплати от 25000,14000,12500 и 23600
SELECT CONCAT(FirstName,' ',MiddleName,' ',LastName) [Full Name]
FROM Employees
WHERE(Salary IN(25000, 14000, 12500 , 23600))

--Избира FirstName LastName на всички без менаджери
SELECT FirstName,LastName
FROM Employees 
WHERE(ManagerID IS NULL)

--всички по име и фамилия със заплати над 50 000 ordered by decending
SELECT  FirstName,LastName, Salary
FROM Employees 
WHERE(Salary>50000)
ORDER BY Salary DESC

--5-мата с най-високи заплати
SELECT TOP(5) FirstName,LastName
FROM Employees
ORDER BY Salary DESC

--Намира всички служители по име и фамилия чийто DepartmentID не е 4
SELECT  FirstName,LastName
FROM Employees 
WHERE (DepartmentID NOT IN( 4))


--Подрежда по определен критерий, в случай че има еднакви резултати по първия критерий подрежда по следващия
SELECT*FROM dbo.Employees 
ORDER BY Salary DESC, FirstName ASC, LastName DESC, MiddleName ASC


--Създава view файл със зададените критерии
CREATE VIEW V_EmployeesSalaries AS 
SELECT FirstName,LastName,Salary
FROM EMployees



--Създава view file създава нива таблица с имената на хората като проверява за средното дали е NULL и ако е ,поставя празен стринг
CREATE VIEW v_EmployeeNameJobTitle AS 
	SELECT CONCAT(FirstName,' ',ISNULL(MiddleName ,''),' ', LastName) [Full Name],JobTitle
	FROM Employees

	--Решението на горната задача може и така
CREATE VIEW V_EmployeeNameJobTitle AS
SELECT FirstName+' '+
    CASE
        WHEN MiddleName IS NULL THEN ' '+LastName
        ELSE MiddleName+' '+LastName
    END
AS [Full Name], JobTitle FROM Employees


--Показвавсички различни професии
SELECT DISTINCT JobTitle
FROM Employees

--показва първите 10 проекта подредени първо по начална дата и след това по име
SELECT TOP(10)* 
FROM dbo.Projects 
ORDER BY StartDate,[Name]

--Показва последните 7 наети служители
SELECT TOP(7)FirstName, LastName,HireDate
FROM Employees 
ORDER BY HireDate DESC

--Вдига заплатите на определени служители от определени департаменти с 12%
 UPDATE Employees
SET SALARY*=1.12 FROM Employees
WHERE DepartmentID IN (1,2,4,11)
SELECT Salary FROM Employees

SELECT *
FROM Employees

USE [Geography]


SELECT PeakName FROM Peaks
ORDER BY PeakName


SELECT TOP(30) CountryName,Population
FROM Countries
WHERE(ContinentCode='EU')
ORDER BY [Population] DESC, CountryName ASC


--24 задача от упражнението- така се използва CASE statement- Ще събере в трета колона (Euro/Non Euro)
SELECT CountryName, CountryCode, 
CASE CurrencyCode
	WHEN 'EUR' THEN 'Euro'
	ELSE 'Not Euro'
END AS Currency FROM Countries
ORDER BY CountryName

USE Diablo


SELECT Name FROM  Characters
ORDER BY Name



