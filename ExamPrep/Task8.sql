SELECT  m.FirstName+ ' '+m.LastName
FROM Mechanics m
LEFT JOIN Jobs j ON j.MechanicId=m.MechanicID
WHERE j.JobId IS NULL OR (SELECT COUNT(JobID)
								FROM Jobs
							WHERE Status != 'Finished' AND MechanicId= m.MechanicID
							GROUP BY MechanicId,Status) IS NULL
							GROUP BY m.MechanicId,(m.FirstName+ ' '+m.LastName)

	
