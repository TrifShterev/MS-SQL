SELECT d.Name as DistributorName,i.Name as IngredientName,p.Name as ProductName, AVG(f.Rate) as AverageRate
FROM Distributors d
JOIN Ingredients i ON i.DistributorId=d.Id
JOIN ProductsIngredients pri ON pri.IngredientId= i.Id
JOIN  Products p ON p.Id=pri.ProductId
JOIN Feedbacks f ON f.ProductId=p.Id
GROUP BY d.Name,i.Name,p.Name
HAVING AVG(f.Rate) between 5 and 8 