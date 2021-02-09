CREATE VIEW v_UserWithCountries 
as
SELECT (FirstName+ ' '+Lastname) as CustomerName,	Age,Gender, ct.Name as CountryName
From  Customers c 
JOIN Countries ct ON  c.CountryId=ct.Id

