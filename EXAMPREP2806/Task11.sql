CREATE FUNCTION dbo.udf_GetColonistsCount(@PlanetName VARCHAR (30)) 
RETURNS INT
AS
BEGIN 
DECLARE @ColonistsCount INT =(SELECT COUNT(*) FROM Planets p
                              join Spaceports sp ON p.Id=sp.PlanetId
                              join Journeys j ON sp.Id= j.DestinationSpaceportId
                              join TravelCards tc ON j.Id= tc.JourneyId
                              join Colonists c ON tc.ColonistId= c.Id
                              WHERE @PlanetName = p.Name) 



RETURN  @ColonistsCount
END

 

