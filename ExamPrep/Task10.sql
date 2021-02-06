SELECT p.PartId,
		p.Description,
		pn.Quantity as [Required],
		p.StockQty as [InStock],		
		--IFF== if the first argument is true, RETURN the second argument, ELSE RETURN the third argument
		IIF(o.Delivered =0, op.Quantity,0) as Ordered
FROM Parts p
LEFT JOIN PartsNeeded pn ON pn.PartId=p.PartId
LEFT JOIN OrderParts op ON op.PartId = p.PartId
LEFT JOIN Jobs j ON j.JobId =pn.JobId
LEFT JOIN Orders o ON o.JobId= j.JobId
WHERE j.Status != 'Finished' AND p.StockQty + IIF(o.Delivered =0, op.Quantity,0) < pn.Quantity
ORDER BY PartId