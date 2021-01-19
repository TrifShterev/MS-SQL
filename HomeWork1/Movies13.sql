CREATE DATABASE Movies

USE Movies

CREATE TABLE Directors (
Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
DirectorName NVARCHAR(50) NOT NULL,
Notes NVARCHAR(MAX)
) 

INSERT INTO dbo.Directors
(
    --Id - column value is auto-generated
    DirectorName,
    Notes
)
VALUES
(
    -- Id - INT
    'Pesho Draganov', -- DirectorName - NVARCHAR
    'imalo edno vreme' -- Notes - NVARCHAR
),
('Ivan Pardonov', 'Exee koga beshe'),
('Gospodin Gospodinov', 'Nqma nishto'),
('Trandio Trandov', 'pruzz'),
('Dushinka Dobreva ', NULL)


CREATE TABLE Genres (
Id  INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
GenreName nvarchar( 10) NOT NULL ,
Notes nvarchar(max))

INSERT INTO dbo.Genres
(
    --Id - column value is auto-generated
    GenreName,
    Notes
)
VALUES
(
    -- Id - INT
    'Horror', -- GenreName - nvarchar
    'Yaaaaaa' -- Notes - nvarchar
),
('Comedy','Muhahaha'),
('Action','HuuuuYaaaa'),
('Drama','Mama Mia'),
('Thriler',Null)

CREATE TABLE Categories (Id int IDENTITY PRIMARY KEY NOT NULL, 
						CategoryName nvarchar(10) NOT NULL,
						Notes nvarchar( max))

INSERT INTO dbo.Categories
(
    --Id - column value is auto-generated
    CategoryName,
    Notes
)
VALUES
(
    -- Id - int
    'Nai novi', -- CategoryName - nvarchar
    'ima oshte' -- Notes - nvarchar
),
('Po stari', NULL),
('Clasics', 'Ei tva e '),
('Interesni', NULL),
('Tapite ', NULL)


 CREATE TABLE Movies (Id int IDENTITY PRIMARY KEY NOT NULL,
 Title nvarchar(30) NOT NULL,
 DirectorId INT NOT NULL, 
 CopyrightYear datetime2,
 [Length] decimal(5,2) ,
 GenreId INT NOT NULL, 
 CategoryId INT , 
 Rating decimal(4,2), 
 Notes nvarchar(max))

 INSERT INTO Movies
 (
     --Id - column value is auto-generated
     Title,
     DirectorId,
     CopyrightYear,
     Length,
     GenreId,
     CategoryId,
     Rating,
     Notes
 )
 VALUES
 (
     -- Id - int
     'Ala Bala', -- Title - nvarchar
     123456, -- DirectorId - INT
     '2/2/2020', -- CopyrightYear - datetime2
     95.02, -- Length - decimal
     2365, -- GenreId - INT
     1582, -- CategoryId - INT
     9.51, -- Rating - decimal
     'Muhahaha' -- Notes - nvarchar
 ),
 ('Balalaika',13456,'12/20/2020',23.02,1152,1282,7.50,'Buhahaha'),
 ('Tarataika',156,'11/02/2018',13.02,1052,1202,6.50,'Trarara'),
 ('Gushimaika',23456,'08/10/2010',63.02,1652,1202,4.50,'Gushuhuhu'),
 ('Mincifaika',1000,'10/23/2012',83.02,1952,1982,7.35,'Buhahaha')

