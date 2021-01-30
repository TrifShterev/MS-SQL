
--TASK1
SELECT TOP(5) EmployeeID, JobTitle,a.AddressID,AddressText
FROM Employees e JOIN Addresses a
ON e.AddressID=a.AddressID
ORDER BY e.AddressID 


--Task2 JOIN 4 columns from 3 tables
SELECT TOP(50) e.FirstName,e.LastName,t.Name, a.AddressText
FROM Employees e 
JOIN Addresses a ON a.AddressID=e.AddressID
JOIN Towns t
ON t.TownID=a.TownID
ORDER BY e.FirstName ASC, e.LastName 


--Task3 Select only employees from "Sales" department.
SELECT EmployeeID, FirstName, LastName, d.Name
FROM Employees e
JOIN Departments d ON e.DepartmentID=d.DepartmentID
WHERE e.DepartmentID=3


--Task4 
SELECT TOP(5) e.EmployeeID,e.FirstName,e.Salary,d.Name
FROM Employees e
JOIN Departments d ON e.DepartmentID= d.DepartmentID
WHERE (e.Salary>15000)
ORDER BY d.DepartmentID


--Task5
SELECT TOP 3  e.EmployeeID, e.FirstName
FROM Employees e
LEFT JOIN EmployeesProjects ep ON ep.EmployeeID=e.EmployeeID
WHERE ep.ProjectID IS NULL
ORDER BY e.EmployeeID

--TASK6 JOINING 2 Tables and finding all people from 2 departments(sales and Finances) hired after certain date
SELECT e.FirstName, e.LastName, e.HireDate, d.Name as DeptName
FROM Employees e
JOIN Departments d ON d.DepartmentID=e.DepartmentID
WHERE e.HireDate > '1.1.1999' AND d.Name IN ('Sales','Finance')
ORDER BY HireDate


--Task 7 
SELECT TOP (5) e.EmployeeID, e.FirstName, p.Name as ProjectName
FROM Employees e
JOIN EmployeesProjects ep ON ep.EmployeeID= e.EmployeeID
JOIN Projects p ON p.ProjectID = ep.ProjectID
WHERE p.StartDate> '2002-08-13' AND p.EndDate IS NULL
ORDER BY e.EmployeeID



--Task8  Using CASE STATEMENT and JOIN 'showing NULL in some condition and normal result in other
SELECT  e.EmployeeID, e.FirstName,
CASE
    WHEN p.StartDate>='01/01/2005' THEN NULL
	ELSE p.Name 
	END
	AS ProjectName
FROM Employees e
JOIN EmployeesProjects ep ON ep.EmployeeID= e.EmployeeID
JOIN Projects p ON p.ProjectID = ep.ProjectID
WHERE (ep.EmployeeID=24)


--TASK9 FINDING MANAGERS- Filter all employees with a manager who has ID equals to 3 or 7. Return all the rows, sorted by EmployeeID in ascending order. (Here we take those Emplyees who have ManagerID  and return their names)
SELECT E.EmployeeID,E.FirstName,E.ManagerID,M.FirstName AS ManagerName
  FROM Employees AS E
INNER JOIN Employees AS M ON E.ManagerID = M.EmployeeID
WHERE E.ManagerID IN (3,7)
ORDER BY E.EmployeeID

--TAASK10
SELECT TOP 50 E.EmployeeID,
(E.FirstName+' '+E.LastName) as EmplyeeName,
(M.FirstName+ ' '+M.LastName) AS ManagerName,
d.Name as DepartmentName
  FROM Employees E
JOIN Employees M ON E.ManagerID = M.EmployeeID
JOIN Departments d ON d.DepartmentID=e.DepartmentID
ORDER BY EmployeeID


--Task11 LOWEST AVERAGE SALARY OF ALL DEPARTMENTS
SELECT TOP(1) AVG(Salary) AS AVERAGESALARY FROM Employees
GROUP BY DepartmentID
ORDER BY (AVERAGESALARY) 


--from here using Geography DB

--Task12 Filter all peaks in Bulgaria with elevation over 2835. Return all the rows sorted by elevation in descending order
SELECT mc.CountryCode ,m.MountainRange, p.PeakName, p.Elevation
FROM Mountains m
INNER JOIN Peaks p ON m.Id = p.MountainId
INNER JOIN MountainsCountries  mc ON m.Id = mc.MountainId
WHERE p.Elevation > 2835
AND mc.CountryCode = 'BG'
ORDER BY Elevation DESC

--Task 13 Filter the count of the mountain ranges in the United States, Russia and Bulgaria
SELECT MC.CountryCode, COUNT(MC.CountryCode)
  FROM MountainsCountries AS MC
JOIN Mountains AS M ON M.ID = MC.MountainId
WHERE MC.CountryCode IN ('US','BG','RU')
GROUP BY MC.CountryCode

--TASK 14 Find the first 5 countries with or without rivers in Africa. Sort them by CountryName in ascending order.

SELECT TOP(5) C.CountryName,R.RiverName
  FROM Countries  C
LEFT JOIN CountriesRivers CR ON C.CountryCode = CR.CountryCode
LEFT JOIN Rivers R ON CR.RiverId = R.Id
WHERE C.ContinentCode ='AF'
ORDER BY C.CountryName

--Task15 NESTED SELECT Find all continents and their most used currency. Filter any currency that is used in only one country. Sort your results by ContinentCode.

SELECT rankedCurrencies.ContinentCode, rankedCurrencies.CurrencyCode, rankedCurrencies.Count
FROM (
SELECT c.ContinentCode, c.CurrencyCode, COUNT(c.CurrencyCode) AS [Count], DENSE_RANK() OVER (PARTITION BY c.ContinentCode ORDER BY COUNT(c.CurrencyCode) DESC) AS [rank] 
FROM Countries  c
GROUP BY c.ContinentCode, c.CurrencyCode) AS rankedCurrencies
WHERE rankedCurrencies.rank = 1 and rankedCurrencies.Count > 1


--Task16 Find all the count of all countries, which don’t have a mountain
SELECT COUNT(c.CountryCode) AS [CountryCode]
FROM Countries AS c
LEFT OUTER JOIN MountainsCountries AS m ON c.CountryCode = m.CountryCode
WHERE m.MountainId IS NULL

--TASK17
SELECT TOP(5) c.CountryName, MAX(p.Elevation) as [HighestPeakElevation], MAX(r.Length) as [LongestRiverLength]
FROM Countries  c
LEFT JOIN MountainsCountries mc ON c.CountryCode = mc.CountryCode
LEFT JOIN Peaks p ON p.MountainId = mc.MountainId
LEFT JOIN CountriesRivers cr ON c.CountryCode = cr.CountryCode
LEFT JOIN Rivers  r ON cr.RiverId = r.Id
GROUP BY c.CountryName
ORDER BY [HighestPeakElevation] DESC, [LongestRiverLength] DESC, c.CountryName