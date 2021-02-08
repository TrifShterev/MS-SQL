CREATE PROCEDURE usp_PlaceOrder(@jobId VARCHAR(50), @serialNumber VARCHAR(50), @qty INT)
AS


IF(@qty<=0)
	THROW 50012,'Part quantity must be more than zero!',1
ELSE IF EXISTS(SELECT * FROM Jobs j WHERE j.JobId = @jobId AND j.Status= 'Finished')
	THROW 50011, 'This job is not active!', 1
ELSE IF NOT EXISTS(SELECT * FROM Jobs j WHERE j.JobId = @jobId )  
	THROW 50013,'Job not found!', 1
ELSE IF NOT EXISTS(SELECT * FROM Parts p WHERE p.SerialNumber=@serialNumber )  
THROW 50014, 'Part not found', 1


DECLARE @partId INT= (SELECT PartId FROM Parts WHERE SerialNumber = @serialNumber)

DECLARE @orderID INT 
					SELECT @orderID= o.OrderId 
						FROM Orders o						
						WHERE  o.IssueDate IS NULL AND JobId=@jobId 

IF(@orderID IS NULL)
BEGIN
	INSERT INTO Orders (JobId, IssueDate) VALUES 
 ( @jobId, NULL)

	SET @orderID  =(SELECT  o.OrderId 
						FROM Orders o											
						WHERE  o.IssueDate IS NULL AND JobId=@jobId )

	INSERT INTO OrderParts(OrderId,PartId,Quantity) VALUES
 (@orderID,@partId,@qty)
 END
ELSE
 BEGIN
	UPDATE OrderParts
	SET Quantity+=@qty
	WHERE OrderID= @orderID 
END

GO
--CHECK
DECLARE @err_msg AS NVARCHAR(MAX);
BEGIN TRY
  EXEC usp_PlaceOrder 1, 'ZeroQuantity', 0
END TRY

BEGIN CATCH
  SET @err_msg = ERROR_MESSAGE();
  SELECT @err_msg
END CATCH
