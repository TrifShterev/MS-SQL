SELECT 	ProductId,Rate,	Description,CustomerId,	Age,Gender
FROM Feedbacks f
JOIN Customers c ON c.Id=f.CustomerId
WHERE f.Rate< 5
ORDER BY f.ProductId DESC, f.Rate
