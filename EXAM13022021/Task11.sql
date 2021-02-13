CREATE FUNCTION  udf_AllUserCommits(@username varchar (MAX)) 
RETURNS INT
AS
BEGIN
RETURN (SELECT COUNT(c.Id) FROM Users u
LEFT JOIN Commits c ON c.ContributorId=u.Id
WHERE @username= u.Username)






END


