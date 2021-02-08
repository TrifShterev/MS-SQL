SELECT COUNT(*) as [count] FROM TravelCards tc
JOIN Journeys j ON tc.JourneyId= j.Id
WHERE j.Purpose= 'Technical'

