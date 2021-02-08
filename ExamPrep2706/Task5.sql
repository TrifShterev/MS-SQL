SELECT m.FirstName+' '+m.LastName as Mechanic,
		j.Status,
		j.IssueDate
FROM Mechanics m
JOIN Jobs j ON j.MechanicId=m.MechanicID
ORDER BY m.MechanicID, j.IssueDate,j.JobId