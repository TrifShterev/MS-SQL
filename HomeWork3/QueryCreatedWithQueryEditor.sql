SELECT Peaks.PeakName, Peaks.Elevation, Mountains.MountainRange
FROM     Mountains INNER JOIN
                  Peaks ON Mountains.Id = Peaks.MountainId
WHERE  (Mountains.MountainRange = N'1')
ORDER BY Peaks.Elevation DESC
--Заявка за 9 задача създадена с Design Query Editor