--Task1 find first and last names of all employees whose first name starts with "SA"
SELECT e.FirstName,e.LastName
FROM dbo.Employees e
WHERE SUBSTRING(FirstName,1,2)='Sa'

-- Task2 find first and last names of all employees whose last name contains "ei"
SELECT e.FirstName,e.LastName
FROM dbo.Employees e
WHERE e.LastName LIKE '%ei%'


--Task3 find the first names of all employees in the departments with ID 3 or 10 and whose hire year is between 1995 and 2005 inclusive
SELECT e.FirstName
FROM  dbo.Employees e
WHERE (e.DepartmentID=3 OR e.DepartmentID=10) AND (e.HireDate>=1995 OR e.HireDate<=2005)

--Task4 find the first and last names of all employees whose job titles does not contain "engineer". 
SELECT e.FirstName, e.LastName
FROM dbo.Employees e
WHERE e.JobTitle NOT LIKE '%engineer%'

--Task5 to find town names that are 5 or 6 symbols long and order them alphabetically by town name.
SELECT Name
FROM dbo.Towns tns
WHERE LEN(Name)=5 OR LEN(Name)=6
ORDER BY tns.Name ASC

--Task6 find all towns that start with letters M, K, B or E. Order them alphabetically by town name. 
SELECT *
FROM dbo.Towns tns
WHERE LEFT( Name,1) IN ('M','K','B','E')
--WHERE (Name LIKE 'e%') OR (Name LIKE 'k%') OR (Name LIKE 'b%') OR (Name LIKE 'e%')-second option
--WHERE Name LIKE '[MKBE]%'- third option
ORDER BY tns.Name ASC

--Task7 find all towns that does not start with letters R, B or D. Order them alphabetically by name
SELECT *
FROM dbo.Towns tns
WHERE Name NOT LIKE '[RDB]%'
ORDER BY tns.Name ASC

--Task8 create view V_EmployeesHiredAfter2000 with first and last name to all employees hired after 2000 year. 
CREATE VIEW V_EmployeesHiredAfter2000 AS 
SELECT FirstName,e.LastName
FROM dbo.Employees e
WHERE HireDate > '2001'

--second solution
CREATE VIEW V_EmployeesHiredAfter2000 AS 
SELECT FirstName,LastName
FROM Employees 
WHERE DATEPART(YEAR,HireDate)>2000

--Task9 to find the names of all employees whose last name is exactly 5 characters long.
SELECT FirstName,LastName
FROM Employees
WHERE LEN(LastName)=5 

--Task10 query that ranks all employees using DENSE_RANK. In the DENSE_RANK function, employees need to be partitioned by Salary and ordered by EmployeeID. You need to find only the employees whose Salary is between 10000 and 50000 and order them by Salary in descending order.
SELECT EmployeeID, FirstName, LastName, Salary, DENSE_RANK() OVER (PARTITION by Salary ORDER By EmployeeID )
FROM Employees
WHERE Salary BETWEEN 10000 and 50000
ORDER BY Salary DESC

--Task11* Use the query from the previous problem and upgrade it, so that it finds only the employees whose Rank is 2 and again, order them by Salary (descending).
--Using DENSE_RANK()
SELECT * FROM(
SELECT EmployeeID, FirstName, LastName, Salary, DENSE_RANK() OVER (PARTITION by Salary 
ORDER By EmployeeID ) AS Ranked
FROM Employees
WHERE Salary BETWEEN 10000 and 50000
) AS Result 
WHERE Ranked =2
ORDER BY Salary DESC

--TASK12 Find all countries that holds the letter 'A' in their name at least 3 times (case insensitively), sorted by ISO code. Display the country name and ISO code. 
SELECT CountryName, IsoCode
From Countries
Where CountryName LIKE '%a%a%a%'
Order by IsoCode

--Task13 Combine all peak names with all river names, so that the last letter of each peak name is the same as the first letter of its corresponding river name. Display the peak names, river names, and the obtained mix (mix should be in lowercase). Sort the results by the obtained mix
SELECT PeakName,
		RiverName,  
		LOWER(LEFT(PeakName, LEN(PeakName)-1) + RiverName) AS Mix
From Peaks,Rivers
WHERE RIGHT(PeakName,1)= LEFT(RiverName,1)
ORDER BY Mix

--Task14 Find the top 50 games ordered by start date, then by name of the game. Display only games from 2011 and 2012 year. Display start date in the format "yyyy-MM-dd". 
--Using FORMAT(),DATEPART(),SUBSTRING(),CHARINDEX()
SELECT TOP(50) [Name], FORMAT([Start], 'yyyy-MM-dd') AS [Start]
FROM Games
WHERE DATEPART(YEAR,[Start]) BETWEEN 2011 AND 2012
ORDER BY [Start], [Name]

--Task15 Find all users along with information about their email providers. Display the username and email provider. Sort the results by email provider alphabetically, then by username. 
SELECT Username, SUBSTRING(Email, CHARINDEX('@',Email)+1, LEN(Email)) AS EmailProvider
FROM Users
ORDER BY EmailProvider, Username

--Task16 Find all users along with their IP addresses sorted by username alphabetically. Display only rows that IP address matches the pattern: "***.1^.^.***". Legend: * - one symbol, ^ - one or more symbols
--При такава задча да се провери в w3schools.com 
SELECT Username, IpAddress
	FROM Users
	WHERE IpAddress LIKE '___.1%.%.___'
	ORDER BY Username

--Task17 Show All Games with Duration and Part of the Day// using CASE 
SELECT [Name],
	CASE 
	When DATEPART(HOUR, Start) BETWEEN 0 AND 11 THEN 'Morning'
	When DATEPART(HOUR, Start) BETWEEN 12 AND 17 THEN 'Afternoon'
	When DATEPART(HOUR, Start) BETWEEN 18 AND 23 THEN 'Evening'
	END AS [Part of the Day],
	
	CASE 
	When Duration <= 3 THEN 'Extra Short'
	When Duration BETWEEN 4 AND 6 THEN 'Short'
	When Duration > 6 THEN 'Long'
	ELSE 'Extra Long'
	END AS [Duration]
	
	FROM Games
ORDER BY [Name],[Duration],[Part of the Day]

--Task18  Orders Table DATEADD FUNCTION
SELECT ProductName,
		OrderDate,
		DATEADD(DAY, 3, OrderDate) AS [Pay Due],
		DATEADD(MONTH, 1, OrderDate) AS [Delivery Due]
FROM Orders