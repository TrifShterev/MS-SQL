SELECT j.JobId, SUM(p.Price*op.Quantity) as TotalOrder
FROM Jobs j
LEFT JOIN Orders o ON o.JobId = j.JobId
LEFT JOIN OrderParts op ON op.OrderID = o.OrderId
LEFT JOIN Parts p ON p.PartId= op.PartId
WHERE Status = 'Finished'
GROUP BY j.JobId
Order BY TotalOrder DESC, j.JobId