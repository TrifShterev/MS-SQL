CREATE TABLE Countries (
Id INT Primary key IDENTITY,
Name nvarchar(50) UNIQUE 
)

CREATE TABLE Customers(
Id INT Primary key IDENTITY,
FirstName nvarchar(25),
LastName nvarchar(25),
Gender char(1) CHECK(Gender IN ('M', 'F')),
Age INT,
PhoneNumber char(10),
CountryId INT REFERENCES Countries(Id)
)

CREATE TABLE Products(
Id INT PRIMARY KEY IDENTITY,
Name nvarchar(25) UNIQUE,
Description nvarchar(250),
Recipe nvarchar(MAX),
Price MONEY

)

CREATE TABLE Feedbacks(
Id INT PRIMARY KEY IDENTITY,
Description nvarchar(255),
Rate DECIMAL(4,2),
ProductId INT REFERENCES Products(Id),
CustomerId INT REFERENCES Customers(Id)
)

CREATE TABLE Distributors(
Id INT PRIMARY KEY IDENTITY,
Name nvarchar(25) UNIQUE,
AddressText nvarchar(30),
Summary nvarchar(200),
CountryId INT REFERENCES Countries(Id)
)

CREATE TABLE Ingredients(
Id INT PRIMARY KEY IDENTITY,
Name nvarchar(25) ,
Description nvarchar(200),
OriginCountryId INT REFERENCES Countries(Id),
DistributorId INT REFERENCES Distributors(Id)

)

CREATE TABLE ProductsIngredients(
ProductId INT ,
IngredientId INT,
CONSTRAINT PK_ProductsIngredients
PRIMARY KEY(ProductId,IngredientId),
FOREIGN KEY (ProductId) REFERENCES Products(Id),
FOREIGN KEY (IngredientId) REFERENCES Ingredients(Id)
)
