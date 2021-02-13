CREATE TABLE Users(
Id INT Primary key IDENTITY,
Username varchar(30) NOT NULL,
Password varchar(30) NOT NULL,
Email varchar(50) NOT NULL
)

CREATE TABLE Repositories(
Id INT Primary key IDENTITY,
Name varchar(50) NOT NULL
)

CREATE TABLE RepositoriesContributors(
RepositoryId INT FOREIGN KEY REFERENCES Repositories(Id) NOT NULL,
ContributorId INT FOREIGN KEY REFERENCES Users(Id) NOT NULL
 CONSTRAINT pk_RepositoriesContributors PRIMARY KEY (RepositoryId, ContributorId)
)

CREATE TABLE Issues(
Id INT Primary key IDENTITY,
Title varchar(255)  NOT NULL,
IssueStatus char(6) NOT NULL,
RepositoryId INT FOREIGN KEY REFERENCES Repositories(Id) NOT NULL,
AssigneeId INT FOREIGN KEY REFERENCES Users(Id) NOT NULL
) 

CREATE TABLE Commits(
Id INT Primary key IDENTITY,
Message varchar(255) NOT NULL,
IssueId INT FOREIGN KEY REFERENCES Issues(Id) ,
RepositoryId INT FOREIGN KEY REFERENCES Repositories(Id) NOT NULL,
ContributorId INT FOREIGN KEY REFERENCES Users(Id) NOT NULL
)

CREATE TABLE Files(
Id INT Primary key IDENTITY,
Name varchar(100) NOT NULL,
Size Decimal(15,2) NOT NULL,
ParentId INT FOREIGN KEY REFERENCES Files(Id),
CommitId INT FOREIGN KEY REFERENCES Commits(Id) NOT NULL

)