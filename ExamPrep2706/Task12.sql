CREATE FUNCTION udf_GetCost(@jobId INT)
RETURNS DECIMAL (15,2)
AS
BEGIN
DECLARE @result DECIMAL(15,2)=(SELECT SUM(p.Price*op.Quantity) as TotalSum
								FROM Jobs j
								JOIN Orders o ON o.JobId=j.JobId
								JOIN OrderParts op ON op.OrderID=o.OrderId
								JOIN Parts p ON p.PartId= op.PartId
								WHERE j.JobId=@jobId
								GROUP BY j.JobId)
IF(@result IS NULL)
SET @result = 0

RETURN @result

END