#Экзаменационное задание от 240822
/*
 * Необходимо написать следующие запросы к базе данных
«Книжный магазин»:
1. Показать все книги, количество страниц в которых больше
500, но меньше 650.
2. Показать все книги, в которых первая буква названия либо
«А», либо «З».
3. Показать все книги жанра «Детектив», количество проданных книг более 30 экземпляров.
4. Показать все книги, в названии которых есть слово «Microsoft», но нет слова «Windows».
5. Показать все книги (название, тематика, полное имя автора
в одной ячейке), цена одной страницы которых меньше
65 копеек.
6. Показать все книги, название которых состоит из 4 слов.
7. Показать информацию о продажах в следующем виде:
▷ Название книги, но, чтобы оно не содержало букву «А».
▷ Тематика, но, чтобы не «Программирование».
▷ Автор, но, чтобы не «Герберт Шилдт».
▷ Цена, но, чтобы в диапазоне от 10 до 20 гривен.
▷ Количество продаж, но не менее 8 книг.
▷ Название магазина, который продал книгу, но он не
должен быть в Украине или России.

8. Показать следующую информацию в два столбца (числа
в правом столбце приведены в качестве примера):
▷ Количество авторов: 14
▷ Количество книг: 47
▷ Средняя цена продажи: 85.43 грн.
▷ Среднее количество страниц: 650.6.
9. Показать тематики книг и сумму страниц всех книг по
каждой из них.
10. Показать количество всех книг и сумму страниц этих книг
по каждому из авторов.
11. Показать книгу тематики «Программирование» с наибольшим количеством страниц.
12. Показать среднее количество страниц по каждой тематике,
которое не превышает 400.
13. Показать сумму страниц по каждой тематике, учитывая
только книги с количеством страниц более 400, и чтобы
тематики были «Программирование», «Администрирование» и «Дизайн».
14. Показать информацию о работе магазинов: что, где, кем,
когда и в каком количестве было продано.
15. Показать самый прибыльный магазин.

*/
CREATE DATABASE BookShop; #Книжный магазин
Use BookShop;
CREATE TABLE Countries(  #3.Страны
	Id int auto_increment not  null primary key,	
	Name varchar(20) not null unique check (Name is not null) #Название страны.
);
CREATE TABLE Authors(  #1.Авторы
	Id int auto_increment not  null primary key,	
	Name varchar(255) not null  check (Name is not null), #Имя автора
	Surname varchar(255) not null check (Surname is not null),# Фамилия 
	CountryId int  not null, #Вешний ключ ---------------------	
	FOREIGN KEY (CountryId)  REFERENCES Countries (Id) #Страны
);

CREATE TABLE Shops(  #5. Магазины
	Id int auto_increment not  null primary key,	
	Name varchar(255) not null  check (Name is not null), #Название магазина
	CountryId int  not null, #Вешний ключ ---------------------	
	FOREIGN KEY (CountryId)  REFERENCES Countries (Id) #Страна, в которой
);

CREATE TABLE Themes(  #6.Тематики
	Id int auto_increment not  null primary key,	
	Name varchar(100) not null unique check (Name is not null) # Название тематики.
);

CREATE TABLE Books(  #2.Книги
	Id int auto_increment not  null primary key,	
	Name varchar(255) not null  check (Name is not null), #Название книги
	Pages int not null CHECK (Pages >= 0) ,#Количество страниц в книге.
	Price DECIMAL(9,2) not null CHECK (Price > 0) ,#Цена книги.
	PublishDate DATE not null,
	AuthorId int  not null, #Вешний ключ ---------------------	
	FOREIGN KEY (AuthorId)  REFERENCES Authors (Id), #Автор книги.
	ThemeId int  not null, #Вешний ключ ---------------------	
	FOREIGN KEY (ThemeId)  REFERENCES Themes (Id) #Тематика книги.
);
ALTER table Books add check(PublishDate  < NOW());

CREATE TABLE Sales(  #4.Продажи
	Id int auto_increment not  null primary key,	
	Price DECIMAL(9,2) not null CHECK (Price > 0) ,#Цена продажи одного экземпляра книги
	Quantity int not null CHECK (Quantity >= 0) ,#Количество проданных экзем
	SaleDate DATE not null default NOW(),
	BookId int  not null, #Вешний ключ ---------------------	
	FOREIGN KEY (BookId)  REFERENCES Books (Id), #Проданная книга.
	ShopId int  not null, #Вешний ключ ---------------------	
	FOREIGN KEY (ShopId)  REFERENCES Shops (Id) #Магазин, в котором
);
ALTER table Sales add check(SaleDate <= NOW());
SHOW TABLES;
INSERT into Countries VALUES (1,'РФ'),(2,'КНДР'),(3,'Индия');
SELECT * from Countries;
INSERT into Authors VALUES (1,'Игнатий','Брянчанинов',1),(2,'Мао','Дзидун',2),(3,'Майя','Кучерская',1);
INSERT into Authors VALUES (4,'Герберт','Шилдт',3);
SELECT * from Authors;
INSERT into Shops VALUES (1,'Карандаш',1),(2,'Киркуду',2);
SELECT * from Shops;
INSERT into Themes VALUES (1,'Философия'),(2,'Поэзия');
INSERT into Themes VALUES (3,'Детектив');
INSERT into Themes VALUES (4,'Программирование');
SELECT * from Themes;
INSERT into Books VALUES (1,'яяяяя',23,123,'2020-02-03',3,2);
INSERT into Books VALUES (2,'Задание',550,123,'2021-02-03',3,2);
INSERT into Books VALUES (3,'Абракадабра',750,823,'2019-02-03',3,2);
INSERT into Books VALUES (4,'Детектив',540,823,'2019-02-03',3,3);
INSERT into Books VALUES (5,'Детектив-2',140,223,'2019-02-03',3,3);
INSERT into Books VALUES (6,'Office Microsoft',14,23,'2019-02-03',2,2),(7,'Microsoft Windows',4,13,'2019-02-03',2,2);
INSERT into Books VALUES (8,'Плач по уехавшей учительнице',140,223,'2019-02-03',3,3);
INSERT into Books VALUES (9,'Плач по уехавшей учительнице рисования',140,223,'2019-02-03',3,3);
# Id,Name,Pages,Price,PublishDate,AuthorId,ThemeId #Тематика книги.
INSERT into Books VALUES (10,'Java',555,845,'2020-04-01',4,4),(11,'Prolog',555,15,'2020-04-01',4,4),(12,'kotling',555,15,'2020-04-01',3,4)
,(13,'Рубикон',555,15,'2020-04-01',2,2);
INSERT into Books VALUES (14,'Фонт',555,15,'2020-04-01',4,2);
SELECT * from Books;
INSERT into Sales VALUES (1,945,3,'2020-03-03',1,2),(2,845,4,'2020-04-03',1,1);
INSERT into Sales VALUES (3,945,33,'2020-03-03',4,2),(4,845,4,'2020-04-03',5,1);
#	Id,Price,Quantity,SaleDate,BookId,ShopId
INSERT into Sales VALUES (5,16,12,'2020-03-03',13,2),(6,17,9,'2020-04-03',13,1);
INSERT into Sales VALUES (7,16,3,'2020-04-03',13,2),(8,17,6,'2020-05-03',13,1);
SELECT * from Sales;#Продажи
#---------------------------------------------------
#1. Показать все книги, количество страниц в которых больше 500, но меньше 650.
SELECT Name FROM Books b WHERE Pages > 500 AND  Pages < 650;
#2. Показать все книги, в которых первая буква названия либо «А», либо «З»
SELECT Name FROM Books b WHERE (Name LIKE 'З%') OR (Name LIKE 'А%');
#3. Показать все книги жанра «Детектив», количество проданных книг более 30 экземпляров.
SELECT b.Name FROM Books b 
JOIN Themes t on t.Id =b.ThemeId 
JOIN Sales s on s.BookId =b.Id 
WHERE t.Name = 'Детектив' AND s.Quantity >30
;
#4. Показать все книги, в названии которых есть слово «Microsoft», но нет слова «Windows».
SELECT Name FROM Books b WHERE NOT (Name REGEXP  'Windows') AND (Name REGEXP 'Microsoft');
#5. Показать все книги (название, тематика, полное имя автора в одной ячейке), цена одной страницы которых меньше 65 копеек.
SELECT CONCAT_WS(' ! ', b.Name, t.Name, a.Surname ,a.Name  ) 
#,b.Price ,b.Pages,b.Price /b.Pages
FROM Books b 
JOIN Themes t on t.Id =b.ThemeId 
JOIN Authors a on a.Id =b.AuthorId 
WHERE b.Price /b.Pages < 0.65
;
#6. Показать все книги, название которых состоит из 4 слов
#SELECT SUBSTRING_INDEX(CONCAT('z ',b.Name),' ',-5) FROM Books b; 
SELECT Name FROM Books b 
WHERE NOT ( SUBSTRING_INDEX(CONCAT('z ',b.Name),' ',-4)  LIKE 'z%')
AND ( SUBSTRING_INDEX(CONCAT('z ',b.Name),' ',-5)  LIKE 'z%')
;
#7. Показать информацию о продажах в следующем виде:
#▷ Название книги, но, чтобы оно не содержало букву «А».
#▷ Тематика, но, чтобы не «Программирование».
#▷ Автор, но, чтобы не «Герберт Шилдт».
#▷ Цена, но, чтобы в диапазоне от 10 до 20 гривен.
#▷ Количество продаж, но не менее 8 книг.
#▷ Название магазина, который продал книгу, но он не
#должен быть в Украине или России.
Use BookShop;
/*
SELECT * FROM Books b;

SELECT s.BookId ,SUM(s.Quantity) as 'Количество продаж', s2.Name as 'магазин', c.Name as Country
FROM Sales s
JOIN Shops s2 on s2.Id =s.ShopId 
JOIN Countries c on c.Id = s2.CountryId 
WHERE c.Name != 'РФ' AND c.Name != 'Украина'
GROUP BY s.BookId
HAVING SUM(s.Quantity)>8
;
*/
WITH x AS (
SELECT b.Id ,b.Name as Books, t.Name as  Themes, a.Surname as Surname, a.Name as Authors, b.Price as Price
FROM Books b 
JOIN Themes t on t.Id = b.ThemeId 
JOIN Authors a on a.Id =b.AuthorId 
WHERE b.Name NOT LIKE '%А%' AND t.Name != 'Программирование' AND NOT(a.Surname='Шилдт' AND a.Name ='Герберт') AND b.Price BETWEEN 10 AND 20
),
y AS (
SELECT s.BookId ,SUM(s.Quantity) as Quantity, s2.Name as Shops, c.Name as Country
FROM Sales s
JOIN Shops s2 on s2.Id =s.ShopId 
JOIN Countries c on c.Id = s2.CountryId 
WHERE c.Name != 'РФ' AND c.Name != 'Украина'
GROUP BY s.BookId
HAVING SUM(s.Quantity)>8
)
 SELECT x.Books as 'Название книги', x.Themes as 'Тематика', CONCAT(x.Surname,' ',x.Authors) as Автор,
 x.Price as Цена, y.Quantity as 'Количество продаж',  y.Shops as'Название магазина'
 FROM x,y
 WHERE x.Id = y.BookId
;
#8. Показать следующую информацию в два столбца (числа в правом столбце приведены в качестве примера):
#▷ Количество авторов: 14
#▷ Количество книг: 47
#▷ Средняя цена продажи: 85.43 грн.
#▷ Среднее количество страниц: 650.6.
 SELECT 'Количество авторов:',COUNT(*),' ' 
FROM Authors a 
UNION
 SELECT 'Количество книг:',COUNT(*),' ' 
FROM Books b 
UNION
 SELECT 'Средняя цена продажи:',AVG(s.Quantity),'грн.'
FROM Sales s 
UNION
 SELECT 'Среднее количество страниц:',AVG(b.Pages),' '
FROM Books b 
;
#9. Показать тематики книг и сумму страниц всех книг по каждой из них.
SELECT t.Name as тематики,  SUM(b.Pages) as 'сумму страниц всех книг'
FROM Themes t 
JOIN Books b on b.ThemeId =t.Id 
GROUP by t.Name
;
#10. Показать количество всех книг и сумму страниц этих книг по каждому из авторов.
SELECT COUNT(b2.Id) as 'количество всех книг',  SUM(b2.Pages) as 'сумму страниц этих книг' , CONCAT(a.Surname,' ', a.Name) as автора
FROM  Books b2
JOIN Authors a on b2.AuthorId = a.Id 
GROUP by b2.AuthorId
;
#11. Показать книгу тематики «Программирование» с наибольшим количеством страниц
SELECT MAX(b.Pages) FROM Books b JOIN Themes t on t.Id =b.ThemeId 
WHERE  t.Name = 'Программирование';

SELECT b.Name as книга, b.Pages as 'количество страниц'
FROM Books b 
JOIN Themes t on t.Id =b.ThemeId 
WHERE  t.Name = 'Программирование' AND 
b.Pages = (SELECT MAX(bx.Pages) 
		FROM Books bx
		JOIN Themes t on t.Id =bx.ThemeId 
		WHERE  t.Name = 'Программирование'
)
;
#12. Показать среднее количество страниц по каждой тематике, которое не превышает 400.
SELECT t.Name as тематика, AVG(b.Pages) 
FROM Books b 
JOIN Themes t on t.Id =b.ThemeId 
GROUP by b.ThemeId 
HAVING AVG(b.Pages) < 400
;
#13. Показать сумму страниц по каждой тематике, учитывая только книги с количеством страниц более 400, 
#и чтобы тематики были «Программирование», «Администрирование» и «Дизайн».
SELECT t.Name as тематика, SUM(b.Pages) 
FROM Books b 
JOIN Themes t on t.Id =b.ThemeId 
WHERE b.Pages > 400 and t.Name IN ('Программирование','Администрирование','Дизайн')
GROUP by b.ThemeId
;
#14. Показать информацию о работе магазинов: что, где, кем, когда и в каком количестве было продано.
SELECT s2.Name as 'в магазине',c.Name as 'страны',s.SaleDate , b.Name as 'Книга', s.Quantity as 'Продана в количестве'
FROM Sales s 
JOIN Shops s2 on s2.Id =s.ShopId 
JOIN Books b on b.Id = s.BookId 
JOIN Countries c on c.Id = s2.CountryId 
ORDER by s.ShopId
;
#15. Показать самый прибыльный магазин.
WITH x AS (
	SELECT SUM( (s.Price - b.Price )*s.Quantity) as prb, s2.Name
	FROM Sales s 
	JOIN Shops s2 on s2.Id =s.ShopId 
	JOIN Books b on b.Id = s.BookId 
	GROUP by s2.Id 
)
SELECT x.Name FROM x
WHERE  x.prb = ( SELECT MAX(x.prb) FROM x )
;
