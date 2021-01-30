
--Task 1
SELECT COUNT(*)
FROM WizzardDeposits

--Task2
SELECT  MAX(w.MagicWandSize) as LongestMagicWand
FROM WizzardDeposits w

--Task 3
SELECT w.DepositGroup, MAX(w.MagicWandSize) as LongestMagicWand
FROM WizzardDeposits w
 GROUP BY w.DepositGroup

 --TASK4
 SELECT TOP 2 w.DepositGroup
 FROM WizzardDeposits w
 GROUP BY w.DepositGroup
 ORDER BY AVG(w.MagicWandSize)


 --Task5
 SELECT w.DepositGroup,SUM( w.DepositAmount) as TotalSum
 FROM WizzardDeposits w
 GROUP BY w.DepositGroup

 --TASK6
  SELECT w.DepositGroup,SUM( w.DepositAmount) as TotalSum
 FROM WizzardDeposits w
 WHERE w.MagicWandCreator= 'Ollivander family'
 GROUP BY w.DepositGroup

 --Task7
 SELECT w.DepositGroup,SUM( w.DepositAmount) as TotalSum
 FROM WizzardDeposits w
 WHERE w.MagicWandCreator= 'Ollivander family'
 GROUP BY w.DepositGroup
  HAVING SUM(DepositAmount)<150000
 ORDER BY TotalSum DESC

 --Task8
 SELECT w.DepositGroup, w.MagicWandCreator,  MIN(w.DepositCharge) as MinDepositCharge
 FROM WizzardDeposits w
 GROUP BY w.DepositGroup ,w.MagicWandCreator
 ORDER BY w.MagicWandCreator, w.DepositGroup

-- TASK9
SELECT Result.AgeGroup, COUNT(Result.AgeGroup)
FROM(
	SELECT	CASE 
		WHEN w.AGE BETWEEN 0 AND 10 THEN '[0-10]'
		WHEN w.AGE BETWEEN 11 AND 20 THEN '[11-20]'
		WHEN w.AGE BETWEEN 21 AND 30 THEN '[21-30]'
		WHEN w.AGE BETWEEN 31 AND 40 THEN '[31-40]'
		WHEN w.AGE BETWEEN 41 AND 50 THEN '[41-50]'
		WHEN w.AGE BETWEEN 51 AND 60 THEN '[51-60]'
		WHEN w.AGE >=60 THEN '[61+]'
		END as AgeGroup
FROM WizzardDeposits w) as Result
GROUP BY Result.AgeGroup

--Task10
SELECT LEFT(w.FirstName,1)
FROM WizzardDeposits w
WHERE w.DepositGroup= 'Troll Chest'
GROUP By LEFT(w.FirstName,1)

--Таск11
SELECT w.DepositGroup, w.IsDepositExpired, AVG(w.DepositInterest)
FROM WizzardDeposits w
WHERE w.DepositStartDate>'01/01/1985'
GROUP BY w.DepositGroup, w.IsDepositExpired
ORDER BY w.DepositGroup DESC, w.IsDepositExpired

--Task 12
SELECT Guest.Id,Guest.FirstName, Guest.DepositAmount,
		Host.Id,Host.FirstName, Host.DepositAmount,
		Guest.DepositAmount - Host.DepositAmount as [Difference]
FROM WizzardDeposits  as Host
JOIN WizzardDeposits as Guest ON Guest.Id +1= Host.Id

--OR SHORTLY
SELECT SUM(Guest.DepositAmount - Host.DepositAmount) as [Difference]
FROM WizzardDeposits  as Host
JOIN WizzardDeposits as Guest ON Guest.Id +1= Host.Id


--Task13
SELECT DepartmentID, SUM(Salary)
FROM Employees
GROUP BY DepartmentID

--Task14
SELECT DepartmentID, MIN(Salary)
FROM Employees
WHERE DepartmentID IN (2,5,7) AND HireDate>'01/01/2000'
GROUP BY DepartmentID


--Таск15
SELECT*INTO MyNewTable
FROM Employees 
WHERE Salary >30000

DELETE FROM MyNewTable
WHERE ManagerID = 42

UPDATE MyNewTable
SET Salary += 5000
WHERE DepartmentID=1

SELECT DepartmentID, AVG(Salary)
FROM MyNewTable
GROUP BY DepartmentID

--TASK16 
SELECT e.DepartmentID, MAX(Salary)
FROM Employees e
GROUP BY e.DepartmentID
HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000

--TASK 17 
SELECT COUNT(*)
	FROM Employees
	WHERE ManagerID IS NULL

--Task 18*
SELECT DISTINCT k.DepartmentID, k.Salary
FROM(SELECT e.DepartmentID, e.Salary, DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) as [Ranked]
FROM Employees e) as k
WHERE k.Ranked= 3


--TASK 19
SELECT TOP (10) FirstName, LastName, DepartmentID
FROM Employees e
WHERE Salary > (SELECT AVG(Salary)
				FROM Employees
				WHERE DepartmentID= e.DepartmentID
				GROUP BY DepartmentID)
ORDER BY DepartmentID


