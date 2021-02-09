--Select customers that are either at least 21 old and contain “an” in their first name or their phone number ends with “38” and are not from Greece. Order by first name (ascending), then by age(descending).

SELECT FirstName,Age,PhoneNumber FROM Customers c
JOIN Countries cty ON c.CountryId=cty.Id
WHERE (c.Age>=21 AND c.FirstName LIKE '%an%') OR(c.PhoneNumber LIKE'%38' AND cty.Name !='Greece')
ORDER BY c.FirstName, c.Age DESC