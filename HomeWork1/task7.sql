CREATE TABLE People 
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	[Name] NVARCHAR(200) NOT NULL,
	Picture varbinary CHECK (DATALENGTH(Picture) <= 2097152),
	Height DECIMAL(5,2),
	Weigth DECIMAL(5,2),
	Gender CHAR(1) CHECK(Gender IN('m','f')) NOT NULL,
	Birthdate DATETIME NOT NULL,
	Biography NVARCHAR(MAX)
	)

INSERT INTO People
(
    --Id - column value is auto-generated
    [Name],
    Picture,
    Height,
    Weigth,
    Gender,
    Birthdate,
    Biography
)
VALUES
(
    -- Id - INT
    'PESHO', -- Name - NVARCHAR
    NULL, -- Picture - varbinary
    1.82, -- Height - DECIMAL
    121.2, -- Weigth - DECIMAL
    'm', -- Gender - BIT
    '2021-01-13 12:10:17', -- Birthdate - DATETIME
    'blablabla' -- Biography - NVARCHAR
),

(
    -- Id - INT
    'Goshka', -- Name - NVARCHAR
    NULL, -- Picture - varbinary
    2.82, -- Height - DECIMAL
    89.22, -- Weigth - DECIMAL
    'f' , -- Gender - BIT
    '2020-01-13 12:10:17', -- Birthdate - DATETIME
    'buhaha' -- Biography - NVARCHAR
),
(
    -- Id - INT
    'Minka', -- Name - NVARCHAR
    NULL, -- Picture - varbinary
    1.52, -- Height - DECIMAL
    67.75, -- Weigth - DECIMAL
    'f', -- Gender - BIT
    '1997-09-25 12:10:17', -- Birthdate - DATETIME
    'blablabla' -- Biography - NVARCHAR
),
(
    -- Id - INT
    'Toshka', -- Name - NVARCHAR
    NULL, -- Picture - varbinary
    1.42, -- Height - DECIMAL
    67.75, -- Weigth - DECIMAL
    'f', -- Gender - BIT
    '1987-09-25 12:10:17', -- Birthdate - DATETIME
    'blablablaamama nanan' -- Biography - NVARCHAR
),
(
    -- Id - INT
    'Pinko', -- Name - NVARCHAR
    NULL, -- Picture - varbinary
    1.72, -- Height - DECIMAL
    60.75, -- Weigth - DECIMAL
    'm', -- Gender - BIT
    '1999-09-25 12:10:17', -- Birthdate - DATETIME
    'blablabla' -- Biography - NVARCHAR
)

TRUNCATE TABLE People
SELECT* FROM People