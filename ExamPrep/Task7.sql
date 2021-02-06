SELECT m.FirstName+' '+ m.LastName, AVG(DATEDIFF(DAY, IssueDate, FinishDate))
FROM Mechanics m
Join Jobs j ON j.MechanicId= m.MechanicID
GROUP BY j.MechanicId, (m.FirstName+' '+m.LastName)
ORDER BY j.MechanicId