select c.FirstName + ' ' +c.LastName, 
DATEDIFF(DAY, j.IssueDate,'04/24/2017') as TimeLength,
j.Status
from Jobs j
join Clients c ON c.ClientId=j.ClientId
WHERE j.Status != 'Finished'
ORDER BY TimeLength DESC, j.ClientId