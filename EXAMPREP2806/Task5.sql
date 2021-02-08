--Extract from the database, all Military journeys in the format "dd-MM-yyyy". Sort the results ascending by journey start.

SELECT Id,(SELECT FORMAT(JourneyStart, 'dd/MM/yyyy')) as JourneyStart,
(SELECT FORMAT(JourneyEnd, 'dd/MM/yyyy')) as JourneyEnd
FROM Journeys
WHERE Purpose='Military'
ORDER BY JourneyStart
