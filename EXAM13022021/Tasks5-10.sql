--Select all commits from the database. Order them by id (ascending), message (ascending), repository id (ascending) and contributor id (ascending).

SELECT Id,	Message,	RepositoryId,	ContributorId FROM Commits
ORDER BY Id ,Message , RepositoryId ,ContributorId


SELECT Id, Name ,Size From Files
WHERE Size>1000 AND Name LIKE '%html'
ORDER BY Size DESC, Id,Name

--Select all of the files, which have size, greater than 1000, and a name containing "html". Order them by size (descending), id (ascending) and by file name (ascending).


--Select all of the issues, and the users that are assigned to them, so that they end up in the following format: {username} : {issueTitle}. Order them by issue id (descending) and issue assignee (ascending).
SELECT i.Id, (u.Username+' : '+i.Title) as IssueAssignee FROM Issues i
JOIN Users u ON i.AssigneeId= u.Id
ORDER BY i.Id DESC, i.AssigneeId

--Select all of the files, which are NOT a parent to any other file. Select their size of the file and add "KB" to the end of it. Order them file id (ascending), file name (ascending) and file size (descending).
SELECT f.Id, f.Name , CONVERT(VARCHAR(50),f.Size) + 'KB' AS Size FROM Files AS f
 LEFT JOIN Files AS ft ON f.Id = ft.ParentId
 WHERE ft.ParentId IS NULL
 ORDER BY f.Id, f.Name, f.Size DESC
--SELECT TOP(5) Id, Name, COUNT(*) от RepositoriesContributors и да ги JOIN-ете с Repositories и Commits  (edited)  
SELECT TOP(5) c.Id,r.Name,COUNT(*) FROM RepositoriesContributors rc
JOIN Repositories r ON r.Id= rc.RepositoryId
JOIN Commits c ON c.Id=r.Id

SELECT u.Username,AVG(f.Size) as Size FROM Commits c
LEFT JOIN Users u ON c.ContributorId =u.Id
JOIN Files f ON f.CommitId= c.Id
GROUP BY u.Username
ORDER BY Size DESC, u.Username