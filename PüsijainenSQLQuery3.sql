--tund 1 03.03.2025
--loome db
create database TARpe24SQL

-- db valimine 
use TARpe24SQL

-- db kustutamine
drop database TARpe24SQL

-- tabeli loomine
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null
)

--andmete sisestamine
insert into Gender (Id, Gender)
values (2, 'Male')
insert into Gender (Id, Gender)
values (1, 'Female')
insert into Gender (Id, Gender)
values (3, 'Unknown')

-- vaatame tabeli sisu
select * from Gender

-- teeme tabeli Person
create table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)


--andmete sisestamine
insert into Person (Id, Name, Email, GenderId)
values (1, 'Superman', 's@s.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (2, 'Wonderwoman', 'w@w.com', 1),
(3, 'Batman', 'b@b.com', 2),
(4, 'Aquaman', 'a@a.com', 2),
(5, 'Catwoman', 'c@c.com', 1),
(6, 'Antman', 'ant"ant.com', 2),
(7, 'Spiderman', 'spider@s.com', 2),
(9, NULL, NULL, 2)

--soovime vaadata Person tabeli andmeid
select * from Person

--v??rv?tme ?henduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

-- kui sisestad uue rea andmeid ja ei ele sisestanud GenderId alla v??rtust,
-- siis see automaatselt sisestab sellele reale v??rtuse 3 e nagu meil
-- on unknown
alter table Person
add constraint DF_Persons_GenderId
default 3 for GenderId

--
insert into Person (Id, Name, Email)
values (11, 'Kalevipoeg', 'k@k.com')

-- piirangu kustutamine
alter table person
drop constraint DF_Persons_GenderId

-- lisame uue veeru
alter table Person
add Age nvarchar(10)

--lisame nr piirangu vanuse sisestamisel
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

--kustutame rea
delete from Person where Id = 11

select * from Person

--kuidas uuendada andmeid
update Person
set Age = 50
where Id = 4

alter table Person
add City nvarchar(50)

--k]ik, kes elavad Gothami linnas
select * from Person where City = 'Gotham'
--k]ik, kes ei ela Gothamis
select * from Person where City != 'Gotham'
--variant nr 2
select * from Person where City <> 'Gotham'

-- n'itab teatud vanusega inimesi
select * from Person where Age = 100 or Age = 35 or Age = 27
select * from Person where Age in (100, 35, 25)

-- n'itab teatud vanusevahemikus olevaid inimesi
select * from Person where Age between 22 and 50

-- wildcard e n?itab k?ik g-t?hega linnad
select * from Person where City like 'g%'
-- k]ik emailid, kus on @-m?rk emailis
select * from Person where Email like '%@%'

--n?itab k?iki, kellel ei ole @-m?rki emailis
select * from Person where Email not like '%@%'

--tund 2

-- näitab, kellel on emailis ees ja peale @märki ainult üks täht
select * from Person where Email like '_@_.com'

-- kõik, kelle on nimes esimene täht W, A, S,
select * from Person where Name like '[^WAS]%'
select * from Person

-- kes elavad Gothamis ja New Yorkis
select * from Person where City = 'Gotham' OR City = 'New York'

-- Kõik, kes elavad Gothamis ja New Yorkis ja on vanemad, kui 29
select * from Person where (City = 'Gotham' OR City = 'New York') AND Age > 29

-- kuvad tähestikulises järjekorras inimesi ja võtab aluseks nime
select * from Person order by Name
-- sama päring, aga vastupidises järjestuses
select * from Person order by Name desc

-- võtab kolm esimest rida 
select top 3 * from Person

-- kolm esimest, aga tabeli järjestuses on Age ja siis Name
select top 3 Age, Name from Person

-- näitab esimesed 50% tabelis
select top 50 percent * from Person

-- järjestab vanuse järgi isikud
select * from Person order by Age desc

-- muudab Age muutuja int'ks ja näitab vanuselises järjestuses
select * from Person order by CAST(Age as int)

-- kõikide isikute koondvanus
select SUM(cast(Age as int)) from Person

-- kuvab kõige nooremat isikut
select MIN(cast(Age as int)) from Person
-- kuvab kõige vanemat isikut
select MAX(cast(Age as int)) from Person

-- konkreestsetes linnades olevate isikute koondvanus
-- enne oliAge nvarhchar, age muudame selle int andmetüübiks
select City, SUM(Age) as totalAge from Person group by City

-- kuidas saab koodiga muuta andmetüübi ja selle pikkust
alter table Person
alter column name nvarchar(25)

-- kuvab esimeses reas välja toodud järjestuses ja kuvab Age Totalage'iks
-- järjestab City's olevate nimede järgi ja siis GenderId järgi
select City, GenderId, SUM(Age) as totalAge from Person
group by City, GenderId order by City

-- näitab ridade arvu tabelis
select COUNT(*) from Person
select * from Person

-- näitab tulemust, et mitu inimest on GenderId väärtusega 2 konkreetses linnas
-- arvutab vanuse kokku selles linnas
select GenderId, City, SUM(Age) as TotalAge, COUNT(Id) as [Total Person(s)]
from Person
where GenderId = '1'
group by GenderId, City

-- loome, tabelid Employees ja Department 

create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50),
)

create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)

-- Tund 3 10.03.25

-- andmete sisestamine Employees tabelisse
insert into Employees(ID, Name, Gender, Salary, DepartmentId)
values 
(1, 'Tom', 'Male', 4000, 1),
(2, 'Pam', 'Female', 3000, 3),
(3, 'John', 'Male', 3500, 1),
(4, 'Sam', 'Male', 4500, 2),
(5, 'Todd', 'Male', 2800, 1),
(6, 'Ben', 'Male', 7000, 1),
(7, 'Sara', 'Female', 4800, 3),
(8, 'Valarie', 'Female', 5500, 1),
(9, 'James', 'Male', 6500, NULL),
(10, 'Russell', 'Male', 8800, NULL)

print('Title Fight')
print('----ALBUMS----')
print('1. No One Stays At The Top Forever')
print('2. Shed')
print('3. Floral Green')
print('4. Spring Songs')
print('5. Hyperview')

-- andmete sisestamine Employees tabelisse
insert into Department(Id, DepartmentName, Location, DepartmentHead)
values 
(1, 'IT', 'London', 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Sydney', 'Cindrella')

-- tabeli andmete vaatamine
select * from Department
select * from Employees

-- teeme left join päringu
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

-- arvutab kõikide palgad kokku
select SUM(CAST(Salary as int)) from Employees
-- tahame teada saada min palga saajat
select MIN(cast(Salary as int)) from Employees

select Location, SUM(cast(Salary as int)) as TotalSalary
from Employees
left join Department
on Employees.DepartmentId = Department.Id
group by Location -- ühe uu palgafond linnade lõikes

alter table Employees
add City nvarchar(30)
select * from Employees
select * from Department

-- näeme palkasid ja eristame neid linnades soo järgi
select City, Gender, SUM(cast(Salary as int)) as TotalSalary 
from Employees group by City, Gender
-- samasugune nagu eelmine päring, aga linnad paneb tähestikulsises järjekorras
select City, Gender, SUM(cast(Salary as int)) as TotalSalary 
from Employees group by City, Gender
order by City asc

-- mitu töötajat on soo ja linna kaupa 

select Gender, City, SUM(cast(Salary as int)) as TotalSalary,
COUNT(Id) as [0Total Employee()s]
from Employees 
group by Gender, City

-- loeb ära tabelis olevate ridade arvu Employees
select COUNT(*) from Employees

-- kuvab ainult mehed linnade kaupa

select Gender, City, SUM(cast(Salary as int)) as TotalSalary,
COUNT(Id) as [0Total Employee()s]
from Employees 
where Gender = 'Male'
group by Gender, City

-- samasugune päring, aga kasutame having ning kõik naised
select Gender, City, SUM(cast(Salary as int)) as TotalSalary,
COUNT(Id) as [0Total Employee()s]
from Employees 
group by Gender, City
having Gender = 'Female'

-- kõik, kes teeninivad palka üle 4000
select Name, Salary 
from Employees
where Salary > 4000

-- kasutame having. et teha samasugune päring
select Gender, City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees group by Gender, City
having sum(cast(Salary as int)) > 4000

-- väike for loop
Declare @i int = 0

while @i < 20
BEGIN
	Set @i = @i + 1
	print('Durak is the best card game ever')
END

-- loome tabeli, milles hakatakse automaatselt Id-d nummerdama
create table Test1
(
Id int identity(1, 1),
Value nvarchar(20)
)

-- sisestan andmed ja Id nummerdatakse automaatselt
insert into Test1 values('X')
select * from Test1

Declare @i int = 0

while @i < 20
BEGIN
	Set @i = @i + 1
	insert into Test1 values('X')
END
select * from Test1

-- kustutame veeru nimega City tabelist Employees
alter table Employees
drop column City
select * from Employees

-- inner join
-- kuvab neid, kellel on DepartmentName all olemas väärtus

select Name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Employees.DepartmentId = Department.Id

-- left join
-- kuidas kõik andmed Employees-t kätte saada
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

-- right join 
-- kuidas saada DepartmentName alla uus nimetus e antud juhul Other Department
select Name, Gender, Salary, DepartmentName
from Employees
right join Department -- võib kasutada ka RIGHT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

-- kuidas saada kõikid tabelite väärtued ühte päringusse
select Name, Gender, Salary, DepartmentName
from Employees
FULL OUTER JOIN Department
on Employees.DepartmentId = Department.Id

-- cross join
select Name, Gender, Salary, DepartmentName
from Employees
CROSS JOIN Department

-- päringu sisu
-- select ColumnList
-- from LeftTable
-- joinType RightTable
-- on JoinCondition

-- inner join
select Name, Gender, Salary, DepartmentName
from Employees
INNER JOIN Department
on Employees.DepartmentId = Department.Id

-- kuidas kuvada ainult need isikud, kellel on DepartmentName NULL
-- left Joini kasutada
select Name, Gender, Salary, DepartmentName
from Employees
LEFT JOIN Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

-- teine variant 
select Name, Gender, Salary, DepartmentName
from Employees
LEFT JOIN Department
on Employees.DepartmentId = Department.Id
where Department.Id is null

-- kuidas saame Department tabelis oleva rea, kus on NULL
select Name, Gender, Salary, DepartmentName
from Employees
RIGHT JOIN Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
or Department.Id is null

select * from Department

-- saame muuta tabeli nimetust, alguses vana tabeli nimi ja siis uus soovitud
sp_rename 'Department1', 'Department' 

-- kasutame Employees tabeli asemel muutujat E ja M
select E.Name as Employee, M.Name as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

alter table Employees 
add ManagerId int 

-- inner join
-- kuvab ainult ManagerId all olevate isikute väärtuseid
select E.Name as employee, M.Name as manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id

-- kõik saavad käõikide ülemused olla

select E.Name as employee, M.Name as manager
from Employees E
cross join Employees M
