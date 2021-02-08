select  p.Name, COUNT(j.DestinationSpaceportId) as JourneysCount
from Planets p
join Spaceports sp ON p.Id=sp.PlanetId
join Journeys j ON sp.Id= j.DestinationSpaceportId
GROUP BY p.Name 
ORDER BY JourneysCount DESC , p.Name

