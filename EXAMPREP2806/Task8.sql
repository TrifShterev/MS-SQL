

SELECT S.Name, S.Manufacturer
FROM Spaceships AS S
JOIN Journeys J on S.Id = J.SpaceshipId
JOIN TravelCards TC on J.Id = TC.JourneyId AND TC.JobDuringJourney = 'Pilot'
JOIN Colonists C on C.Id = TC.ColonistId AND DATEDIFF(YEAR,C.BirthDate, '01/01/2019')<30
ORDER BY S.Name