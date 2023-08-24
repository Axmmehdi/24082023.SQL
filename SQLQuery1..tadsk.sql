CREATE DATABASE Librarry

CREATE TABLE Books(
 Id INT PRIMARY KEY IDENTITY,
 Name NVARCHAR(100) NOT NULL Check(Len(Name) >= 2),
 PageCount INT NOT NULL CHECK(PageCount>10),
)


 CREATE TABLE Authors(
   Id INT PRIMARY KEY IDENTITY,
   Name NVARCHAR(100) NOT NULL,
   SurName NVARCHAR(100) NOT NULL,
 )

 CREATE TABLE AuthorsBooks(
   Id INT PRIMARY KEY IDENTITY,
   BooksId INT FOREIGN KEY REFERENCES Books(Id),
   AuthorsId INT FOREIGN KEY REFERENCES Authors(Id),
 )

 CREATE VIEW  usv_GetAuthorBooks
 as
Select b.Id, b.Name, b.PageCount, a.Name+' '+a.SurName as AuthorFullName  From Authors a
join AuthorsBooks ab
on
ab.AuthorsId=a.Id
join Books b 
on	
b.id=ab.BooksId

Create Procedure usp_GetAuthorBooks
(@PageCount int, @Name nvarchar)
as
begin
	Select b.Id, b.Name, b.PageCount, a.Name+' '+a.SurName as AuthorFullName From Authors a
	join AuthorsBooks ab
	on a.Id=ab.AuthorsId
	join Books b
	on b.Id=ab.BooksId 
	where @PageCount>PageCount
end




Create Procedure usp_InsAuthorBooks
@id int
as
begin
	Select  b.Id, b.Name, b.PageCount, a.Name+' '+a.SurName as AuthorFullName From Authors a
	join Groups g
	on s.GroupId = g.Id
	join TeacherGroups tg
	on tg.GroupId = g.Id
	join Teachers t
	on t.Id = tg.TeacherId where Age > @age
end





