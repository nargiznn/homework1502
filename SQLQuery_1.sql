---Course db yaradırsınız
CREATE DATABASE Course
----Students table
---Id
---Fullname - required
--- Email - unique
---Point - 0-100 araliginda olmalidir
CREATE TABLE Students
(
    Fullname NVARCHAR(40) Not NULL,
    Email NVARCHAR(40) UNIQUE,
    Point TINYINT CHECK(Point>=0 AND Point<=100)

)
DROP TABLE Students

SELECT* FROM Students


INSERT INTO Students
VALUES
(1,N'Aysel Əsgərova','aysel@gmail.com',92),
(2,N'Vaqif Məmmədov','vaqif@gmail.com',78),
(3,'Leyla Nadirova','leyla@gmail.com',67),
(4,'Hikmet Abdullayev','hikmet@gmail.com',52),
(5,N'Nərmine Quluyeva','nermine@gmail.com',45)


SELECT AVG(Point) FROM Students --umumi ortalama
---Point dəyəri bütün tələbə pointlərinin ortalamasından böyük olan tələbəli select edən query
SELECT* FROM Students
WHERE Point>(SELECT AVG(Point) FROM Students)

---Students datalarını Id, Name,Point columnları kimi select edən query (burada fullname-i substring edib as Name kimi select edin)
SELECT 
Id,SUBSTRING(Fullname,1,CHARINDEX(' ',Fullname)-1) AS Name , Point FROM Students

---Student datalarının email domainlərini (@-dən sonraki hissə) select edən query
SELECT SUBSTRING(Email,CHARINDEX('@',Email)+1,LEN(Email)) AS Domain
FROM Students

UPDATE Students
SET Email=REPLACE(Email,'gmail.com','code.edu.az')
WHERE Id IN(3,5)


