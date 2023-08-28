CREATE DATABASE KontaktHome

CREATE TABLE Brands(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(150) NOT NULL UNIQUE,
)




CREATE TABLE Notebooks(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(150) NOT NULL,
Price MONEY,
BrandId INT FOREIGN KEY	 REFERENCES Brands(Id)
)


CREATE TABLE Phones(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(150) NOT NULL,
Price MONEY,
BrandId INT FOREIGN KEY	 REFERENCES Brands(Id)
)

--Notebooks Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.

SELECT B.Name as BrandName, N.Name as NotebooksName, N.Price FROM Notebooks N
JOIN Brands B
ON B.Id=N.BrandId

--Phones Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.
SELECT B.Name as BrandName, P.Name as PhoneName, P.Price FROM Phones P
JOIN Brands B
ON B.Id=P.BrandId


-- Brand Adinin Terkibinde s Olan Butun Notebooklari Cixardan Query.
Select * From Notebooks Where Name Like '%s%'

-- Qiymeti 2000 ve 5000 arasi ve ya 5000 den yuksek Notebooklari Cixardan Query.

Select * From Notebooks Where Price BETWEEN 2000 AND 5000 OR Price > 5000;

--Qiymeti 1000 ve 1500 arasi ve ya 1500 den yuksek Phonelari Cixardan Query.

Select * From Phones WHERE Price BETWEEN 1000 AND 1500 OR Price > 1500;

--Her Branda Aid Nece dene Notebook Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.

Select b.Name as BrandName, COUNT( N.Id)as 'Stock' from  Brands b 
 left join Notebooks N
on 
b.Id=n.BrandId
GROUP BY b.Id, b.Name;


--Her Branda Aid Nece dene Phone Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query
Select b.Name as BrandName, COUNT( P.Id)as 'Stock' from  Phones P
 right join Brands B
on 
b.Id=P.BrandId
GROUP BY b.Id, b.Name;

-- Hem Phone Hem de Notebookda Ortaq Olan Name ve BrandId Datalarni Bir Cedvelde Cixardan Query.??????????????????????????????????????????????????????????????????????

Select N.Name, N.BrandId from Notebooks N
join Phones P
on
P.Name=N.Name and N.BrandId=P.BrandId




--Phone ve Notebook da Id, Name, Price, ve BrandId Olan Butun Datalari Cixardan Query.

SELECT Id, Name, Price, BrandId FROM Notebooks
UNION ALL
SELECT Id, Name, Price, BrandId FROM Phones;


--Phone ve Notebook da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalari Cixardan Query.

SELECT N.Id, N.Name, n.Price, B.Name as BrandName FROM Notebooks N
JOIN Brands B
ON N.BrandId = B.Id
UNION ALL
SELECT P.Id, P.Name as PhoneName, P.Price, B.Name AS BrandName FROM Phones P
 JOIN Brands B
ON P.BrandId = B.Id;


-- Phone ve Notebook da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalarin Icinden Price 1000-den Boyuk Olan Datalari Cixardan Query.

SELECT N.Id, N.Name, n.Price, B.Name as BrandName FROM Notebooks N
JOIN Brands B
ON N.BrandId = B.Id
where N.Price>1000
UNION ALL
SELECT P.Id, P.Name as PhoneName, P.Price, B.Name AS BrandName FROM Phones P 
JOIN Brands B
ON P.BrandId = B.Id
where P.Price>1000

--Phones Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi (BrandName kimi), Hemin Brandda Olan Telefonlarin Pricenin Cemi (TotalPrice Kimi) ve Hemin Branda Nece dene Telefon Varsa Sayini (ProductCount Kimi) Olan Datalari Cixardan Query.

SELECT B.Name AS BrandName, SUM(P.Price) AS TotalPrice, COUNT(P.Id) AS ProductCount FROM Phones P
 JOIN Brands B
 ON P.BrandId = B.Id
GROUP BY B.Name;

--Notebooks Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi (BrandName kimi), Hemin Brandda Olan Telefonlarin Pricenin Cemi (TotalPrice Kimi) , Hemin Branda Nece dene Telefon Varsa Sayini (ProductCount Kimi) Olacaq ve Sayi 3-ve 3-den Cox Olan Datalari Cixardan Query

SELECT B.Name AS BrandName, SUM(N.Price) AS TotalPrice, COUNT(N.Id) AS ProductCount FROM Notebooks N
 JOIN Brands B
 ON N.BrandId = B.Id
GROUP BY B.Name;