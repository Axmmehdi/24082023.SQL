CREATE DATABASE [LIBRARY]

CREATE TABLE Books(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(100) CHECK(LEN(Name)>=2),
PageCount INT CHECK(PageCount>=10),
AuthorId INT FOREIGN KEY REFERENCES Authors(Id)
)


CREATE TABLE Authors(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(100) NOT NULL,
SurName NVARCHAR(100)
)


CREATE VIEW usv_AuthorBook
As
Select B.Name [Book name],B.PageCount, A.Name+ ' ' +A.Surname AS [Author] from Authors A
join Books B
on
A.ID=B.ID 
where PageCount>300

SELECT * FROM usv_AuthorBook

CREATE PROCEDURE usp_BookAuthorCount
( @ID int,@Name nvarchar, @PageCount int)
As
BEGIN
   Select b.Name [Book name],b.PageCount, A.Name+ ' '+A.Surname AS [Author] from Authors A
	join Books B
	on
	A.ID=B.ID 
	where
	PageCount>@PageCount or A.ID=@ID or B.Name=@Name
END



CREATE PROCEDURE usp_AuthorInsert
@Name NVARCHAR(100),
@Surname NVARCHAR(100)
AS
BEGIN
    INSERT INTO Authors (Name, Surname)
    VALUES (@Name, @Surname);
END;

CREATE PROCEDURE usp_AuthorUpdate
@ID INT,
@Name NVARCHAR(100),
@Surname NVARCHAR(100)
AS
BEGIN
    UPDATE Authors
    SET Name = @Name, Surname = @Surname
    WHERE ID = @ID;
END;


CREATE PROCEDURE usp_AuthorDelete
@ID INT
AS
BEGIN
    DELETE FROM Authors
    WHERE ID = @ID;
END;



CREATE VIEW usv_MaxCountPage AS
SELECT 
    A.ID AS Id,
    A.Name + ' ' + A.Surname AS FullName,
    COUNT(B.ID) AS BooksCount,
    MAX(B.PageCount) AS MaxCountPage
FROM 
    Authors A
 JOIN 
    Books B ON A.ID = B.AuthorId
GROUP BY 
    A.ID, A.Name, A.Surname;