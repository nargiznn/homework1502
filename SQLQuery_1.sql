CREATE DATABASE Restaurant
USE Restaurant
CREATE TABLE Meals
(
    Id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(50),
    Price MONEY
)

DROP TABLE Meals
DROP TABLE ORDERS
DROP TABLE TABLES

CREATE TABLE Orders
(
    Id INT PRIMARY KEY ,
    MealId INT,
    TableId INT,
    DateTime DATETIME2,
)

CREATE TABLE Tables
(
    Id INT PRIMARY KEY ,
    No INT
)

ALTER TABLE Orders 
ADD CONSTRAINT OR_MEID FOREIGN KEY (MealId) REFERENCES Meals(Id) 

ALTER TABLE Orders 
ADD CONSTRAINT Or_TableId FOREIGN KEY (TableId) REFERENCES Tables(Id) 

INSERT INTO Tables
VALUES
(1,101),
(2,102),
(3,103),
(4,104),
(5,105)

INSERT INTO Meals(Name,Price)
VALUES
('Pizza',23),
('Hamburger',13),
(N'Dönər',5),
(N'Köftə',7),
('Pide',8)
SELECT* FROM Meals
INSERT INTO Orders(Id,MealId,TableId,Datetime)
VALUES
(1,1,1,'14:00')

INSERT INTO Orders(Id,MealId,TableId,Datetime)
VALUES
(2,2,2,'15:00'),
(3,3,3,'15:30'),
(4,4,4,'16:00'),
(5,5,5,'17:00')

INSERT INTO Orders(Id,MealId,TableId,Datetime)
VALUES
(6,3,1,'14:00'),
(7,4,3,'15:30'),
(8,4,4,'16:00'),
(9,5,5,'17:00')


--- - Bütün masa datalarını yanında o masaya edilmiş sifariş sayı ilə birlikdə select edən query
SELECT
T.Id AS TablesId,
T.No AS TablesNo,
O.Id AS OrderId,
O.MealId AS OrderMealId,
O.DateTime AS Datetime,
(SELECT COUNT(*) FROM Orders AS Ors WHERE Ors.TableId=T.Id) AS OrderCount
FROM Tables AS T
JOIN Orders AS O 
ON O.TableId=T.Id

---- Bütün yeməkləri o yeməyin sifariş sayı ilə select edən query
SELECT M.Id,M.Name,
(SELECT COUNT(*) FROM Orders  WHERE Orders.MealId=M.Id) AS MealCount
FROM Meals AS M

--- Bütün sifariş datalarını yanında yeməyin adı ilə select edən query
SELECT O.*,
M.Name AS MealName
FROM Orders AS O
JOIN Meals AS M
ON O.MealId=M.Id


----Bütün sirafiş datalarını yanında yeməyin adı və masanın nömrəsi  ilə select edən query
SELECT
O.Id,
O.TableId,
Tables.No AS TableNO,
O.MealId,
O.DateTime,
M.Name AS MealName
FROM Orders AS O
JOIN Meals AS M
ON O.MealId=M.Id
JOIN Tables ON O.TableId=Tables.Id

---Bütün masa datalarını yanında o masının sifarişlərinin ümumi məbləği ilə select edən query 
SELECT
T.Id AS TablesId,
T.No AS TableNo,
(SELECT SUM(M.Price) FROM Orders AS O JOIN Meals AS M ON O.MealId=M.Id  WHERE O.TableId=T.Id) AS Total 
FROM Tables AS T

---- 1-idli masaya verilmis ilk sifarişlə son sifariş arasında neçə saat fərq olduğunu select edən query
SELECT
T.Id AS TableId,
T.TableName,
MIN(O.DATETIME2) AS FIRST,
MAX(O.DATETIME2) AS LAST,
DATEDIFF(hour,MIN(O.DATETIME2),MAX(O.DATETIME2)) AS HOURDIFF
FROM TABLES AS T
JOIN Orders AS O ON T.Id=O.TableId
WHERE T.Id=1


-----ən son 30-dəqədən əvvəl verilmiş sifarişləri select edən query
SELECT
O.Id,
O.TableId,
O.MealId,
O.DateTime,
MAX(O.DATETIME2) AS LAST,
M.Name AS MealName
FROM Orders AS O
JOIN Meals AS M ON O.MealId = M.Id
WHERE DATEDIFF(MINUTE,GETDATE(),MAX(O.DATETIME2)) <30


---heç sifariş verməmiş masaları select edən query
SELECT * FROM Tables AS T
WHERE  NOT EXISTS(SELECT *FROM Orders AS O WHERE O.TableId=T.Id)




