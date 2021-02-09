SELECT CONCAT(c.FirstName,' ',c.LastName) as CustomerName,	PhoneNumber,Gender
From  Feedbacks f
Right JOIN  Customers c ON f.CustomerId= c.Id
WHERE f.Id IS NULL
ORDER BY c.Id


