﻿--tund 1 03.03.2025
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

--v��rv�tme �henduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

-- kui sisestad uue rea andmeid ja ei ele sisestanud GenderId alla v��rtust,
-- siis see automaatselt sisestab sellele reale v��rtuse 3 e nagu meil
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

-- wildcard e n�itab k�ik g-t�hega linnad
select * from Person where City like 'g%'
-- k]ik emailid, kus on @-m�rk emailis
select * from Person where Email like '%@%'

--n�itab k�iki, kellel ei ole @-m�rki emailis
select * from Person where Email not like '%@%'

--tund 2 07.03.2025

--n�itab, kellel on emailis ees ja peale @-m�rki ainult �ks t�ht
select * from Person where Email like '_@_.com'

--k�ik, kellel on nimes t�ht W, A, S
select * from Person where Name like '[^WAS]%'
select * from Person

--kes elavad Gothamis ja New Yorkis
select * from Person where City = 'Gotham' or City = 'New York'

--- k�ik, kes elavad Gothami ja New Yorki linnas ja on vanemad, kui 29
select * from Person where (City = 'Gotham' or City = 'New York') and Age >=30

--kuvab t�hestikulises j�rjekorras inimesi ja v�tab auseks nime
select * from Person order by Name
--sama p�ring, aga vastupidises j�rjestuses on nimed
select * from Person order by Name desc

-- v�tab kolm esimest rida
select top 3 * from Person

--kolm esimest, aga tabeli j�rjestus on Age ja siis Name
select top 3 Age, Name from Person

--n�itab esimesed 50% tabelis
select top 50 percent * from Person

--j�rjestab vanuse j�rgi isikud
select * from Person order by Age desc

-- muudab Age muutuja intiks ja n�itab vanuselises j�rjestuses
select * from Person order by cast(Age as int)

--k�ikide isikute koondvanus
select sum(cast(Age as int)) from Person

-- kuvab k�ige nooremat isikut
select min(cast(Age as int)) from Person
-- kuvab k�ige vanemat isikut
select max(cast(Age as int)) from Person

-- konkreetsetes linnades olevate isikute koondvanus
-- enne oli Age nvarchar, aga muudame selle int andmet��biks
select City, sum(Age) as totalAge from Person group by City

-- kuidas saab koodiga muuta andmet��pi ja selle pikkust
alter table Person
alter column Name nvarchar(25)

--kuvab esimeses reas v�lja toodud j�rjestuses ja kuvab Age TotalAge-ks
-- j�rjestab City-s olevate nimede j�rgi ja siis GenderId j�rgi
select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId order by City

--n�itab ridade arvu tabelis
select count(*) from Person
select * from Person

--n�itab tulemust, et mitu inimest on genderId v��rtusega 2 konkreetses linnas
-- arvutab vanuse kokku selles linnas
select GenderId, City, sum(Age) as TotalAge, count(Id) as [Total Person(s)]
from Person
where GenderId = '2'
group by GenderId, City

--- loome, tabelid Employees ja Department

create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)

create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)

--rida 208
-- 3tund 10.03.2025

--andmete sisestamine Employees tabelisse
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (1, 'Tom', 'Male', 4000, 1),
(2, 'Pam', 'Female', 3000, 3),
(3, 'John', 'Male', 3500, 1),
(4, 'Sam', 'Male', 4500, 2),
(5, 'Todd', 'Male', 2800, 2),
(6, 'Ben', 'Male', 7000, 1),
(7, 'Sara', 'Female', 4800, 3),
(8, 'Valarie', 'Female', 5500, 1),
(9, 'James', 'Male', 6500, NULL),
(10, 'Russell', 'Male', 8800, NULL)

--andmete sisestamine Department tabelisse
insert into Department(Id, DepartmentName, Location, DepartmentHead)
values 
(1, 'IT', 'London', 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Sydney', 'Cindrella')

--tabeli andmete vaatamine
select * from Employees
select * from Department

-- teeme left join p�ringu
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

--arvutab k�ikide palgad kokku
select sum(cast(Salary as int)) from Employees
-- tahame teada saada min palga saajat
select min(cast(Salary as int)) from Employees

select Location, sum(cast(Salary as int)) as TotalSalary
from Employees
left join Department
on Employees.DepartmentId = Department.Id
group by Location --�he kuu palgafond linnade l�ikes

alter table Employees
add City nvarchar(30)
select * from Employees
select * from Department

--n�eme palkasid ja eristame linnades soo j�rgi
select City, Gender, sum(cast(Salary as int)) as TotalSalary 
from Employees group by City, Gender
--samasugune nagu eelmine p�ring, aga linnad paneb t�hestikulises j�rjekorras
select City, Gender, sum(cast(Salary as int)) as TotalSalary 
from Employees group by City, Gender
order by City

--mitu t��tajat on soo ja linna kaupa selles firmas
select Gender , City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City

--loeb �ra tabelis olevate ridade arvu (Employees)
select count(*) from Employees

-- kuvab ainult mehede linnade kaupa
select Gender , City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
where Gender = 'Male'
group by Gender, City

--samasugune p�ring, aga kasutame having ning k]ik naised
select Gender , City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City
having Gender = 'Female'

-- k]ik, kes teenivad palka �le 4000, siin on viga sees
select * from Employees where sum(cast(Salary as int)) > 4000
-- korrektne p�ring
select * from Employees where Salary > 4000

--kasutame having, et teha samasugune p�ring
select Gender , City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees group by Gender, City
having sum(cast(Salary as int)) > 4000
-- see on vigane p�ring
select Gender , City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees group by Gender, City
having Salary > 4000

-- loome tabeli, milles hakatakse automaatselt Id-d nummerdama
create table Test1
(
Id int identity(1,1),
Value nvarchar(20)
)
--sisestan andmed ja Id nummerdatakse automaatselt
insert into Test1 values('X')
select * from Test1

-- kustutame veeru nimega City tabelist Employees
alter table Employees
drop column City

-- inner join 
-- kuvab neid, kellel on Departmentname all olemas v��rtus
select Name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Employees.DepartmentId = Department.Id

-- left join
-- kuidas saada k�ik andmed Employees-t k�tte saada
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

-- right join 
-- kuidas saada DepartmentName alla uus nimetus e antud juhul Other Department
select Name, Gender, Salary, DepartmentName
from Employees
RIGHT JOIN Department --v]ib kasutada ka RIGHT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

-- kuidas saada k�ikide tabelite v��rtused �hte p�ringusse
--outer join
select Name, Gender, Salary, DepartmentName
from Employees
full outer JOIN Department
on Employees.DepartmentId = Department.Id

-- cross join
select Name, Gender, Salary, DepartmentName
from Employees
cross join Department

-- p�ringu sisu
Select ColumnList
from LeftTable
joinType RightTable
on JoinCondition

--inner join
select Name, Gender, Salary, DepartmentName
from Employees
inner JOIN Department
on Employees.DepartmentId = Department.Id

-- kuidas kuvada ainult need isikud, kellel on DepartmentName NULL
--left joini kasutada
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

-- teine variant
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Department.Id is null

--- kuidas saame Department tabelis oleva rea, kus on NULL
--right joini tuleb kasutada
select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
or Department.Id is null

select * from Department

--saame muuta tabeli nimetust, alguses vana tabeli nimi ja siis uus soovitud
sp_rename 'Department1' , 'Department'

--kasutame Employees tabeli asemel muutujat E ja M
select E.Name as Employee, M.Name as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

alter table Employees
add ManagerId int


--inner join
-- kuvab ainult ManagerId all olevate isikute v��rtuseid
select E.Name as employee, M.Name as Manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id

-- k�ik saavad k�ikide �lemused olla
select E.Name as employee, M.Name as Manager
from Employees E
cross join Employees M

--rida 411
--- 4tund 14.03.2025

select isnull('Asd', 'No manager') as Manager

-- NULL asemel kuvab No manager
select coalesce(NULL, 'No Manager') as Manager

-- kui Expression on �ige, siis p�neb v��rtuse,
-- mida soovid v�i m�ne teise v��rtuse
case when Expression Then '' else '' end

-- neil kellel ei ole �lemust, siis paneb neile No Manager teksti
select E.Name as Employees, isnull(M.Name, 'No Manager') as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--- teeme p'ringu, kus kasutame case-i
select E.Name as Employee, case when M.Name is null then 'No Manager'
else M.Name end as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

-- lisame tabelisse uued veerud
alter table Employees
add MiddleName nvarchar(30)
alter table Employees
add LastName nvarchar(30)

select * from Employees

-- muudame veru nime
sp_rename 'Employees.Name', 'FirstName'

-- muudame ja lisame andmeid
update Employees
set FirstName = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
where Id = 1

update Employees
set FirstName = 'Pam', MiddleName = NULL, LastName = 'Anderson'
where Id = 2

update Employees
set FirstName = 'John', MiddleName = NULL, LastName = NULL
where Id = 3

update Employees
set FirstName = 'Sam', MiddleName = NULL, LastName = 'Smith'
where Id = 4

update Employees
set FirstName = NULL, MiddleName = 'Todd', LastName = 'Someone'
where Id = 5

update Employees
set FirstName = 'Ben', MiddleName = 'Ten', LastName = 'Sven'
where Id = 6

update Employees
set FirstName = 'Sara', MiddleName = NULL, LastName = 'Connor'
where Id = 7

update Employees
set FirstName = 'Valarie', MiddleName = 'Balerine', LastName = NULL
where Id = 8

update Employees
set FirstName = 'James', MiddleName = '007', LastName = 'Bond'
where Id = 9

update Employees
set FirstName = NULL, MiddleName = NULL, LastName = 'Crowe'
where Id = 10

select * from Employees

---igast reast v�tab esimesena t�idetud lahtri ja kuvab ainult seda
select Id, coalesce(FirstName, MiddleName, LastName) as Name
from Employees

--loome kaks tabelit
create table IndianCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

create table UKCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

--sisestame tabelisse andmeid
insert into IndianCustomers (Name, Email)
values ('Raj', 'R@R.com'),
('Sam', 'S@S.com')

insert into UKCustomers (Name, Email)
values ('Ben', 'B@B.com'),
('Sam', 'S@S.com')

select * from IndianCustomers
select * from UKCustomers

-- kasutame union all, n�itab k�iki ridu
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers

-- korduvate v��rtustega read pannakse �hte ja ei korrata
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers

--- kuidas tulemust sorteerida nime j�rgi ja kasutada union all-i
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers
order by Name

--- stored procedure
create procedure spGetEmployees
as begin
	select FirstName, Gender from Employees
end

-- n��d saab kasutada selle nimelist sp-d
spGetEmployees
exec spGetEmployees
execute spGetEmployees

select * from Employees

create proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

--see k�sklus n�uab, et antakse Gender parameeter
spGetEmployeesByGenderAndDepartment
-- �ige variant
spGetEmployeesByGenderAndDepartment 'Male', 1

--- niimoodi saab j'rjekorda muuta p�ringul, kui ise paned muutuja paika
spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male'

-- soov vaadata sp sisu
sp_helptext spGetEmployeesByGenderAndDepartment

--- 5tund 17.03.2025

--- kuidas muuta sp-d ja pane kr�pteeringu peale, et keegi teine peale teid ei saaks muuta
alter proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
with encryption --kr�pteerimine
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

sp_helptext spGetEmployeesByGenderAndDepartment

-- sp tegemine
create proc spGetEmployeeCountByGender
@Gender nvarchar(20),
@EmployeeCount int output
as begin
	select @EmployeeCount = count(Id) from Employees where Gender = @Gender
end

-- annab tulemuse, kus loendab �ra n�uetele vastavad read
-- prindib tulemuse konsooli
declare @TotalCount int
execute spGetEmployeeCountByGender 'Female', @TotalCount out
if(@TotalCount = 0)
	print 'TotalCount is null'
else
	print '@Total is not null'
print @TotalCount

-- n�itab �ra, et mitu rid vastab n�uetele
declare @TotalCount int
execute spGetEmployeeCountByGender @EmployeeCount = @TotalCount out, @Gender = 'Male'
print @TotalCount

-- sp sisu vaatamine
sp_help spGetEmployeeCountByGender
-- tabeli info
sp_help Employees
-- kui soovid sp tektsi n�ha
sp_helptext spGetEmployeeCountByGender

-- vaatame , millest see sp s�ltub
sp_depends spGetEmployeeCountByGender
-- vaatame tabelit
sp_depends Employees


--
create proc spGetnameById
@Id int,
@Name nvarchar(20) output
as begin
	select @Id = Id, @Name = FirstName from Employees
end

select * from Employees
declare @FirstName nvarchar(50)
execute spGetnameById 2, @FirstName output
print 'Name of the employee = ' + @FirstName

-- mis id all on keegi nime j'rgi
create proc spGetNameById1
@Id int,
@FirstName nvarchar(50) output
as begin
	select @FirstName = FirstName from Employees where Id = @Id
end

declare @FirstName nvarchar(50)
execute spGetNameById1 4, @FirstName output
print 'Name of the employee = ' + @FirstName

sp_help spGetNameById1

---
create proc spGetNameById2
@Id int
as begin
	return (select FirstName from Employees where Id = @Id)
end

-- tuleb veateade kuna kutsusime v�lja int-i, aga Tom on string
declare @FirstName nvarchar(50)
execute @FirstName = spGetNameById2 1
print 'Name of the employee = ' + @FirstName
--

--- sisseehitatud string funktsioonid
-- see konverteerib ASCII t�he v��rtuse numbriks
select ascii('a')
-- kuvab A-t�he
select char (66)

--prindime kogu t�hestiku v�lja
declare @Start int
set @Start = 97
while (@Start <= 122)
begin
	select char (@Start)
	set @Start = @Start + 1
end

-- eemaldame t�hjad kohad sulgudes
select ltrim('        Hello')

-- t�hikute eemaldamine veerust
select ltrim(FirstName) as FirstName, MiddleName, LastName from Employees

select * from Employees

--paremalt poolt t�hjad stringid l�ikab �ra
select rtrim('      Hello          ')

--keerab kooloni sees olevad andmed vastupidiseks
-- vastavalt upper ja lower-ga saan muuta m�rkide suurust
-- reverse funktsioon p��rab k�ik �mber
select REVERSE(UPPER(ltrim(FirstName))) as FirstName, MiddleName, lower(LastName),
rtrim(ltrim(FirstName)) + ' ' + MiddleName + ' ' + LastName as FullName
from Employees

--n�eb, mitu t�hte on s�nal ja loeb t�hikud sisse
select FirstName, len(FirstName) as [Total Characters] from Employees

--- n�eb, mitu t�hte on s�nal ja ei loe tyhikuid sisse
select FirstName, len(ltrim(FirstName)) as [Total Characters] from Employees

-- left, right ja substring
--- vasakult poolt neli esimest t�hte
select left('ABCDEF', 4)
-- paremalt poolt kolm t�hte
select right('ABCDEF', 3)

--kuvab @-t�hem�rgi asetust e mitmes on @ m�rk
select charindex('@', 'sara@aaa.com')

--- esimene nr peale komakohta n�itab, et mitmendast alustab ja siis mitu nr peale
-- seda kuvada
select SUBSTRING('pam@btbb.com', 5, 2)

--- @-m�rgist kuvab kolm t�hem�rki. Viimase numriga saab m��rata pikkust
select substring('pam@bb.com', charindex('@', 'pam@bb.com') + 1, 3)

--- peale @-m�rki reguleerin t�hem�rkide pikkuse n�itamist
select substring('pam@bb.com', charindex('@', 'pam@bb.com') + 1, 
len('pam@bb.com') - CHARINDEX('@', 'pam@bb.com'))

select * from Employees

-- vaja teha uus veerg nimega Email, nvarchar (20)
alter table Employees
add Email nvarchar(20)

update Employees set Email = 'Tom@aaa.com' where Id = 1
update Employees set Email = 'Pam@bbb.com' where Id = 2
update Employees set Email = 'John@aaa.com' where Id = 3
update Employees set Email = 'Sam@bbb.com' where Id = 4
update Employees set Email = 'Todd@bbb.com' where Id = 5
update Employees set Email = 'Ben@ccc.com' where Id = 6
update Employees set Email = 'Sara@ccc.com' where Id = 7
update Employees set Email = 'Valarie@aaa.com' where Id = 8
update Employees set Email = 'James@bbb.com' where Id = 9
update Employees set Email = 'Russel@bbb.com' where Id = 10

select * from Employees

--- lisame *-m�rgi alates teatud kohast
select FirstName, LastName,
	substring(Email, 1, 2) + REPLICATE('*', 5) + --peale teist t�hem�rki paneb viis t�rni
	SUBSTRING(Email, CHARINDEX('@', Email), len(Email) - charindex('@', Email)+1) as Email
from Employees

--- kolm korda n�itab stringis olevat v��rtust
select replicate(FirstName, 3)
from Employees

select replicate('asd', 3)

-- kuidas sisestada tyhikut kahe nime vahele
select space(5)

--Employees tabelist teed p�ringu kahe nime osas (FirstName ja LastName)
--kahe nime vahel on 25 t�hikut
select FirstName + space(25) + LastName as FullName
from Employees

-- rida 782
---- 6 tund

-- PATINDEX
-- sama, mis charIndex, aga dünaamilisem ja saab kasutada wildcardi
select Email, PATINDEX('%@aaa.com', Email) as FirstOccurence
from Employees
where PATINDEX('%@aaa.com', Email) > 0 -- leian kõik selle domeeni kesindajad ja
-- alates mitmendast märgist algab @

-- kõik .com-d asendatakse .net-ga
select Email, REPLACE(Email, '.com', '.net') as ConvertedEmail
from Employees

-- soovin asendada peale esimest märki kolm tähte viie tärniga
select FirstName, LastName, Email,
	stuff(Email, 2, 3, '*****') as StuffedEmail
from Employees

--- ajatüübid
create table DateTime
(
c_time time, 
c_date date,
c_smalldatetime smalldatetime,
c_datetime datetime,
c_datetime2 datetime2,
c_datetimeoffset datetimeoffset
)

select * from DateTime
select GETDATE()

--   _________
--   |		  |
--	 |		  |\
-- (*_*)      | \
-- /| |\      |  \
--	| |       |   \
--			  |	   \
-----------------------

insert into DateTime
values (getdate(), getdate(), getdate(), getdate(), getdate(), getdate())

select * from DateTime

--			 ___________
--			/ ___       \
-- * * * *  | ___CANNNON \
--		    \__________   \
--				   |       \   
--				   / /   	\
--				  /__________\

update DateTime set c_datetimeoffset = '2025-04-08 10:20:00.1933333 + 10:00'
where c_datetimeoffset = '2025-03-24 09:02:24.77333 + 00:00'

--⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠤⠤⠒⠖⠒⠦⠤⠤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⠀⠀⠀⡠⠒⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠲⢄⡀⠀⠀⠀⠀
--⠀⠀⠀⠀⡠⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⢄⠀⠀⠀
--⠀⠀⢀⡞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢣⡀⠀
--⠀⠀⡾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⢳⠀
--⠀⢸⠃⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⢀⡴⠾⠆⠀⠀⠀⠈⠈⠁⠀⠀⠀⠈⡆
--⠀⡾⠀⠀⠀⠀⠀⠐⢛⡿⠿⠟⠻⠿⡿⠛⠀⠀⠀⠛⣿⠿⠛⠛⠻⠂⠀⠀⢸
--⢰⡇⠀⠀⠀⠀⠀⣀⣾⣗⠦⠀⠀⠈⡿⠀⠀⣼⠀⠀⣿⡀⠀⠐⢄⠆⠀⠀⠸
--⢸⠀⠀⠀⠀⠀⠀⠀⢹⣿⣷⣶⣴⢞⠕⠀⠀⣹⡆⠀⠙⣿⣷⣾⡟⠀⠀⠀⡀
--⢸⡀⠀⣀⠤⠀⠄⠀⠀⠙⠟⠋⢁⣤⣼⣅⣶⣾⡿⣶⡶⢏⠉⠉⠀⠐⠢⠀⡇
--⠈⢧⠰⠁⠀⣀⢠⡔⠒⢾⠿⢿⣿⣿⡿⠭⠭⡭⠦⠦⠭⠿⢿⡶⠆⣠⣀⢠⠃
--⠀⠈⢆⠀⠀⢏⡉⠀⠀⠀⠀⠀⠈⠉⠛⢛⡿⠯⠭⠙⠛⠉⠁⠀⠀⡤⠜⡜⠀
--⠀⠀⠀⠳⣄⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠁⠂⠓⡄⠀⠀⠀⠀⠀⠀⢀⠎⠀⠀
--⠀⠀⠀⠀⠈⠳⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠃⠀⠀⠀⠀⢀⡤⠁⠀⠀⠀
--⠀⠀⠀⠀⠀⠀⠀⠈⠑⠢⠤⣀⡀⠀⠀⠀⠀⠀⠀⠀⣀⡤⠒⠉⠀⠀⠀⠀⠀
--⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠙⠒⠒⠒⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀

⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠤⠤⠒⠖⠒⠦⠤⠤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⡠⠒⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠲⢄⡀⠀⠀⠀⠀
⠀⠀⠀⠀⡠⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⢄⠀⠀⠀
⠀⠀⢀⡞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢣⡀⠀
⠀⠀⡾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⢳⠀
⠀⢸⠃⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⢀⡴⠾⠆⠀⠀⠀⠈⠈⠁⠀⠀⠀⠈⡆
⠀⡾⠀⠀⠀⠀⠀⠐⢛⡿⠿⠟⠻⠿⡿⠛⠀⠀⠀⠛⣿⠿⠛⠛⠻⠂⠀⠀⢸
⢰⡇⠀⠀⠀⠀⠀⣀⣾⣗⠦⠀⠀⠈⡿⠀⠀⣼⠀⠀⣿⡀⠀⠐⢄⠆⠀⠀⠸
⢸⠀⠀⠀⠀⠀⠀⠀⢹⣿⣷⣶⣴⢞⠕⠀⠀⣹⡆⠀⠙⣿⣷⣾⡟⠀⠀⠀⡀
⢸⡀⠀⣀⠤⠀⠄⠀⠀⠙⠟⠋⢁⣤⣼⣅⣶⣾⡿⣶⡶⢏⠉⠉⠀⠐⠢⠀⡇
⠈⢧⠰⠁⠀⣀⢠⡔⠒⢾⠿⢿⣿⣿⡿⠭⠭⡭⠦⠦⠭⠿⢿⡶⠆⣠⣀⢠⠃
⠀⠈⢆⠀⠀⢏⡉⠀⠀⠀⠀⠀⠈⠉⠛⢛⡿⠯⠭⠙⠛⠉⠁⠀⠀⡤⠜⡜⠀
⠀⠀⠀⠳⣄⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠁⠂⠓⡄⠀⠀⠀⠀⠀⠀⢀⠎⠀⠀
⠀⠀⠀⠀⠈⠳⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠃⠀⠀⠀⠀⢀⡤⠁⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠈⠑⠢⠤⣀⡀⠀⠀⠀⠀⠀⠀⠀⣀⡤⠒⠉⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠙⠒⠒⠒⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀

select CURRENT_TIMESTAMP, 'CURRENT_TIMESTAMP' -- aja päring
select SYSDATETIME() -- veel täpsem ajapäring
select SYSDATETIMEOFFSET() -- täpne aeg koos ajalise nihkega UTC suhtes
select GETUTCDATE() -- UTC AEG

select isdate('asd') -- tagastab 0 kuna string ei ole date ega aeg
select isdate(CURRENT_TIMESTAMP) -- tagastab 1 kuna on kp
select isdate('2025-03-24 09:19:18.670000')-- tagastab kuna max kolm komakohta võib olla
select isdate('2025-03-24 09:19:18.670') -- tagastab ühe
select day(getdate()) -- annab tänase päeva nr
select day('01/31/2017') -- annab stringis oleva päeva nr
select month(getdate()) -- annab tänase kuu nr
select month('01/31/2017') -- annab stringis oleva kuu nr
select year(getdate()) -- annab tänase aasta nr
select year('01/31/2017') -- annab stringis oleva aasta nr


⠀  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⢤⠤⢄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣻⠟⠛⠛⠳⣯⡓⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣞⡿⠋⠀⠀⠀⠀⠀⠻⣮⢳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣀⢴⣿⣭⣭⣟⠶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⡿⠁⠀⠀⠀⠀⡀⠀⠀⠘⢷⡹⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣰⣻⠟⠁⠀⠀⠈⠻⢦⡑⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣞⡾⠁⠀⠀⠀⠀⢠⡿⠀⠠⠀⠈⢷⡹⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⣸⣳⠏⠀⠀⠀⠀⠀⠀⠈⠹⣦⡓⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣞⣾⠁⠀⠀⠀⠀⢀⣿⠃⢀⠁⠠⡀⠈⣷⣹⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢠⣯⡟⠀⠀⠀⣤⠀⠀⠀⠀⠀⠈⠻⣮⡣⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡜⣼⠃⠀⠀⠀⠀⠀⣼⡟⢀⠠⠐⠀⢡⠀⠘⣷⢳⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⣼⣿⠃⠀⣴⠀⠹⣷⡀⠀⠀⠀⠀⠀⠈⢷⣜⢦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⠏⠀⠀⠀⠀⠀⢰⣿⠀⠄⠂⠐⡈⠀⢃⠀⢹⣎⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⡟⣿⠀⠀⠏⠀⡀⠻⣷⡀⠀⠀⠀⠀⠀⠈⢻⣌⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣏⡿⠀⠀⠀⠀⠀⠀⣸⡟⠀⠰⠀⠂⠡⢀⠸⡀⠈⣿⢿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢸⣟⡏⠀⣠⠂⠐⠀⡀⠙⣿⡄⠀⠀⠀⠀⠀⠀⠙⣧⡳⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⠃⠀⠀⠀⠀⠀⠀⣿⠇⡂⠁⠄⡁⠐⠠⠀⢡⠀⠸⣏⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢸⣿⡇⠀⣟⠀⠠⠁⠀⠄⡈⢿⣆⠐⠀⠀⠀⠀⠀⠈⢿⡜⢦⣀⣤⢴⣖⣶⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⣿⠀⡇⠈⡐⠀⠌⠐⠠⠘⡆⠀⢿⣼⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢸⣿⡇⠀⡯⠀⢂⠠⠁⠠⠀⠌⢿⣆⠀⠀⠀⠀⠀⠀⣀⣿⣾⡿⠛⠋⠉⠉⢹⡄⠀⢠⡿⠀⠀⠀⠀⠀⠀⠀⠀⣿⡄⣠⣐⡀⠁⠌⠠⢁⠀⢣⠀⠸⣏⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢸⣿⡇⠀⢃⠐⠀⠄⠠⠁⡐⠈⡈⣿⡆⠀⠀⢀⣴⠿⠛⠉⢸⡇⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠿⢟⠛⢻⡧⠐⠈⡐⠠⢀⠂⠆⠀⣿⣽⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢸⣿⡇⠀⠀⠂⢈⠀⢂⠐⠀⢂⠐⢸⣧⠀⠀⠀⠀⠀⠐⠀⢸⡁⠀⠀⠀⠀⠈⡗⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣧⣴⣤⡀⠂⢂⠀⡃⠀⢸⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠘⣿⡇⠀⠀⠡⠀⠂⠄⠂⢡⣾⠿⠿⠿⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⣟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⠋⠉⠉⣿⡇⠀⠡⠀⢸⠀⠈⣧⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⡿⣿⠀⠠⠁⠐⠠⠐⠠⡘⢿⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣇⠀⠀⠀⠀⠀⢻⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡟⠀⢈⠐⠠⠈⠀⠀⣿⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⣿⣿⠀⠀⡃⢀⠂⠀⣿⡿⠛⠿⠶⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡀⠀⠀⠀⠀⠘⣧⠀⠀⠀⠀⠀⠀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠈⢷⡀⢀⠈⠄⠐⡀⠀⢼⡾⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢿⣿⡇⠀⡇⠀⡀⠂⢹⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⡇⠀⠀⠀⠀⠀⠈⠳⣄⡀⠀⢀⣾⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠈⢿⡄⠢⠐⠠⠀⠀⢸⡇⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢸⣿⣧⠀⠰⠀⠠⠐⠀⠹⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠟⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠶⣾⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠘⢿⣄⠂⠐⠀⠀⣼⢧⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠈⣿⣿⠀⠘⠄⠐⠀⠌⢠⡿⠀⠀⠀⠀⣀⣤⣦⣶⣤⣴⠏⠀⣀⣤⣴⣶⣶⣶⣦⣤⡀⠀⠀⠙⢿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠜⣿⡀⠈⠀⢠⣿⣿⠁⢀⡀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠸⣿⣇⠀⠻⡀⠈⠀⣿⠃⠀⠀⢠⣾⣿⣿⡿⢿⣿⠏⢠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠉⢿⡛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠐⠘⣿⣀⣴⣿⣿⣿⣿⣿⣭⣟⢦⣀⣀⣀⠀⠀
⠀⠀⠀⢻⣻⣆⠀⠱⣀⢩⣿⠀⠀⠀⠠⠟⠋⠁⠀⣰⠃⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠈⢷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿⡟⠙⣿⣿⠁⠀⢹⣿⡿⠿⣯⡻⡆
⠀⠀⠀⠈⢻⣻⣦⠀⠉⢸⡗⠀⠀⠀⠀⠀⠀⠀⢠⡟⠀⠀⠀⠈⠛⠿⣿⣿⣿⠿⠛⠉⠀⠀⠀⠀⣀⠀⠀⠈⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⡶⠀⣿⣿⡀⠐⠈⢁⠠⠀⣼⣇⡇
⠀⠀⠀⠀⠀⠙⢽⡷⣦⣽⡇⠀⠀⠀⠀⠀⠀⠀⢰⡇⢀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠸⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⢿⣝⣿⡼⣿⣧⡐⠈⣠⣤⢾⣫⠟⠁
⠀⠀⠀⠀⠀⠀⠀⠙⢻⣿⠇⠀⠀⠀⠀⠀⠀⠀⢸⠇⠘⣧⠀⠀⠀⠀⠀⢀⣾⣧⣄⣀⢀⣀⣠⣾⠋⠀⠀⠀⠀⠙⢦⣀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣻⡇⠀⠘⢿⣿⣛⡿⠷⠋⠁⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⡾⣿⠀⠀⠀⠀⠀⠀⠀⢠⡟⠀⠀⠈⠳⣶⣤⡴⣾⢿⡹⢮⡝⣯⢻⣽⣿⣿⣄⠀⠀⠀⠀⠀⠀⠉⠓⠦⣤⣄⣀⣀⣠⣤⠿⢻⡞⣷⠀⠀⠀⠉⠁⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢀⣾⣷⣿⠀⠀⠀⠀⠀⣀⡴⠋⠀⠀⠀⠀⠀⠹⣷⡹⣎⢷⡹⢧⣻⣼⠿⣿⣄⠉⠙⢷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢻⣽⣧⣤⣀⣀⣠⡴⠞⠋⠀⠀⠀⠀⠀⠀⠀⠀⠘⠻⣯⣞⣭⣻⣟⣷⡀⢀⠛⢿⡄⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⣶⣶⣶⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠈⢿⣿⡿⠛⠛⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠛⠛⠛⠻⣧⡈⠐⢈⣡⣾⠏⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣯⠿⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠘⢿⣓⣶⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠻⠛⠋⠁⠀⠀⠀⠀⠀⠀⠶⠛⠉⢸⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⣿⣺⣿⣿⣻⢦⣤⣤⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⢿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⢿⣿⣧⠀⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡿⣾⠹⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⠛⣯⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢈⣷⡿⠀⠘⠻⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠟⠁⠀⢿⣸⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⡇⠀⠀⠖⠀⠙⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⢶⠀⠀⢸⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠙⠒⠒⠒⠖⠶⠦⠤⠤⢤⡤⣤⠤⣤⢤⡤⣤⢤⡤⠤⠤⠤⠴⠶⠒⠒⠒⠒⠊⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀

select datename(day, '2025-03-24 09:19:01.149') -- annab stringis oleva päeva nr
select datename(weekday,'2025-03-24 09:19:01.149') -- annab stringis oleav päeva sõnana
select datename(month,'2025-03-24 09:19:01.149') -- annab stringis oleva kuu sõnana
select datename(dayofYEAR,'2025-03-24 09:19:01.149') -- annab stringis oleva kuu sõnana
-- bobr



⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⠀⠀⠀⠀⣠⣾⠙⠲⡄⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣀⣀⡀⠀⠀⠀⠀⡁⠙⠩⢒⡒⡚⠁⠀⠀⠀⠈⠶⢤⡴⠒⠀⠐
⠀⠀⠀⢀⣴⠊⠀⡀⠌⠁⠒⠒⠢⠵⣄⠀⠀⣼⠀⠀⢀⠀⢀⡦⡘⠁⠀⣀⣠⠜
⠀⢰⠋⠀⡀⠀⠀⠄⠀⠀⠀⠀⠀⠀⡀⠈⠁⠈⡇⠀⠀⢀⠉⢠⠉⠁⠉⠁⠀⠀
⠀⡾⠀⡰⠀⠀⠀⠀⠀⠀⠀⠀⠀⡐⠁⠀⠀⡘⠀⠀⠀⠀⢀⡜⠀⠀⠀⠀⠀⠀
⠘⡇⠀⠃⠀⠀⠀⠀⠀⠀⠀⠀⡜⠀⠀⠀⠈⢿⣅⣆⢀⡠⢪⡇⠀⠀⠀⠀⠀⠀
⣇⡇⠀⡄⠀⠀⠀⠀⠀⠀⠀⢰⠀⠀⡠⠀⠀⠀⠑⠚⠃⢡⠛⠀⠀⠀⠀⠀⠀⠀
⡇⡇⠀⢳⠀⠀⠀⠀⠀⠀⠀⡆⠀⠐⠀⠀⠀⠀⠀⢀⠔⠁⠀⠆⠀⠀⠀⠀⠀⠀
⠸⢣⠀⠈⢧⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠊⠀⠀⡸⠀⠀⠀⠀⠀⠀⠀
⠀⢻⠀⠀⣎⠓⠤⣀⣀⡀⠀⢸⢄⠀⠀⢀⠀⠀⠀⠀⠀⢰⠁⠀⠀⠀⠀⠀⠀⠀
⠀⠘⠀⢸⢸⠀⢸⠀⠀⠀⠀⠙⡄⠀⠀⣇⡀⢀⠔⡉⠀⡆⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢠⠀⡌⡄⢀⠃⠀⠀⠀⠀⠀⢰⠀⠀⡇⠈⠁⢠⡃⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢸⠀⡇⠃⠈⠀⠀⠀⠀⠀⠀⠀⠀⢰⠀⠀⠀⠈⡀⢠⠃⠀⠀⠀⠀⠀⠀⠀⠀
⠀⡸⠀⢹⠀⢴⠀⠀⠀⠀⠀⠀⠐⡀⢸⠀⠀⠀⠀⠃⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢯⣀⡽⠒⠒⠀⠀⠀⠀⠀⠀⠀⠇⢸⠀⠀⠀⠐⡀⠸⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡃⠀⡆⠀⠀⠀⣧⠀⢡⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣀⡀⠽⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀


create table EmployeesWithDates
(
Id nvarchar(2),
Name nvarchar(20),
DateOfBirth datetime
)

insert into EmployeesWithDates
values 
(01, 'Sam', '1980-12-30 00:00:00.00'),
(02, 'Pam', '1982-09-01 12:02:36.260'),
(03, 'Pam', '1985-08-22 12:02:30.370'),
(04, 'Sara', '1979-11-29 12:59:30.670')

select * from EmployeesWithDates


⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⠀⠀⠀⠀⣠⣾⠙⠲⡄⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣀⣀⡀⠀⠀⠀⠀⡁⠙⠩⢒⡒⡚⠁⠀⠀⠀⠈⠶⢤⡴⠒⠀⠐
⠀⠀⠀⢀⣴⠊⠀⡀⠌⠁⠒⠒⠢⠵⣄⠀⠀⣼⠀⠀⢀⠀⢀⡦⡘⠁⠀⣀⣠⠜
⠀⢰⠋⠀⡀⠀⠀⠄⠀⠀⠀⠀⠀⠀⡀⠈⠁⠈⡇⠀⠀⢀⠉⢠⠉⠁⠉⠁⠀⠀
⠀⡾⠀⡰⠀⠀⠀⠀⠀⠀⠀⠀⠀⡐⠁⠀⠀⡘⠀⠀⠀⠀⢀⡜⠀⠀⠀⠀⠀⠀
⠘⡇⠀⠃⠀⠀⠀⠀⠀⠀⠀⠀⡜⠀⠀⠀⠈⢿⣅⣆⢀⡠⢪⡇⠀⠀⠀⠀⠀⠀
⣇⡇⠀⡄⠀⠀⠀⠀⠀⠀⠀⢰⠀⠀⡠⠀⠀⠀⠑⠚⠃⢡⠛⠀⠀⠀⠀⠀⠀⠀
⡇⡇⠀⢳⠀⠀⠀⠀⠀⠀⠀⡆⠀⠐⠀⠀⠀⠀⠀⢀⠔⠁⠀⠆⠀⠀⠀⠀⠀⠀
⠸⢣⠀⠈⢧⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠊⠀⠀⡸⠀⠀⠀⠀⠀⠀⠀
⠀⢻⠀⠀⣎⠓⠤⣀⣀⡀⠀⢸⢄⠀⠀⢀⠀⠀⠀⠀⠀⢰⠁⠀⠀⠀⠀⠀⠀⠀
⠀⠘⠀⢸⢸⠀⢸⠀⠀⠀⠀⠙⡄⠀⠀⣇⡀⢀⠔⡉⠀⡆⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢠⠀⡌⡄⢀⠃⠀⠀⠀⠀⠀⢰⠀⠀⡇⠈⠁⢠⡃⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢸⠀⡇⠃⠈⠀⠀⠀⠀⠀⠀⠀⠀⢰⠀⠀⠀⠈⡀⢠⠃⠀⠀⠀⠀⠀⠀⠀⠀
⠀⡸⠀⢹⠀⢴⠀⠀⠀⠀⠀⠀⠐⡀⢸⠀⠀⠀⠀⠃⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢯⣀⡽⠒⠒⠀⠀⠀⠀⠀⠀⠀⠇⢸⠀⠀⠀⠐⡀⠸⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡃⠀⡆⠀⠀⠀⣧⠀⢡⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣀⡀⠽⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀

-- kuias võtta ühest veerust andmeid ja selle abil luua uued veerud
-- vaatab DoB veerust päeva ja kuvab päeva nimetuse sõnana.
select Name, DateOfBirth, DATENAME(weekday, DateOfBirth) as [Day],
-- vaatab DoB veerust kp-d ja kuvab kuu nr
	Month(DateOfBirth) as MonthNumber,
-- vaatab DoB veerust kuud ja kuvab sõnana
	DateName(MONTH, DateOfBirth) as [MonthName],
-- vaatab DoB veerust aasta
	YEAR(DateOfBirth) as YearNumber
from EmployeesWithDates



⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠤⠤⠒⠖⠒⠦⠤⠤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⡠⠒⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠲⢄⡀⠀⠀⠀⠀
⠀⠀⠀⠀⡠⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⢄⠀⠀⠀
⠀⠀⢀⡞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢣⡀⠀
⠀⠀⡾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⢳⠀
⠀⢸⠃⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⢀⡴⠾⠆⠀⠀⠀⠈⠈⠁⠀⠀⠀⠈⡆
⠀⡾⠀⠀⠀⠀⠀⠐⢛⡿⠿⠟⠻⠿⡿⠛⠀⠀⠀⠛⣿⠿⠛⠛⠻⠂⠀⠀⢸
⢰⡇⠀⠀⠀⠀⠀⣀⣾⣗⠦⠀⠀⠈⡿⠀⠀⣼⠀⠀⣿⡀⠀⠐⢄⠆⠀⠀⠸
⢸⠀⠀⠀⠀⠀⠀⠀⢹⣿⣷⣶⣴⢞⠕⠀⠀⣹⡆⠀⠙⣿⣷⣾⡟⠀⠀⠀⡀
⢸⡀⠀⣀⠤⠀⠄⠀⠀⠙⠟⠋⢁⣤⣼⣅⣶⣾⡿⣶⡶⢏⠉⠉⠀⠐⠢⠀⡇
⠈⢧⠰⠁⠀⣀⢠⡔⠒⢾⠿⢿⣿⣿⡿⠭⠭⡭⠦⠦⠭⠿⢿⡶⠆⣠⣀⢠⠃
⠀⠈⢆⠀⠀⢏⡉⠀⠀⠀⠀⠀⠈⠉⠛⢛⡿⠯⠭⠙⠛⠉⠁⠀⠀⡤⠜⡜⠀
⠀⠀⠀⠳⣄⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠁⠂⠓⡄⠀⠀⠀⠀⠀⠀⢀⠎⠀⠀
⠀⠀⠀⠀⠈⠳⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠃⠀⠀⠀⠀⢀⡤⠁⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠈⠑⠢⠤⣀⡀⠀⠀⠀⠀⠀⠀⠀⣀⡤⠒⠉⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠙⠒⠒⠒⠋⠉⠀⠀⠀⠀



select DATEPART (weekday, '2025-12-30 12:22:56.401') -- kuvab 1 kuna USA nädal algab pühapäevaga.
select DATEPART (MONTH, '2025-03-24 12:22:56.401') -- kuvab kuu nr.
select DATEADD(DAY, 20, '2025-03-24 12:22:56.401') -- liidab stringis olevale kp 20 päeva juurde.
select DATEADD(DAY, -20, '2025-03-24 12:22:56.401') -- lahutab 20 päeva maha
select datediff(MONTH, '11/30/2024', '03/24/2025') -- kuvab kahe stringi kuudevahelist aega nr-na
select datediff(year, '11/30/2022', '03/24/2025') -- näitab aastatevahelist aega nr-na





⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣤⣤⣤⣀⣀⣀⣀⣀⣀⣀⣤⡤⠶⠶⠶⢶⣤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣴⠶⠾⠛⠛⠋⠉⠉⠉⠉⠉⢉⡉⠉⢙⣿⡿⠛⠉⠀⣀⡀⠀⠀⠀⠀⠉⠛⠷⣦⡀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⠶⠛⠋⠉⠀⠀⢀⣠⣤⣄⣀⣀⣀⣤⣄⠈⠛⢀⡾⠋⠀⠀⠀⣾⡿⠃⠀⠀⠀⠀⠀⠀⠀⠘⢿⡄⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⠟⠋⠀⠀⠀⠀⠀⠀⢴⠟⣩⡿⢛⣉⠛⣿⣿⣿⣷⣶⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⡄⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡾⠋⠁⠀⠀⠀⠀⠀⠀⢀⣠⣤⣄⣿⡇⠺⣿⡇⣸⡟⠋⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣷⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⠏⠀⠀⠀⠀⠀⠀⣠⣾⣿⢿⣟⠛⠻⣿⣛⣳⣶⣾⣿⣦⣾⣃⠄⠀⠀⣀⣠⣤⣴⣶⡶⠶⠶⠞⠛⠛⠻⣿⣶⣄⠀⢸⣿⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡞⠁⠀⠀⠀⠀⠀⠀⠐⠛⠋⠀⠀⢿⣷⣦⣤⣭⣭⣷⣦⣴⣟⣉⣥⣶⠾⠟⠛⠋⠉⠁⠀⠀⠀⠀⢀⣴⣶⣿⡿⠟⠻⣷⣾⡟⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⣴⠏⠀⠀⠀⠀⠀⣠⡶⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⢉⣿⣿⠿⠟⢛⣩⣵⣶⠖⠀⢰⣞⣋⣥⣴⣶⣶⣾⣿⣿⡿⠋⠀⠀⠀⢹⡟⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢀⣾⠃⠀⠀⠀⠀⠀⣾⣿⣥⣤⡄⠀⠠⠖⢶⣶⡶⠆⠀⠀⠉⠉⠓⠛⠉⠉⢙⣿⣿⣿⡿⠛⢩⣿⣿⣿⣿⣿⣿⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣰⣿⠃⠀⠀⠀⠀⠀⠀⠘⣿⣿⣏⣀⣀⣠⣤⣦⣤⠀⠀⠀⠀⠀⠀⣀⠀⠀⠀⠀⣻⣿⠃⠀⣠⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣰⣿⣿⣄⠀⠀⠀⠀⠀⠀⠐⠟⠛⢻⣿⠿⣿⣿⣿⠁⠀⠀⢠⣶⣧⣴⣿⣷⣴⣾⣿⡿⠃⠀⣰⣿⣿⣿⡿⢿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢰⣿⠿⠛⠉⠀⠀⠀⠰⡆⢀⣶⠀⠀⠀⠀⠸⠟⠋⠁⠀⠀⢠⣾⡿⠟⠉⠉⠉⡿⠟⠋⠀⠀⣰⣿⣿⣿⡏⠀⠀⢸⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢀⡿⠁⠀⠀⠀⠀⠀⠀⠀⢠⠟⠁⠀⠀⠀⠀⠀⠀⣾⣿⠟⠁⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⡿⡿⠀⠀⠀⢺⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⣸⣇⣴⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠐⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠚⠉⠙⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢀⣿⣿⠃⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢸⣿⡏⠀⣴⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡀⠀⠀⠀⡀⠀⠀⠀⣼⡇⠀⠀⠀⠀⠀⣸⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠈⣿⣧⣾⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢴⣿⡇⠀⠀⢸⣷⠀⠀⣼⣿⠇⠀⠀⠀⠀⠀⢸⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢰⡟⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠁⠀⠀⠘⠛⠀⢰⣿⠏⠀⠀⠀⠀⠀⠀⠀⢿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⡿⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠘⣧⠀⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠘⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢸⡇⣰⡿⠀⠀⠀⠀⠀⠀⠀⢀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣰⣿⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢸⣷⣿⡇⠀⠀⠀⠀⠀⠀⠀⣸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢸⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⣿⡧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢷⡄⠀⠀⠀⠀⠀⠀⠀⠀
⠈⠁⢹⣧⠀⡆⠀⠀⠀⠀⢰⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡄⠀⠀⠀⠀⠀⠙⣦⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢸⣿⠀⣿⠀⠀⠀⠀⣾⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⣠⣤⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣿⡄⠀⠀⠀⠀⠀⢸⣷⡄⠀⠀⠀⠀⠀
⠀⠀⠀⣿⣀⣿⣧⠀⠀⢀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠃⠀⠀⢸⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣄⠀⠘⣿⣿⣦⣴⣄⠀⠀⠀⠻⣧⠀⠀⠀⠀⠀
⠀⠀⠀⠸⣿⣿⣿⣆⣾⠀⠁⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡿⠀⢀⣴⣿⣿⣿⣿⣿⣿⣾⡆⠀⠀⠀⠀⠀⠀⠀⢹⡄⠀⣿⣿⣿⣿⣿⣄⣤⡄⠀⠈⣷⡀⠀⠀⠀
⠀⠀⠀⠀⠹⣿⢿⣿⡇⠀⣀⣼⣿⠀⠀⠀⠀⠀⢀⣀⡀⠀⣾⣇⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⢸⣇⢠⡄⠀⠀⢸⣿⣤⣿⣿⣿⣿⣿⣿⣿⣿⣄⣈⣿⣇⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢻⣿⣾⣿⣿⣿⢀⣷⣴⣦⣴⣿⣿⣇⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡄⠘⣿⣌⣿⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡀⠀
⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠁⢻⣿⣿⣿⣿⣿⣿⣄⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄
⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⠁⠀⠀⠈⠛⠁⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇
⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⠉⠙⠿⢿⣿⣿⡿⣿⠿⠛⠛⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⢹⡿⠛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠛⠛⠁
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠸⣿⡿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⢻⣿⣿⠿⠿⠿⠃⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠈⢿⡟⠙⠿⣿⣿⡟⠻⠃⠀⠙⠟⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠘⠻⠧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀

⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢾⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠙⢿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣦⡀⠙⢿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣶⣦⣀⠙⢿⣦⡀⠙⢿⣿⣿⣿⣿⣿⣷⡄⠀
⠀⠀⠀⠀⠀⠀⠀⣠⣴⣾⣿⣿⣿⣿⣿⣿⣷⣄⠙⢿⣦⡀⠙⢿⣿⣿⡿⠋⠀⠀
⠀⠀⠀⠀⣠⣴⣿⣿⣿⠿⢻⣿⣿⣿⣿⣿⣿⣿⣧⡀⠙⠛⠂⠀⠙⠋⠀⠀⠀⠀
⠀⠀⠀⢸⣿⣿⣿⡿⠁⠀⣠⣿⣿⠋⠙⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢠⣇⠘⣿⣿⣿⣿⣷⣾⣏⣉⣿⣀⣀⢸⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢸⣿⣧⡈⢻⣿⣿⡿⠋⠉⠛⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢸⣿⣿⣷⣄⠙⢿⣿⣷⣦⣤⣽⣿⣿⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢻⣿⣿⣿⣷⣄⠙⠻⣿⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠙⠿⣿⣿⣿⣿⣦⣄⡉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀


⣿⣿⡿⠛⣿⣿⣿⣿⣿⣿⡟⠻⣿⣿⡛⠛⢻⣿⣿⣿⣿⣿⣿⡿⠿⣿⣿⣿⣿⣿
⣿⡿⠁⣾⣿⠉⠉⣿⣿⣿⣿⡆⠹⣿⡇⠀⢸⣿⣿⣿⣿⡿⠏⠀⠀⢸⣿⣿⣿⣿
⣿⠁⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⢹⣷⠀⢸⣿⣿⣿⣿⣧⣤⣴⣶⣿⣿⣿⣿⣿
⣿⣾⣿⣿⣿⣿⣿⣿⠟⠻⢿⣿⣷⠀⢿⠀⠀⠟⢿⣿⣿⢿⣿⣿⣿⡿⠛⢻⣿⣿
⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⢈⣿⣿⣇⠘⡆⠀⠀⣠⣿⡟⢸⣿⣿⣿⣷⣤⣾⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⡀⠁⠀⠘⣿⡿⠁⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⠁⠈⣿⣿⣿⣿⣿⣿⣿⡿⢇⠀⠀⠀⠙⠁⠀⣿⣿⣿⡿⠋⣁⣀⡉⣿
⣿⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⣿⣿⠟⢀⣾⣿⣿⣿⣿
⣿⣦⡈⢻⣿⣿⣿⣿⡌⢿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⢻⠏⢠⣿⣿⣿⣿⣿⣿
⣿⣿⣷⡄⠹⣿⣿⣿⣷⠀⠉⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠘⢀⣾⣿⠟⣻⣿⣿⣿
⣿⣿⣿⣿⣆⠘⣿⣿⣿⣇⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠘⠋⠁⢀⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣆⠈⠻⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⡄⠀⠀⠙⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⡿⢟⣿
⣿⣿⣿⣏⠙⠛⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠁⠀⠀⣼⣿
⣿⣿⣿⣿⣷⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣾⣿⣿⠀⠀⠀⠀

⠀⠀⠀
⠀⠀⣶⣴⣿⡗⢲⣶⣦⣄⠠⡀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣀⠀
⠀⠀⣿⠋⣿⣿⣿⣟⣙⣿⣿⣿⡟⢻⣷⣿⣷⢂⣶⣦⣤⣆⣂⣶⣤⣤⡔⠒⠒⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠁⠈⠁
⠀⢠⣽⣿⣿⣍⣹⣿⣿⣿⣁⣽⣿⣿⣯⣨⣿⣿⣿⣍⣹⣿⣿⣿⣉⣽⣧⣤⣤⣤⣤⣤⣤⣤⣇⣴⡀⣀⣠⡀⡀⠀⠀⠀⠀⠀⠀⠀⠀⡀⣀⣠⣤⣤⣤⣤
⢠⣾⣿⣉⣽⣿⣿⣯⣈⣿⣿⣿⣏⣹⣿⣿⣿⣁⣿⣿⣿⣯⣘⣿⣿⣿⡿⠷⠻⠞⠷⠯⠟⠯⠟⠾⠿⣿⡿⠿⠧⡀⠀⠀⠀⠀⠀⢠⠾⠽⠻⠽⠳⢿⡿⠯
⢸⣌⣿⣿⣿⣏⣹⣿⣿⣿⣡⣿⣿⣿⣯⣌⣿⣿⣿⣏⣹⣿⣿⣿⣡⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⠀⠀⠰⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠈⠅⠀
⣿⣿⣿⣦⣺⣿⣿⣗⣴⣿⡿⣿⣧⣼⣿⢿⣿⣤⣾⣿⣿⣗⣴⣿⡿⣿⣷⣶⢶⣶⡶⣶⣶⢶⣶⡶⣾⢾⣵⡶⣶⣶⡆⣀⣴⣶⣶⡶⣶⣶⢶⣶⣾⣃⠠⠀
⣷⣤⣾⡿⣿⣦⣼⣿⢿⣿⣤⣾⣿⣿⣷⣤⣿⡿⣿⣦⣼⣿⢿⣿⣤⣾⡟⠛⠛⠚⠛⠓⠛⠛⠚⠛⠛⠒⠛⠛⠓⠛⠛⠛⠛⠚⠓⠛⠛⡚⢛⡿⠛⠂⠀⠀
⣿⠿⣿⣴⣼⡿⣿⣧⣦⣿⡿⣿⣧⣼⣿⢿⣿⣤⣿⡿⣿⣧⣦⣿⡿⣿⡇⢀⠀⡀⢀⠀⡀⢀⠀⡀⢀⠀⡀⢀⠀⡀⢀⠀⡀⢀⠀⡀⢀⢳⡠⠇⠀⠀⠀⠀
⢹⣶⣿⣿⣿⣷⣾⣿⣿⣿⣶⣿⣿⣿⣿⣾⣿⣿⣿⣷⣾⣿⣿⣿⣶⣿⣿⡿⣿⢿⡿⣿⢿⡿⣿⢿⡿⣿⢿⡿⣿⢿⡿⣿⢿⡿⣿⢿⣟⡿⣧⠀⠀⠀⠀⠀
⠸⣏⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣰⠀⠀⠀⠀⠀
⠀⠈⢜⡒⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⠪⡝⠀⠀⠀⠀⠀
⠀⠀⠀⠋⢾⣿⣽⣯⡿⠽⠯⠿⠽⠯⠿⠽⠯⠿⠽⠯⠿⠽⠯⠿⠽⠯⠿⠽⠯⠿⠽⠯⠿⠽⠯⠿⠽⠯⠿⠽⠯⠿⠽⠯⠿⠽⢯⣿⡗⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠘⠛⠻⢿⡯⣔⢠⡀⣀⡀⢀⡠⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠉⠊⠓⢌⡳⡜⡣⡝⠮⢵⣶⡶⣶⢶⡶⣶⢶⡶⣶⢶⡶⣶⢶⡶⣶⢶⡶⣶⣶⣶⣶⣶⣶⣶⣶⣶⡶⣶⣂⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠀⠀⠘⢿⣿⢻⣿⣿⠋⠛⠙⠋⠛⠙⢋⣿⣿⣿⣿⣿⣫⣿⠿⡿⠟⢻⢿⡿⢿⣿⡛⠙⠃⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⡬⠛⠛⠲⢄⣀⣀⡠⠺⡜⠙⠋⠙⠛⠓⠻⠻⠆⠀⠀⠀⠈⠀⠀⢸⢢⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣿⣿⡔⠃⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⢿⣿⡇⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠁⠀⠀⠀⠀⠀⠀⠀


-- funktsiooni tegemine
create function fnComputeAge(@DOB datetime)
returns nvarchar(50)
as begin
	declare @tempdate datetime, @years int, @months int, @days int
	select @tempdate = @DOB
	select @years = datediff(year, @tempdate, getdate()) - case when (month(@DOB) > month(getdate())) or (MONTH(@DOB)
	= month(getdate()) and day(@DOB) > DAY(GETDATE())) then 1 else 0 end
	select @tempdate = dateadd(year,  @years, @tempdate)

	select @months = datediff(month, @tempdate, getdate()) - case when day(@DOB) > day(getdate()) then 1 else 0 end
	select @tempdate = dateadd(month, @months, @tempdate)

	select @days = datediff(day, @tempdate, getdate())

	declare @Age nvarchar(50)
		set @Age = cast(@years as nvarchar(4)) + ' Years '+ cast(@months as nvarchar(2)) + ' Months ' + cast(@days as nvarchar(2)) + ' Days'
	return @Age
end


⠀⠀⠀⢀⣾⣷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠘⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠹⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠈⢻⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣆⠀⠀⠀⠀⠀⢀⣸⣶⣶⠶⠿⠟⠛⠛⠛⢿⣿⣇⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣿⣿⣆⣀⣤⡶⠿⠛⠉⠁⢹⣷⣤⠀⠀⠀⠀⠟⢱⡿⠛⢷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣹⣿⣿⡟⠁⠀⠀⠀⠀⠀⠘⠁⠀⠀⠀⠀⣀⣀⣀⣀⣠⣼⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⠟⠙⢿⣿⣄⠀⠀⠀⠀⠀⣦⠶⠞⠛⠛⠛⠉⠉⢉⣿⠏⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡿⠁⠀⠀⠈⠻⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⣴⡟⠀⠀⠀⠀⠀⠀⢿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢀⣼⠏⠀⠀⠀⠀⠀⠀⢠⣿⠻⣿⣷⠄⠀⠀⠀⠀⠀⠀⠀⢰⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢀⣾⠋⠀⠀⠀⠀⠀⠀⢠⣿⠃⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⣾⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⣾⠃⠀⠀⠀⠀⠀⠀⢠⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣼⠇⠀⠀⠀⠀⠀⠀⣠⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢨⡗⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣤⡴⠴⠶⠒⠒⠒⠶⠶⠶⠤⣤⣄⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢰⡟⠀⠀⠀⠀⠀⢀⣼⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡶⠛⠉⣹⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠳⢦⣄⡀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣿⠁⠀⠀⠀⠀⣠⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠿⣤⣴⣤⣉⣀⣀⣀⣀⡀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⢷⣄⠀⠀⠀⠀
⠀⠀⢰⡟⠀⠀⠀⢀⣴⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡗⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⣹⡟⠉⠉⠉⠉⠉⠙⠛⠛⠃⠀⠀⠀⠀⠀⠀⠀ ⠀⠹⣦⠀⠀⠀
⠀⠀⣸⡇⠀⠀⢠⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠙⣷⡀⠀
⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⢸⡧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ⠹⣇⠀
⠀⢸⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠃⠀⢠⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⡤⠶⠒⠀⠀  ⢻⡇
⠀⣼⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡟⠀⠀⠀⠉⠙⠲⢦⣄⣀⣀⣀⡤⠶⠶⠛⠉⠁⠀⠀⠀⠀⠀⠀ ⠸⡇
⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣷⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠰⡇
⢰⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⢸⡗
⣾⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ⢼⡇


-- saame vaadata kasutaja vanust
select Id, Name, DateOfBirth, dbo.fnComputeAge(DateOfBirth) as Age from EmployeesWithDates
-- kui kasutame seda funktsiooni, siis saame teada tänase 
-- päeva vahet stringis välja tooduna
select dbo.fnComputeAge('06/09/2008')

-- nr peale DOB muutjuat näitab, et mismoodi kuvada DOB-d
select Id, Name, DateOfBirth,
convert(nvarchar, DateOfBirth, 109) as ConvertedDOB
from EmployeesWithDates

select Id, Name, Name + ' - ' + cast(Id as nvarchar) as [Name-Id]
from EmployeesWithDates



--░░░░░░███████ ]▄▄▄▄▄▄▄▄						\☻/
-- ▂▄▅█████████▅▄▃▂       						 ▌
--[███████████████████].						/\
--	◥⊙▲⊙▲⊙▲⊙▲⊙▲⊙▲⊙◤..


select cast(getdate() as date) -- tänane kp
select convert(nvarchar, getdate(), 109) -- tänane kp
-- või 2 variant
select convert(date, getdate())

-- matemaatilised funktsioonid
select abs(-101.5) as [ABSOLUUT] -- absoluutväärtus
select ceiling(15.2) as [LAGI] -- tagastab 16 ja suurendab suurema täisarvu suunas
select ceiling(-15.2) as [LAGI] -- tagastab -15 ja suurendab suurema positiivse täisarvu suunas
select floor(15.2) as [PÕRAND] -- ümardav väiksema arvu suunas
select floor(-15.2) as [PÕRAND] -- ümardav negatiivsema arvu suunas
select power(2,4) as [JÕUD] -- astendab
select SQUARE(9) as [RUUT] -- ruut
select SQRT(9) as [PRITSIMA] -- ruutjuur
select RAND() as [SUVAKAS] -- random function

-- oleks täisarvud, aga kasutad rand-i
select (CEILING(RAND() * 10) * CEILING(RAND() * 10))
select FLOOR(RAND() * 100) -- või

⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣧⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀			
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣧⠀⠀⠀⢰⡿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀		
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡟⡆⠀⠀⣿⡇⢻⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀		
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠀⣿⠀⢰⣿⡇⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀		
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡄⢸⠀⢸⣿⡇⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀		
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⡇⢸⡄⠸⣿⡇⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀		
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⢸⡅⠀⣿⢠⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀		
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣥⣾⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀		
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀		
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⡿⡿⣿⣿⡿⡅⠀⠀⠀⠀⠀⠀⠀⠀		
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠉⠀⠉⡙⢔⠛⣟⢋⠦⢵⠀⠀⠀⠀⠀⠀⠀		
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣄⠀⠀⠁⣿⣯⡥⠃⠀⢳⠀⠀⠀⠀⠀⠀⠀		
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⡇⠀⠀⠀⠐⠠⠊⢀⠀⢸⠀⠀⠀⠀⠀⠀⠀		
⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⡿⠀⠀⠀⠀⠀⠈⠁⠀⠀⠘⣿⣄⠀⠀⠀⠀⠀		
⠀⠀⠀⠀⠀⣠⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣷⡀⠀⠀⠀		
⠀⠀⠀⠀⣾⣿⣿⣿⣿⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣧⠀⠀		
⠀⠀⠀⡜⣭⠤⢍⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⢛⢭⣗⠀		
⠀⠀⠀⠁⠈⠀⠀⣀⠝⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠠⠀⠀⠰⡅		
⠀⠀⠀⢀⠀⠀⡀⠡⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠔⠠⡕⠀		
⠀⠀⠀⠀⣿⣷⣶⠒⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠀⠀⠀⠀		
⠀⠀⠀⠀⠘⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⠀⠀⠀⠀⠀		
⠀⠀⠀⠀⠀⠈⢿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠊⠉⢆⠀⠀⠀⠀		
⠀⢀⠤⠀⠀⢤⣤⣽⣿⣿⣦⣀⢀⡠⢤⡤⠄⠀⠒⠀⠁⠀⠀⠀⢘⠔⠀⠀⠀⠀		
⠀⠀⠀⡐⠈⠁⠈⠛⣛⠿⠟⠑⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀		
⠀⠀⠉⠑⠒⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀		



-- iga kord näitab 10 suv nrt
declare @i int
set @i = 1
while (@i <= 10)
begin
	print FLOOR(RAND() * 100)
	set @i = @i + 1
end


⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠙⢻⣿⣿⣿⣿⣿⣿
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠴⢶⡞⣛⡶⠦⠤⠤⠤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⠿⣿⣿⣿⣿
⢀⣀⣤⣤⣤⣤⣤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣶⠁⠀⢀⡜⠁⠀⠀⠀⠀⠀⠈⢦⣀⣀⣀⣀⠀⢀⡴⢲⣀⣠⢤⡀⠀⠀⠀⢀⣀⣤⣶⣾⣿⣿⣿⣿⣿⣿⣦⠀
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣤⡀⠀⠀⠀⠀⠀⣠⣶⣿⣿⣿⣍⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣅⠀⢀⣷⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⣰⣿⣿⣿⣿⣿⣿⣇⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣦⠘⠛⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇
⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⢠⠏⠀⠀⠀⠀⠀⠀⠀⣄⠀⣠⣿⣿⣿⣿⣿⣿⣿⣷⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇
⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣿⣿⣿⣿⣿⣿⡇⠀⠌⠀⠀⠀⠀⠀⠀⠀⠈⢸⣿⣿⣿⣿⣿⣿⣱⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀
⠀⠘⢿⣿⣿⣿⣿⣿⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀
⠀⠀⠀⠙⢻⣿⣿⠋⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠁⠀⠀⠀⠀⠀⡀⠀⠀⠀⢀⠀⠀⠀⠀⠉⠙⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠀⠀⠀
⠀⠀⠀⠀⠀⠙⣿⣧⣤⣤⣄⣀⣨⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⣀⡴⠻⡊⢩⠦⠀⠀⠓⣀⡀⡠⠖⡴⠒⢦⢤⡂⠳⠤⣤⡙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⡿⡁⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⡟⠿⠿⢿⣛⡟⠛⠛⠛⠻⢿⣿⣿⣿⣿⣟⣶⣏⣀⠀⢰⡀⠀⠀⡀⢬⠈⠁⠠⢰⣀⠀⠀⠀⠸⣡⠄⣴⡋⡟⠌⢿⠋⠉⠙⠛⠛⠋⠉⠀⢂⠴⠃⠀⠈⢳⣤⡀⠀
⠀⠀⠀⠀⠀⠀⠑⡒⠒⠒⠚⠃⠀⠀⠀⠀⠀⠀⠉⠛⣿⣸⣷⣶⣿⣷⣍⠈⠥⡒⠐⠋⡠⣘⠀⢩⢄⠬⡚⠘⣝⣴⡞⣯⢾⠻⢀⠀⢧⠀⠀⠀⢠⢤⣀⡞⠃⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣀⠔⢊⡽⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡯⣯⢸⠛⣿⣿⣿⣧⢐⠠⢤⡆⠠⡄⣶⣶⣌⠦⢀⡐⣸⣿⠋⣿⢰⠆⠰⢦⠘⡆⠀⠀⢸⢈⣹⠇⠀⠀⠀⠀⠀⠀⠀⠀⠠
⠀⠀⠐⢚⡡⠠⠚⠲⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣎⢧⡏⣸⣷⠟⣿⣿⣿⣇⢚⣾⣸⡀⣻⣿⣿⡿⢟⣳⢇⠏⣿⣴⡏⠁⠀⢀⠤⢃⠸⣶⢤⣘⣞⡿⣄⢀⡀⠀⢀⠤⣤⡀⠀⠀
⠀⠀⠀⠠⠤⠴⠹⠂⠈⢛⠱⡄⠀⠀⠀⠀⠀⠀⢇⢸⣼⣻⣿⣧⣤⣽⣿⣋⠘⠮⢼⣿⣷⣾⣝⣵⣿⣿⣿⠆⠆⢄⡐⠉⠗⠒⣚⡦⠀⠑⡽⢦⠀⠈⠳⢄⠁⠉⢉⣯⡞⠉⠀⠀⠀
⠀⠀⠀⠘⠁⠀⠀⠲⠀⠈⠙⢒⠋⠙⠦⣄⠀⠀⢨⡯⠰⣿⣿⣿⣿⣿⠟⠙⠩⢓⡌⠻⠿⠿⣿⣿⣿⡿⠁⠀⠬⠈⢈⠃⢰⠀⠋⠀⠀⣀⠙⢿⡶⠤⠬⠼⠃⠀⠀⠹⠼⡀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢠⢀⡀⠐⠲⠬⠇⠈⠇⠓⡝⠀⡮⠀⡠⢿⣿⣿⣟⠛⠀⡔⣡⣔⢠⡔⠀⢠⠭⡿⠿⠁⢀⡘⣄⠡⠠⢤⡇⣸⡂⠁⡀⢀⠀⡻⢸⠀⠀⣠⠤⢤⡔⡲⠒⠚⠓⠢⠤
⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⡯⡴⢃⢀⠬⣅⠀⠀⢳⢀⣾⣽⣯⣿⣿⡟⡔⣓⠄⠂⣓⢮⣙⢗⣀⠩⣣⠁⡺⠵⣄⢦⡅⣝⣾⣱⣧⠀⠈⠂⠠⠹⣼⠦⠀⣿⡄⡠⡁⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣀⡀⢠⠖⠚⠁⠀⠠⣉⠀⢸⢠⡤⢸⠘⣻⣯⣿⣿⣿⣿⣴⣻⠿⣖⣤⡍⣨⣠⣮⣷⣔⣾⣇⣇⣭⣑⣾⣵⣿⣿⣿⡐⢦⣐⣄⡂⡞⣓⣺⡉⠈⠁⠀⠀⠀⠄⠀⠀⠀
⠀⠀⠀⠈⠉⠁⠈⢙⠦⠤⠖⠊⠟⠁⠀⠜⠒⠓⠊⣿⣿⣿⣹⣽⣿⣿⣿⣿⠷⢿⣿⠿⠛⢛⡻⡛⢛⢻⣿⣿⣛⢛⡻⢛⡻⢿⣿⣿⣾⡿⠇⢨⠟⠁⠀⠙⣆⣀⣀⡢⠀⠁⠀⠀⠀
⡀⠀⠀⠀⠀⠀⠀⠁⠀⠀⡀⠀⠀⠈⠘⠒⠛⠀⠐⢸⣿⣿⣿⣿⣿⣿⣿⣧⣤⣤⣬⣾⣿⣿⣿⣿⣿⣧⣿⣿⣿⣿⣽⣽⣷⢺⠿⣿⣾⣷⣾⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠒⠢⠀⢸⣿⣿⣷⣽⣿⣿⢯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⢿⠿⠛⢍⡾⢫⣭⢻⣿⡾⣷⡀⠀⠀⠀⠀⢀⣀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠋⢡⣿⣿⣿⣿⣟⣿⣿⣿⠙⠟⣹⣿⣿⣿⣿⣿⣾⣿⣿⣿⣇⢋⠈⠀⠐⢫⢸⣮⡇⣾⣿⣿⣿⡽⣎⠉⠹⢄⡋⣀⠉⠒⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣴⣿⣧⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣾⣿⣿⣿⣿⣾⠙⡋⢿⣿⣿⡧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀

-- 7 tund 28.03.2025
select Round(850.556, 2) -- ümardab kaks kohta peale komat, tulemus 850.56
select Round(850.556, 2, 1) -- ümardab allapoole, tulemus 850.55
select Round(850.556, 1) -- ümardab ülespoole üks koht peale komat.
select Round(850.556, 0) -- ümardab täisarvuni
select Round(850.556, -1) -- ümardab sajani
select Round(850.556, -2) -- ümardab tuhandeni


⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣴⣶⣾⣿⣿⣿⣿⣷⣶⣦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣠⣴⣿⣿⣿⣿⣿⠿⣿⣿⣿⣿⠿⣿⣿⣿⣿⣿⣦⣄⠀⠀⠀⠀⠀
⠀⠀⠀⣠⣾⣿⣿⣿⠟⠋⠁⠀⠀⣿⣿⣿⣿⠀⠀⠈⠙⠻⣿⣿⣿⣷⣄⠀⠀⠀
⠀⠀⣴⣿⣿⣿⠏⠁⠀⠀⠀⠀⠀⣿⣿⣿⣿⠀⠀⠀⠀⠀  ⠈⠹⣿⣿⣿⣦⠀⠀
⠀⣼⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀  ⠈⢿⣿⣿⣧⠀
⢰⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀  ⠈⣿⣿⣿⡆
⣾⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⢸⣿⣿⣷
⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀  ⢸⣿⣿⣿
⢿⣿⣿⡇⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀ ⢸⣿⣿⡿
⠸⣿⣿⣿⡀⠀⠀⣠⣾⣿⣿⣿⡿⣿⣿⣿⣿⢿⣿⣿⣿⣷⣄⠀⠀⢀⣿⣿⣿⠇
⠀⢻⣿⣿⣷⣠⣾⣿⣿⣿⡿⠋⠀⣿⣿⣿⣿⠀⠙⢿⣿⣿⣿⣷⣄⣾⣿⣿⡟⠀
⠀⠀⠻⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⣿⣿⣿⣿⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⠟⠀⠀
⠀⠀⠀⠙⢿⣿⣿⣿⣦⣄⡀⠀⠀⣿⣿⣿⣿⠀⠀⢀⣠⣴⣿⣿⣿⡿⠋⠀⠀⠀
⠀⠀⠀⠀⠀⠙⠻⣿⣿⣿⣿⣿⣶⣿⣿⣿⣿⣶⣿⣿⣿⣿⣿⠟⠋⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠻⠿⢿⣿⣿⣿⣿⡿⠿⠟⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀


---
create function dbo.CalculateAge(@DOB date)
returns int
as begin
declare @Age int

set @Age = DATEDIFF(YEAR, @DOB, GETDATE()) -
	case 
		when (MONTH(@DOB) > MONTH(GETDATE())) or
			(MONTH (@DOB) > MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE()))
		then 1
		else 0
		end
	return @Age
end

execute CalculateAge '10/08/2020'

select Id, dbo.CalculateAge(DateOfBirth) as Age from EmployeesWithDates
where dbo.CalculateAge(DateOfBirth) > 36




⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⢶⠲⠐
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡤⠊⠊⢀⠐⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣶⣀⠄⠚⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣼⣿⠟⠁⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣶⢻⠟⠁⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣤⣀⠀⠀⠀⢀⣴⣿⡽⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢠⣼⣿⡟⠀⠀⣠⣼⣿⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣷⣀⣾⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢀⣤⣾⣿⡿⠃⣼⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢀⣴⣾⣿⣿⠟⠋⠋⠀⠙⠝⠻⡂⠀⢀⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢰⣿⣿⣿⣿⡇⠀⡀⠙⢆⡀⠀⠀⠉⠉⣡⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢿⣿⣿⣿⣿⣿⣦⡀⢀⠀⠠⢀⡤⠚⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠘⢻⣿⣿⣿⣿⣿⣿⡌⠀⠀⡜⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠩⢿⣿⣿⣿⣻⣿⠀⣼⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠙⠿⢿⣾⡿⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀




-- inline table valued functions

alter table EmployeesWithDates
add DepartmentId int
alter table EmployeesWithDates
add Gender nvarchar(10)

update EmployeesWithDates set Gender = 'Female', DepartmentId = 1
where Id = 1
update EmployeesWithDates set Gender = 'Male', DepartmentId = 2
where Id = 2
update EmployeesWithDates set Gender = 'Female', DepartmentId = 1
where Id = 3
update EmployeesWithDates set Gender = 'Male', DepartmentId = 3
where Id = 4
insert into EmployeesWithDates (Id, Name, DateOfBirth, DepartmentId, Gender)
values (5, 'Todd', '1978-11-29 12:59:30.670', 1, 'Male')
insert into EmployeesWithDates (Id, Name, DateOfBirth, DepartmentId, Gender)
values (6, 'John', '1978-11-29 12:59:30.670', 1, 'Male')

select * from EmployeesWithDates

-- scalar function annab mingis vahemikus olevaid andmeid,
-- inline table values ei kasuta begin ja end funktsioone
-- scalar annab väärtused ja inline annab tabeli

create function fn_EmployeesByGender(@Gender nvarchar(10))
returns table 
as
return (select Id, Name, DateOfBirth, DepartmentId, Gender
		from EmployeesWithDates
		where Gender = @Gender)


-- kõik female töötajad
select * from fn_EmployeesByGender('Female')
select * from fn_EmployeesByGender('Female')
where Name = 'Pam' -- täpsustus

select * from Department

-- kahest erinevast tabelist andmete võtmine ja koos kuvamine
-- esimene on funktsioon ja teine tabel
select Name, Gender, DepartmentName
from fn_EmployeesByGender('Female') E
join Department D
on D.Id = E.DepartmentId

-- multi-state

-- inline funktsioon

create function fn_GetEmployees()
returns table as
return (Select Id, Name, cast(DateOfBirth as date)
		as DOB
		from EmployeesWithDates)


select * from fn_GetEmployees()

-- multi-state puhul peab defineerima uue tabeli veerud koos muutujatega
create function fn_MS_GetEmployees()
returns @Table Table (Id int, Name nvarchar(20), DOB date)
as begin
	insert into @Table
	select Id, Name, Cast(DateOfBirth as Date) from EmployeesWithDates

	return
end

select * from fn_MS_GetEmployees()

-- mis vahe on inline funktsiooni ja multi-statementl???
-- inline funtksiooni sooritusaeg on kiirem, mutlistate kulutab rohkem ressursse, sest see on stored procedure

-- muutke andmeid, Sam muutub Sam1
update fn_GetEmployees() set Name = 'Sam1' where Id = 1 -- saab muuta andmeid
update fn_MS_GetEmployees() set Name = 'Sam1' where Id = 1 -- ei saa muuta multistate puhul

⠀⠀⠀⠀⢀⠀⡀⠀⠀⠀⢀⡀⠀⢀⡀⡀⢠⠀⣠⡄⠀
⠀⢀⣠⣾⠋⢠⣷⡾⠯⣴⣿⠷⣴⠿⣷⣷⡾⣴⡿⠀⠀
⠀⣨⠿⠟⢉⡿⠛⠳⠜⠛⠃⠀⠙⠶⠟⠘⠁⠏⠀⠀⠀
⠈⠁⠀⠀⠀⠀⢸⣆⠀⠀⠀⠀⠀⣸⡆⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣼⣏⠓⢶⡶⣶⢶⢻⣧⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢰⡿⠿⠄⠈⢷⠹⡌⠇⠸⡄⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠈⣇⠀⢀⣶⣶⣀⢠⣾⣶⡇⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠹⣴⣄⣙⠛⠘⢿⡂⢾⠗⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢨⣿⣟⠃⣴⣿⣿⢸⣇⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⡾⡟⠉⠣⣌⣿⣿⣿⣿⡆⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠘⠿⠇⠀⠀⠀⠘⠿⣇⢰⡃⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡿⡇⠀⠀⠀⠀
⠀⠀⢀⡄⣀⡄⠀⡀⠀⢀⠀⠀⠀⡀⢸⡟⣷⠀⢀⡀⠀
⠀⢀⣾⡿⢋⣴⢿⣿⣤⣿⣀⣾⣼⢿⣿⣟⠉⢠⣿⣅⡀
⢠⡾⠛⢷⠒⡿⠟⢁⡼⠋⠟⠹⠃⠞⠁⠙⠿⠋⠹⠏⠀
⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢀⠀⢀⡀⠀⢀⣀⣀⡀⣀⠀⢀⣀⣀⣀⢀⣀⠀
⠀⣾⣿⣿⣿⣿⢿⣹⣿⣿⣿⢻⣿⣗⣾⣿⡿⣿⣿⠿⠀
⠀⠉⠉⠃⠈⠁⠈⠈⠁⠀⠁⠈⠉⠉⠁⠀⠀⠀

-- 8 tud 07.04.2025

-- deterministic and non-deterministic

select count(*) from EmployeesWithDates
select square(3) -- kõik tehtemärgid on deterministlikud funktsioonid, sinna kuuluvad veel sum, avg ja square()

-- non-deterministic
select getdate()
select current_timestamp
select rand() -- see funktsioon saab oll mõlemas kategoorias, kõik oleneb sellest, kas sulgudes on 1


-- loome funktsiooni

create function fn_GetNameById(@id int)
returns nvarchar(30)
as begin
	return (select Name from EmployeesWithDates where Id = @id)
end

execute fn_GetNameById

drop table EmployeesWithDates

create table EmployeesWithDates
(
Id int primary key,
Name nvarchar(50) NULL,
DateOfBirth datetime NULL,
Gender nvarchar(10) NULL,
DepartmentId int NULL
)

select * from EmployeesWithDates

insert into EmployeesWithDates(Id, Name, DateOfBirth, Gender, DepartmentId)
values 
(1, 'Sam', '1980-12-30', 'Male', 1),
(2, 'Pam', '1982-09-01 12:02:36.260', 'Female', 2),
(3, 'John', '1985-08-22 12:03:30.370', 'Male', 1),
(4, 'Sara', '1979-11-29 12:59:30.670', 'Female', 3),
(5, 'Todd', '1978-11-29 12:59:30.670', 'Male', 1)

create function fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
as begin
	return (select Name from EmployeesWithDates where Id = @Id)
end

sp_helptext fn_GetEmployeeNameById

select dbo.fn_GetEmployeeNameById(3)

-- krüpteerige funktsioon fn_GetEmployeeNameById

alter function fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
with encryption
as begin
	return (select Name from EmployeesWithDates where Id = @Id)
end

-- krüpteeritud sisu
sp_helptext fn_GetEmployeeNameById

-- muudame ülevalpool olevat funktsiooni, kindlasti tabeli ette panna dbo.Tabelinimi

--alter function fn_GetEmployeeNameById(@Id int)
--returns nvarchar(20)
--with schemabinding
--as begin
--	return (select Name from EmployeesWithDates where Id = @Id)
--end

drop table dbo.EmployeesWithDates

⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡟⠉⢹⣦⠀⠀⠀⣼⢯⡀⠘⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⢳⠤⠚⡿⠀⠒⠂⢻⣿⠃⠀⠈⡇⠀⠀⠀⢀⣠⣤⣤⡤⢰⡶⠖⢲
⣾⠙⠃⣭⡉⠻⠶⣤⡀⠀⠀⢸⣿⡞⠀⢀⣧⠀⠀⠀⢸⣷⡇⢠⢐⡇⠀⢀⡴⠃⣼⣿⣿⠃⠀⠀⠀⡾
⠸⡀⠀⠙⣿⣶⣆⠈⢛⣦⠀⠈⡿⡆⠀⠈⢹⡄⠀⠀⣼⡏⠑⠀⣾⠃⠀⣼⠇⠀⢿⠟⠃⠀⠀⢀⡜⠁
⠀⢣⠀⠀⢿⣿⣟⠃⠀⠙⡆⠀⣿⡷⠄⠀⠈⠙⢢⣾⠁⠀⠀⠀⣿⠀⡸⠏⠀⢾⣶⣦⡀⠀⣠⠎⠀⠀
⠀⠀⢣⠀⠀⣿⣿⣧⡀⠀⠹⣴⠋⠀⠀⠀⠐⠊⠉⠙⢷⡀⠀⠀⠙⢿⡅⠀⣠⣾⣿⠉⣥⠞⠁⠀⠀⠀
⠀⠀⠀⠳⡄⠈⠻⣿⣦⣄⣾⠃⠀⠀⠀⠀⠀⠀⠀⠀⠈⢹⠀⠀⠀⠀⠙⠺⢿⢛⣡⠜⠁⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠈⠢⣄⣨⡟⠋⠀⠀⢂⠀⠀⠀⠀⠀⠀⠀⢧⣿⡗⠂⠀⢀⠀⡀⠀⢻⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⡿⠀⠈⠉⠐⠈⠑⢤⣦⣀⡂⠀⠀⠘⢿⠟⢘⣻⣿⣿⣿⣷⣃⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢱⣴⣶⣿⣟⠂⣀⠀⠉⠣⠇⠀⠀⠸⡎⠀⠿⠛⣿⣷⣿⠏⠁⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠉⠹⣷⣾⣿⡏⠛⠆⠀⢰⡶⠀⡀⠐⠿⠀⠀⠀⠉⠛⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡿⠋⠀⠀⣠⣦⡼⠃⠀⠁⠀⢠⡄⢲⠀⠀⠀⢧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡖⠀⠀⠀⣈⠁⠞⠀⠀⢤⣤⡿⠂⢠⣶⣴⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣥⣿⠀⠀⣽⠀⠀⠀⠀⠀⠘⢻⣀⠈⣿⠙⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⠋⣴⣿⣿⠈⡁⡀⠀⢀⣠⣾⣿⣧⣹⣾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⢁⡿⣇⢳⣹⡅⣿⢛⣿⠿⢿⡿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡟⠀⠈⠙⠋⠀⠘⠉⠁⠀⢠⣿⣏⢻⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣷⢤⠀⠀⠀⠀⠀⢲⢀⣾⡿⢿⣮⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣦⣬⣀⡀⣀⣤⡴⠿⠋⠀⠈⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⠉⠉⠉⠁⠀⠀⠀⠀⠀⠘⣿⡟⣆⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⠄⠀⢰⣾⣿⠻⣶⣦⣀⠀⠀⠉⢨⣇⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣤⣀⠈⠛⠛⠿⠞⠛⠁⣰⣆⠀⢸⣿⣧⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣷⣌⡀⠐⠀⠀⠀⢀⣰⣿⣿⣇⠈⢿⣟⣷⡀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣆⠀⢰⣶⣿⣿⡿⣿⣿⡆⠘⢿⡿⣿⣆⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣋⢢⠈⢿⣟⣯⡷⣿⣯⡼⠀⠀⠙⠋⠁⠁⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀




-- Temporary tables

-- #-märgi ette panemisel saame aru, et tegemist on temp tabeliga
-- seda tabelit saab ainult selles päringus avada


create table #PersonDetails(Id int, Name nvarchar(20))

insert into #PersonDetails values(1, 'Mike')
insert into #PersonDetails values(2, 'John')
insert into #PersonDetails values(3, 'Todd')

select * from #PersonDetails


-- saab vaadata kõiki tabeleid, mis on süsteemis olemas või loodud kasutaja poolt

select Name from sysobjects
where Name like 'Gender'

-- kustutame temp tabeli
drop table #PersonDetails







⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣄⣠⣤⣄⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⢧⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⡶⢞⠋⠉⠭⠭⠭⠭⠝⠧⠭⠭⠟⠛⠛⠿⣦⣤⣀⣀⠀⠀⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠛⢶⣄⣀⠀⠀⠁⠈⠁⢁⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣶⠾⠋⠁⠐⡌⠀⠠⠀⠤⠘⠓⠒⢂⢉⡑⠠⠀⠀⠀⢳⣉⣙⣿⣿⣶⣤⣉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠚⠿⢻⣟⡂⠀⠄⠄⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣼⠟⠭⠵⠟⠛⠻⠧⠼⠴⠆⣉⠂⠌⡐⠡⢒⠒⢒⠒⡙⡒⠖⣦⡭⠭⢅⡉⠀⠈⠹⣶⣤⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠱⢤⣤⡀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⡿⢻⡼⠁⢂⡀⠒⠈⢂⠡⢊⠐⠂⠄⠌⠠⢁⠁⠆⠩⠄⡉⠐⠄⠃⡈⢁⠊⢄⡁⠄⠠⢠⠦⣹⢿⣶⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠧⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣤⣤⣾⣿⣯⠵⢂⠡⠐⡀⡐⢂⠒⠠⢀⠄⣈⡐⡈⣄⣁⣂⣉⠄⡡⢈⡁⢊⠉⢁⡐⠠⡈⠐⠠⠉⠍⡉⠀⠀⠙⢻⣿⣧⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⠟⠃⢀⠂⡐⢠⠐⡰⣬⢊⠽⢦⠞⣞⡓⢿⣼⢫⡝⢮⡟⡟⢷⠿⣿⣿⡷⠤⡁⠄⢃⡘⡈⠐⡀⠃⣁⠀⣸⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡔⢠⣾⣿⡟⠛⠒⠓⣶⡖⠁⡖⢩⠒⣼⡎⡞⣬⠛⣴⢫⡝⣯⣯⡟⣿⡟⣯⢣⠛⣴⢣⡟⢻⣼⢳⣶⣶⣦⡅⠀⠁⢠⠀⢢⠀⢻⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢡⣿⣿⣽⣶⣶⡆⠐⣛⣡⣃⣼⣷⣿⣿⣽⣧⣝⣮⠵⣎⡳⣽⣾⣷⢻⣿⣼⣎⢏⠷⣫⢞⡽⣇⢮⣭⣿⣿⡿⣿⠌⠄⡒⠈⣀⠈⣿⣿⣿⣿⣤⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣼⣇⣿⣿⡿⢏⣐⣭⣽⣿⣿⣿⣿⣿⣿⣿⣟⣿⣻⣟⢮⡽⣹⣿⣿⣏⣿⡿⢣⢎⣯⢳⣏⣾⡹⢦⡽⣝⣶⣿⣭⢻⣷⣤⣼⢀⠈⠛⣿⣬⣛⣿⣷⡄⢂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣯⣿⣿⠟⣠⣞⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣷⣻⣼⣻⣼⣳⣿⡿⣞⣧⡚⡵⣚⡼⢳⢎⡳⣙⢶⡹⣻⣿⡿⣿⣟⢮⣛⣿⣠⢂⣀⣈⠙⠛⣻⣿⣿⣄⠡⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⡛⣏⠞⣷⡾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣷⣷⣿⡵⣻⡎⢧⡙⡴⢣⢞⡭⣚⠽⣘⡷⢩⡟⡿⢟⣿⣿⣯⢏⡷⣿⢛⠛⣌⠐⢢⠘⢿⣿⣿⣦⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣼⣿⣻⣽⢷⡹⣬⣟⢾⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⡷⣯⡟⢦⢳⡩⢏⡞⣴⢫⡝⣵⣿⠱⡯⡝⣎⢟⡟⣣⢏⠶⡿⢦⣩⣄⡉⢦⣭⣮⣿⣿⣿⣷⡂⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣶⣿⡽⡿⡽⣿⡹⣖⣯⣟⡾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣻⡝⢯⢶⣙⢮⡝⣮⠳⡜⡼⣿⠋⢗⡹⠜⣎⢾⡱⣏⣯⣙⣯⣛⠿⣿⣔⣂⣯⠁⢸⣿⣿⣷⡈⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⣷⢿⡳⡽⣡⢷⣹⢶⡯⣟⡷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣳⠿⣜⢯⡞⡽⣮⡝⡶⣛⠼⡱⢡⠍⢦⢱⣽⢼⣾⣿⣿⣿⣿⣿⣿⣿⣹⣿⣿⣽⢂⣿⡻⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⡧⢿⣯⣿⢽⣟⡮⢯⡿⣽⢯⡿⣽⣏⡿⣽⣻⢿⡿⣿⣿⡿⣿⣿⣿⣿⣟⣾⢽⣻⣽⣾⡹⢳⢧⡛⣵⢩⢞⡡⢇⡚⣸⢾⣯⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣿⡞⣿⣷⠿⣸⣿⣿⣀⠀⡀⢱⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣰⣿⣿⣿⣟⣻⣳⣿⢾⣯⡽⣏⡿⣽⢯⣟⣷⣻⢾⣱⣛⡾⣽⢳⢧⡻⣍⡻⡜⢶⡩⢎⢯⡝⣏⢯⡱⢏⡶⣙⠦⣏⢞⣱⠫⡴⢥⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣻⠉⢳⢫⣙⡿⣷⣦⡉⠌⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢨⣿⣿⢯⡱⣻⢏⡟⣿⡼⣩⢾⡵⣫⡽⢯⣟⣾⣳⢯⣯⠷⣝⣾⣱⢯⡳⣽⢸⡱⣙⠶⣙⢎⢢⡙⡴⢊⡵⢋⠶⣙⠞⣬⢣⣇⠳⣡⢃⠞⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣻⠀⣼⡀⢆⠘⣬⣿⣷⢠⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⡲⣱⣷⣿⣾⣿⣳⣍⡾⣷⣹⡽⢿⣞⣷⢯⣟⣾⣻⡽⡶⢯⣗⡻⣬⢷⡵⣍⠮⡑⢎⡾⡵⣩⠓⡜⣭⢚⡥⢫⠔⣣⢚⠣⢦⠿⢘⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣛⢿⣿⣁⢸⠸⣾⣶⢻⡗⢻⣿⡀⠑⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⡄⠫⣿⡱⣭⠳⣽⣿⣿⣿⣿⠖⣿⡼⣿⡷⣫⢿⡺⣽⢯⣟⣾⣳⢯⡽⣳⢎⡷⣹⣎⠷⣏⠲⣉⢮⣷⡷⢦⣿⣸⣦⣯⡒⢧⡙⣤⠣⡙⡌⢠⠠⠰⡘⡟⢟⠻⠿⠿⡿⢿⠿⠟⠏⡴⣩⠖⣼⣧⢸⣰⣿⣿⣼⢻⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣜⣷⣼⣿⣝⡶⡽⣎⠟⣹⢋⣿⣏⡿⡵⣿⣿⣵⣎⢳⡭⢷⣞⣳⢯⣯⢷⢯⣾⢷⡷⣚⢳⡎⣱⣼⡞⣿⡟⢾⣿⣟⣷⣾⣟⢶⣙⢦⡟⣏⡱⣻⢰⠀⠎⡘⠨⣁⢋⠘⡄⢃⠎⡩⢑⡰⣽⡟⣿⠃⠸⠛⠛⠡⠘⣿⣿⡜⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣧⣿⣶⣿⣿⣿⣇⢧⣋⣶⡩⢖⢮⢱⠒⡟⣿⠿⣌⠳⣜⢯⢾⣽⣻⢮⣟⣯⣿⣮⣷⣭⣷⣿⣯⣷⣀⢿⢻⠘⣿⣯⣿⣿⣿⣮⣝⣮⣳⣾⣧⣿⣿⠌⠰⣁⠲⣀⠎⡰⣈⠦⡘⢤⢃⠲⣹⣾⣿⢧⣀⢠⣩⢄⣠⣈⡻⢿⣻⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣿⣟⡿⢿⠿⢧⠾⢿⡿⠽⠿⣏⡜⠦⡍⡷⢬⢳⢬⠳⣬⣿⣞⣷⢯⣷⡿⣞⣿⣿⣷⣿⣿⣿⣿⣿⣿⣾⣾⣆⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⠙⢿⡿⢃⠔⡠⢃⠴⡒⠰⣄⢣⡙⡔⣊⠱⢤⠿⣿⠿⢩⠹⠋⢀⢻⢨⣷⣾⢹⣿⢻⣿⣷⡄⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢇⡿⣿⣿⣿⠸⢇⠾⠹⣏⠹⢱⠆⡾⢱⡈⡇⡏⡾⣈⠷⡶⢿⣹⣏⡿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣾⣿⣿⣿⡿⢰⢹⣿⣿⣿⣿⣿⣿⡿⠏⣰⣆⠰⠈⠹⢰⢉⡾⢱⢷⡈⣆⠱⣆⠁⡇⢆⣷⡎⢰⣷⠀⢰⣿⣇⣷⠹⣿⠸⣿⣈⣿⣿⣇⡰⡀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢠⣿⣷⡆⢡⣉⡟⡌⣎⢱⣬⢧⣧⢟⢬⣳⡬⢵⡙⢶⡩⢞⣱⠻⣷⣿⡿⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣻⣝⣿⣿⣿⣿⣿⡿⢠⠐⣹⣿⣾⣏⣡⣿⢠⣟⡳⢎⠶⣌⠣⣌⠓⡬⢟⣿⣿⡇⠺⠀⠀⡰⣛⣿⡐⣿⡇⣦⣄⣽⣿⣿⣷⣡⠀⠀⠀⠀
⠀⠀⠀⠀⣰⣿⣿⣿⣷⣶⣴⣱⡊⡔⣿⣋⣾⣿⡏⣆⠳⡘⡥⢚⡥⡛⡜⢦⡛⣼⣿⣟⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣎⣥⢻⣿⣿⣿⣿⣿⣷⣿⣧⣙⣎⣳⣬⣙⣡⠚⢠⢸⢻⡿⠇⠀⠀⠻⠦⢼⡿⠅⢿⡳⣤⣆⠬⢿⣿⣿⣯⡅⠀⠀⠀
⡀⠀⠀⢀⣿⣿⣿⣿⣯⣿⡿⣾⠇⣼⢿⡼⠿⠿⡵⢎⡱⠱⣌⢓⠲⡙⡜⢦⡝⣼⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣷⣯⣼⣿⣿⣯⣯⣽⡿⢀⠂⢰⠄⢂⣰⡧⣴⣦⡀⠀⠀⠀⠘⣥⣤⠀⠸⣿⣿⠛⠘⣿⣿⣿⣿⡀⠀⠀
⡁⠀⠀⢸⣿⡏⠽⣿⣿⣿⣿⣹⠜⣿⣟⢲⡉⢧⡑⢎⡔⢣⠜⣌⠣⡕⡞⡲⣿⣿⡿⣻⣾⣷⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⡾⢏⡀⠬⣌⣽⣿⣭⡏⠿⠿⠽⠠⠤⠠⢤⣿⣿⣥⡀⠀⠀⠚⠟⣿⣿⣿⣿⣷⡀⠀
⡄⠀⣰⣾⡿⠿⡳⢯⣿⣿⣿⢛⣼⣿⢿⣢⠙⢦⡘⠦⡜⣃⠞⡤⢳⢚⣳⣟⢻⣿⣿⣷⣿⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣏⠐⣠⣷⣧⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⡸⢿⣿⣿⡇⠀⠀⠀⣴⣿⠿⢿⣿⣿⣷⡀
⠆⢰⣿⣿⢣⢏⡱⢊⡏⣟⢋⣎⡿⡹⢞⡥⣋⠦⡱⢓⡜⣆⢳⡬⣓⢬⣸⡥⢻⣿⣿⣿⣿⣽⣾⡿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣽⣯⣷⣿⣻⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣟⡆⠐⢨⣉⠀⠙⠃⠀⢀⠀⠀⢤⠤⠤⢿⣿⠀⠙⠛⠐⠀⠤⠘⡾⣿⠒⡘⣏⣿⣿⣷
⡀⢼⣿⡿⣡⢎⡴⠟⣿⣧⣾⡗⣛⢷⣿⡚⢥⢎⡱⢍⡞⡴⢫⠝⣿⣟⠲⣡⢋⢽⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⡟⡱⡿⣿⡟⠂⠀⠛⠀⡀⠄⠀⠂⠀⠀⠀⠀⠈⢿⣤⠀⠀⠀⠀⣀⠸⡆⣿⡇⠤⣽⣿⣿⣿
⢰⣿⣿⣷⣓⠮⡔⣹⣿⣿⣿⡑⢎⠮⡹⣙⠬⢆⡱⢎⡼⣘⡇⣚⣷⣿⠑⠦⣉⠎⡴⢻⣿⣿⣿⡿⣿⣿⣿⣿⣿⢿⣽⡿⢿⡿⣿⣿⣿⣿⣿⣿⣿⣟⡿⣿⣿⢿⡿⣿⢿⣹⢞⡿⢟⡓⠀⣶⠔⠀⠀⠐⠠⣤⣆⠀⠐⢶⡀⠐⠂⠸⣿⠇⠀⢀⣡⣶⣷⠊⠉⠉⢿⡟⣿⣿⣿
⣼⣿⣿⡿⣟⠳⣘⢼⡛⢏⣻⢚⠬⡹⣥⢫⢜⡡⢎⡹⢌⡍⢣⠥⡩⢌⠭⡙⢤⢋⡔⢫⣿⣿⣿⢏⡱⠳⢆⡳⢜⡺⣿⢻⣿⣜⣳⣭⣿⢭⠿⣽⣿⣽⣻⣿⢯⣟⣼⡳⣯⢳⣯⣟⣼⠷⣀⠈⠀⢀⢨⣇⣄⣠⡿⡏⠀⠈⠇⡐⠈⢀⠁⠀⡀⠘⠋⠛⣡⡠⠁⢍⣸⣧⣿⣿⣼
⡿⢻⣟⣿⢡⢏⡒⢦⡙⢦⡘⢾⡱⢱⣞⢧⡚⡔⢣⡒⢬⡘⣆⠣⡕⣊⠖⡩⢆⠣⡎⢥⢻⣿⡐⢎⠲⣙⠬⣜⣢⢕⡯⣾⣿⡴⢧⣭⢿⡻⡿⢯⠞⣭⠻⣝⣿⣾⣵⣿⣥⣯⣧⣿⣿⡄⢻⡀⠐⠂⢰⠖⢻⣶⣇⠀⠀⠂⠉⠉⠩⠈⢦⠏⠁⡇⠀⠱⡡⠅⡛⢃⢻⣿⢸⣿⣿
⡷⢩⢾⣿⡚⢆⢿⣿⠟⣭⣽⣾⣯⡹⢎⡱⡜⢬⢣⣾⣧⣝⢣⢳⡘⢤⢋⠴⣉⠖⡩⢆⠣⢼⣋⣌⡓⣾⣷⣿⣿⠛⡁⣿⣿⠥⢸⣌⢢⣱⣜⣢⡝⡸⠿⣿⠿⠿⠟⡩⢉⠅⡉⢸⣿⡇⠈⠿⠄⠀⢻⡠⠸⣿⣧⡇⣴⣦⡇⠀⠀⡀⠋⣠⡄⠀⠀⠐⢀⢂⣷⣶⣠⣿⣛⣻⣿
⣏⢳⢺⣿⣽⡎⢺⣽⣿⣾⣿⣿⣷⣙⣎⣷⣙⣎⣽⣻⣿⣿⣏⣶⢩⡒⣍⠲⡡⢎⡱⢊⠵⢾⡵⠷⠮⢧⠽⣿⠛⠁⠶⣿⡟⡓⣿⡗⣦⠥⠾⠭⠖⠃⠴⢠⠊⢆⠓⠤⣋⣴⣤⡞⢿⡗⡀⣂⡄⢳⢨⠹⢿⢿⠟⣹⣿⣿⣷⡌⣣⣼⠁⠀⠠⠙⠀⠌⡁⠛⣸⣿⣿⡟⢥⣼⡻
⣏⣾⣿⣿⣷⣇⢻⣿⣷⢿⣿⣿⢧⣿⣿⡿⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⢧⡱⢎⠴⣉⠎⡼⢰⡉⢎⣹⡞⣿⡄⡀⣼⣿⣃⣷⡘⣿⡞⠄⠀⠀⢀⠡⡘⢤⠉⡄⢊⠴⣿⣿⡿⢀⣿⣆⠘⣿⣷⣿⣿⠀⠀⠂⠸⢿⣿⡟⢋⣿⣿⣧⢀⣈⣴⢀⣈⣰⡡⢾⣿⣿⢿⡿⣸⣿⣿
⣿⣾⣿⣿⣿⣯⢿⣿⣿⣟⣿⣿⣚⣿⣿⢳⣜⣿⣿⢿⠢⡝⡛⢿⣿⣿⣿⢦⡳⢮⡗⣌⠚⣌⠳⠼⢦⠿⣿⣿⣷⣿⣾⣿⠁⣿⢓⡛⢹⣽⣒⣒⠺⡂⢍⢆⡓⡈⠆⣹⡿⢉⠄⢺⣯⣥⣆⣷⣎⠰⢸⠁⠀⠐⠠⠀⠀⠀⢣⠀⢀⠈⡇⠀⠀⢈⣿⣿⣿⣿⣿⣿⢸⣷⣹⢿⣿
⡟⣼⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿⢏⡽⢿⡒⡜⢢⠛⣧⠛⡴⣹⣞⡛⡟⣿⣣⣝⣎⠳⣌⠳⢌⢣⡙⡬⢳⣇⣺⣿⣿⣿⡿⢌⡓⢢⠜⣸⠄⡒⢌⡱⣘⢬⣒⡴⡁⠎⣼⢁⠆⣸⣸⣿⣿⠿⣏⣡⣛⠈⡀⠀⠂⣀⠄⠀⠀⣜⣀⣿⣿⠱⠲⣶⣿⣿⣿⣿⡿⠿⡉⢾⣿⣿⣄⣽
⢧⣸⣿⣿⣿⣿⣏⣻⢻⣿⣿⣟⣇⣻⣞⣧⣻⣄⠲⣏⠶⣠⣏⣿⣥⣿⣧⡿⠿⢿⠧⡘⢦⡘⣄⠣⢴⢺⣼⣿⡿⣼⢿⡳⢾⡷⢺⡖⣿⠔⣳⣾⡷⢛⡛⢛⠣⡰⢆⣸⠀⢠⠀⢼⡟⢠⢀⡇⡀⢀⠀⠀⠠⢀⠀⡀⠄⡀⢸⠿⣿⠿⠆⣴⣿⢋⠿⣿⡿⢣⣆⠛⡄⣿⣿⠟⣿
⡚⣽⣿⣿⣿⣿⢢⢏⣻⡛⣿⢻⣽⣾⣟⣿⣷⡌⡗⣏⡳⡹⢎⡿⣼⣹⡏⣜⡙⢆⣣⠙⢦⡑⣎⡙⢢⢹⡼⣿⡗⣯⠷⣿⢸⣿⢸⣇⣾⠘⣿⣿⣇⠣⠜⡂⢥⠃⣆⠈⡰⠀⠎⣰⠀⢆⠲⣇⠴⣡⡌⡆⠀⢠⢘⣄⣂⣐⡀⠂⠄⢊⣭⢛⣛⠍⢢⣑⣎⣹⣯⡇⡜⠷⠦⠼⣸
⡳⢼⣿⣿⣛⣬⢳⣎⣵⣛⢦⣋⢾⣿⣿⣿⣟⡳⢭⣧⠳⣍⣿⣷⣿⣿⣷⣬⡙⣦⡇⣏⢦⡱⢆⡹⠤⡙⣿⢿⣱⣟⡿⣏⣾⣿⣿⡏⣿⢐⠢⡉⢝⡂⢧⢐⠊⡍⠍⡒⣏⠉⡘⢽⣦⣿⣿⣿⣶⠟⠛⣧⡌⣿⣵⠡⠀⠄⡐⠠⢈⠄⡇⢂⠰⢘⡈⠛⡟⢹⠇⡰⠌⢆⡙⢢⢙
⡱⢪⡜⣵⢚⡴⣫⡜⣾⣿⣧⢻⣽⣿⣿⡟⢧⡙⣧⣿⣻⣿⣿⣿⡽⣿⣿⣷⡹⢦⠹⡔⢦⢓⡜⡰⢣⠜⣿⣹⠎⣟⡿⡇⢻⣿⣿⡇⣿⡀⢢⠑⡌⢲⢡⠊⡜⢠⣳⣾⣇⡏⣔⣪⣿⣿⡿⡟⢉⠀⢀⢃⣴⣿⡇⢂⣁⡐⢀⠑⡠⢂⢁⣄⠣⠌⡧⡑⣬⣿⣼⠤⢊⣴⠌⢦⠡
⡱⢃⡞⡬⢏⢶⢣⢟⣿⣿⣿⣿⣽⠿⡿⡽⢦⠽⣛⠧⣿⣿⣿⣾⢿⣿⣿⣿⡗⡣⢝⡜⢪⠜⡰⣡⢃⠎⣹⢙⠧⡡⢍⢣⢍⠣⡍⠴⢩⠜⡠⠓⡌⠥⢢⠍⣐⢋⠿⡿⣟⠹⣧⣘⣰⢴⡐⡈⠄⡈⠄⢺⣿⣿⣇⢅⠢⢘⢀⠂⡔⢁⢺⢄⠣⣍⡳⢭⢶⣠⣿⡡⣿⡘⡜⢢⡑
⡱⣍⠶⣙⢮⢣⢟⢮⣻⣿⣿⣟⡯⢳⣅⣻⢎⡳⣍⠞⣿⢫⣏⣯⣏⢷⣻⣿⠷⣩⢚⢬⢣⡙⡴⢡⠎⡜⡡⢎⠲⡑⢎⠲⣌⡳⢌⢣⢇⣞⡡⢣⣜⢨⣅⣚⡄⢋⠰⣷⣿⣿⣹⣇⣿⣿⣷⣸⡂⠔⣈⡸⠿⠿⣿⠤⢃⠌⢢⡼⡴⢡⡾⢬⡑⢆⡧⢌⡻⢟⣿⢳⣯⡴⢑⠦⡘
⠱⣎⢧⡹⢎⡽⢪⡳⣭⢟⡻⡵⢪⢗⣺⢻⡬⢗⡬⢳⡌⣷⣾⢷⣾⣣⣷⣿⣿⣿⡘⣎⢦⠱⣘⢣⡝⡰⡑⢎⡱⣉⢎⡱⢢⢹⣎⣿⣿⣿⣜⣿⣦⣿⣤⠊⡜⡀⠆⡹⡿⠟⡁⣿⢉⢛⢳⣸⣿⣿⣷⣐⢣⣒⡹⠎⡌⢎⢴⢣⣹⢺⣏⠦⣙⠮⣜⢬⡑⡎⣏⣼⣿⡆⡍⠦⡁
⠹⣎⠶⣙⠮⣜⢧⡻⣜⠯⣵⢫⡝⣎⠶⣣⠝⡮⣜⢣⠞⣴⣌⠶⣸⣿⣿⣿⣿⣿⡟⡴⣋⠼⣡⠇⡜⣡⡙⢦⠱⡌⢦⢃⠧⡙⠼⣿⣿⣿⣿⣿⢿⣿⣿⡘⣇⡱⢌⡐⠇⡵⢦⣿⠊⡔⣺⣿⣿⣿⠿⢿⣿⣿⣿⢦⡽⢾⡼⡗⠿⣽⢷⣇⣷⣾⣿⣶⡷⣻⡶⢞⡿⡷⢌⡡⠑

drop proc spCreateLocalTempTable
create proc spCreateLocalTempTable
as begin
create table #PersonDetails(Id int, Name nvarchar(20))

insert into #PersonDetails values(1, 'Mike')
insert into #PersonDetails values(2, 'John')
insert into #PersonDetails values(3, 'Todd')

select * from #PersonDetails
end

exec spCreateLocalTempTable

-- Erinevused lokaalse ja globaalse ajutise tabeli osas:
-- 1. Lokaalsed ajutised tabelid on ühe # märgiga, aga globaalsel on kaks tükki
-- 2. SQL server lisab suvalisi numbreid lokaalse ajutise tabeli nimesse,
-- aga globaalse puhu seda ei ole.
-- 3. Lokaalsed on nähtavad ainult selles sessioonis, is on selle loonud,
-- aga globaalsed on nähtavad kõikides sessioonides.
-- 4. Lokaalsed ajutised tabelid on automaatselt kustutatud,
-- kui selle loonud sessioon on kinni pandud, aga globaalsed
-- ajutised tabelid lõpetatakse, viimane viitav ühendus on kinni pandud.

-- globaalse temp tabeli tegemine
create table ##PersonDetails(Id int, Name nvarchar(20))

-- index
create table EmployeeWithSalary
(
Id int primary key,
Name nvarchar(25),
Salary int,
Gender nvarchar(10)
)

insert into EmployeeWithSalary(Id, Name, Salary, Gender)
values 
(1, 'Sam', 2500, 'Male'),
(2, 'Pam', 6500, 'Female'),
(3, 'John', 4500, 'Male'),
(4, 'Sara', 5500, 'Female'),
(5, 'Todd', 3100, 'Male')
select * from EmployeeWithSalary

select * from EmployeeWithSalary
where Salary > 5000 and Salary < 7000

-- loome indeksi, mis asetab palga kahanevasse järjestusse
create index IX_Employee_Salary
on EmployeeWithSalary(Salary asc)

select * from EmployeeWithSalary order by Salary asc

-- saame teada, et mis on selle tabeli primaarvõti ja index
exec sys.sp_helpindex @objname = 'EmployeeWithSalary'

select * from EmployeeWithSalary
with (index(IX_Employee_Salary))

-- saame vaadata tabelit koos selle sisuga alates väga detailsest infost
select 
	TableName = t.Name,
	IndexName = ind.Name,
	IndexId = ind.index_id,
	ColumnId = ic.index_column_id,
	ColumnName = col.name,
	ind.*,
	ic.*,
	col.*
from 
	sys.indexes ind
inner join
	sys.index_columns ic on ind.object_id = ic.object_id and ind.index_id = ic.index_id
inner join
	sys.columns col on ic.object_id = col.object_id and ic.column_id = col.column_id
inner join
	sys.tables t on ind.object_id = t.object_id
where 
	ind.is_primary_key = 0
	and ind.is_unique = 0
	and ind.is_unique_constraint = 0
	and t.is_ms_shipped = 0
order by 
	t.name, ind.name, ind.index_id, ic.is_included_column, ic.key_ordinal;

-- indeksi kustutamine
drop index IX_Employee_Salary on EmployeeWithSalary

-- indesi tüübid:
-- 1. Klastrites olevad
-- 2. Mitte-klastris olevad
-- 3. Unikaalsed
-- 4. Filtreeritud
-- 5. XML
-- 6. Täistekst
-- 7. Ruumiline
-- 8. Veerusäilitav
-- 9. Veergude indeksid
-- 10. Välja arvatud veergudega indeksid

-- klastrites olev indeks määrab ära tabelis oleva füüsilise järjestuse
-- ja selle tulemusel saab tabelis olla inult üks klastris olev indeks

create table EmployeeCity
(
Id int primary key,
Name nvarchar(50),
Salary int,
Gender nvarchar(10),
City nvarchar(50)
)

exec sp_helpindex EmployeeCity

-- andmete õige järjestuse loovad klastris olevad indeksid ja kasutab selleks
-- põhjus, miks antud juhul kastuab Id'd, 

insert into EmployeeCity(Id, Name, Salary, Gender, City)
values 
(1, 'Sam', 2500, 'Male', 'London'),
(2, 'Pam', 6500, 'Female', 'Sydney'),
(3, 'John', 4500, 'Male', 'New York'),
(4, 'Sara', 5500, 'Female', 'Tokyo'),
(5, 'Todd', 3100, 'Male', 'Toronto')


-- klastris olevad indeksid dikteerivad säilitatud andmete järjestuse tabelis
-- ja seda saab klastrite puhul olla ainult üks

select * from EmployeeCity

create clustered index IX_EmployeeCity_Name
on EmployeeCity(Name)

-- Annab veateate, et tabelis saab olla ainult üks klastris olev indeks
-- kui soovid, uut indeksit luua, siis kustuta olemasolev

-- saame luua ainult ühe klastris oleva indeksi tabeli peale
-- klastris olev indeks on analoogne telefoni suunakoodile

-- loome composite indeksi
-- enne tuleb kõik teised klastris olevad indeksid ära kustutada

create clustered index IX_Employee_Gender_Salary
on EmployeeCity(Gender desc, Salary asc)

-- indeks on eemaldatud ja nüüd käivitame selle uuesti
select * from EmployeeCity

-- erinevused kahe indeksi vahel
-- 1. ainult üks klastris olev indeks saab olla tabeli peale,
-- mitte-klastris olevaid indekseid saab olla mitu
-- 2. klastris olevad indeksid on kiiremad kuna indeks peab tagasi viitama tabelile
-- juhul, kui selekteeritud veerg ei ole olemas indeksis
-- 3. Klastris olev indeks määratkbe ära tabeli ridade salvestusjärjestuse
-- ja ei nõua kettal lisa ruumi. Samas mitte klastis olevad indeksid on
-- salvestatud tabelist eraldi ja nõuab lisa ruumi.

create table EmployeeFirstName
(
	Id int primary key,
	FirstName nvarchar(50),
	LastName nvarchar(50),
	Salary int,
	Gender nvarchar(10),
	City nvarchar(50)
)

exec sp_helpindex EmployeeFirstName

-- ei saa sisestada kahte samasuguse Id väärtusega rida
insert into EmployeeFirstName values (1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values (2, 'John', 'Menco', 2500, 'Male', 'London')

--
drop index EmployeeFirstName.PK__Employee__3214EC07579CE7FA
-- kui käivitad ülevalpool oleva koodi, siis tuleb veateade
-- et sql server kastuab unique indeksit jõustamaks väärtuste unikaalsust
-- ja primaarvõtit
-- koodiga unikaalseid indekseid ei saa kustutada, aga käsitsi saab


-- sisestame uuesti kaks koodirida
insert into EmployeeFirstName values (1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values (1, 'John', 'Menco', 2500, 'Male', 'London')
-- unikaalset indeksid kasutatakse kindlustamaks
-- väärtuste unikaalsust (sh primaarvõtme oma)
-- mõlemat tüüpi indeksid saavad olla unikaalsed

-- lisame piirangu, mis nõua, et veerus ei oleks dublikaate
-- aga selles veerus on ja siis ei saa seda rakendada.
alter table EmployeeFirstName
add constraint UQ_EmployeeFirstName_City
unique nonclustered(City)

select * from EmployeeFirstName

delete EmployeeFirstName
where Id = 1

insert into EmployeeFirstName values(3, 'John', 'Menco', 3500, 'Male', 'Berlin')



exec sp_helpconstraint EmployeeFirstName
-- 1. Vaikimisi primaarivõti loob unikalse klastris oleva indeksi, samas unikaalne piirang
-- loob unikaalse mitte-klastris oleva indeksi
-- 2. Unkaalset indeksit või piirangut ei saa luua olemasolevasse tabelisse, kui tabel
-- juba siasldab väärtusi võtmeveerus
-- 3. Vaikimisi korduvaid väärtuseid ei ole veerus lubatud,
-- kui peaks olema unikaalne indeks või piirang, Nt, kui tahad sisestada 10 rida andmeid,
-- millest 5 sisaldavad korduvaid andmeid, siis kõik 10 lükatakse tagasi. Kui soovin ainult 5
-- rea tagasi lükkamist ja ülejäänud 5 rea sisestamist, siis elleks kasutatakse IGNORE_DUP_KEY


create unique index IX_EmployeeFirstName
on EmployeeFirstName(City)
with ignore_dup_key

insert into EmployeeFirstName values(3, 'John', 'Menco', 3512, 'Male', 'Madrid')
insert into EmployeeFirstName values(3, 'John', 'Menco', 3523, 'Male', 'London1')
insert into EmployeeFirstName values(3, 'John', 'Menco', 3520, 'Male', 'London1')

select * from EmployeeFirstName

-- view
-- view on salvestatud SQL-i päring. Saab käsitleda ka virtuaalse tabelina.

select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

-- loome view
create view vEmployeesByDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

-- view päringu esile kutsumine

select * from vEmployeesByDepartment

-- view ei salvesta andmeid vaikimisi
-- seda tasub võtta, kui salvestatud virtuaalse tabelina

-- milleks vaja:
-- saab kasutada andmebaasi skeemi keerukuse lihtsustamiseks,
-- mitte IT-inimesele
-- piiratud ligipääs andmetele, ei näe kõiki veerge

-- teeme view, kus näeb ainult IT-töötajaid
create view vITEmployeesInDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id
where Department.DepartmentName = 'IT'
-- ülevalpool olevat päringut saab liigitada reataseme turvalisuse alla
-- tahan ainult näidata IT osakonna töötajaid








select * from vITEmployeesInDepartment

-- veeru taseme turvalisus
-- peale selecti määratled veergude näitamise ära

create view vITEmployeesInDepartmentSalaryNoShow
as
select FirstName, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id
where Department.DepartmentName = 'IT'

select * from vITEmployeesInDepartmentSalaryNoShow

drop view vITEmployeesInDepartment

-- saab kasutada koondandmete esitlemist ja üksikasjalikke andmeid
-- view, mis tagastab summeritud andmeid
create view vEmployeesCountByDepartment
as
select DepartmentName, count(Employees.Id) as TotalEmployees
from Employees
join Department
on Employees.DepartmentId = Department.Id
group by DepartmentName

select * from vEmployeesCountByDepartment

-- kui soovid vaadata view sisu
sp_helptext vEmployeesCountByDepartment
-- muuta saab alter käsuga 
-- kustutada saab drop käsuga

-- view, mida akasutame andmete uuendamiseks
create view vEmployeesDataExceptSalary
as
select Id, FirstName, Gender, DepartmentId
from Employees

-- kasutame seda view'd, et uuendada andmeid
-- muuta Id 2 all olev eesnimi Tom-ks

update vEmployeesDataExceptSalary set FirstName = 'Tom'
where Id = 2

select * from vEmployeesDataExceptSalary


--
alter view  vEmployeesDataExceptSalary
as 
select Id, FirstName, Gender, DepartmentId
from Employees

-- kustutame andmeid ja kasutame seda viewd: vEmployeesDataExceptSalary
delete from vEmployeesDataExceptSalary where Id = 2 

-- nüüd lisame andmeid

insert into vEmployeesDataExceptSalary (Id, Gender, DepartmentId, FirstName)
values(2, 'Female', 2, 'Pam')

drop vEmployeesDataExceptSalary


⠀⠀⠀⢀⣾⣷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠘⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠹⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠈⢻⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣆⠀⠀⠀⠀⠀⢀⣸⣶⣶⠶⠿⠟⠛⠛⠛⢿⣿⣇⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣿⣿⣆⣀⣤⡶⠿⠛⠉⠁⢹⣷⣤⠀⠀⠀⠀⠟⢱⡿⠛⢷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣹⣿⣿⡟⠁⠀⠀⠀⠀⠀⠘⠁⠀⠀⠀⠀⣀⣀⣀⣀⣠⣼⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⠟⠙⢿⣿⣄⠀⠀⠀⠀⠀⣦⠶⠞⠛⠛⠛⠉⠉⢉⣿⠏⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡿⠁⠀⠀⠈⠻⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⣴⡟⠀⠀⠀⠀⠀⠀⢿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢀⣼⠏⠀⠀⠀⠀⠀⠀⢠⣿⠻⣿⣷⠄⠀⠀⠀⠀⠀⠀⠀⢰⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢀⣾⠋⠀⠀⠀⠀⠀⠀⢠⣿⠃⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⣾⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⣾⠃⠀⠀⠀⠀⠀⠀⢠⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣼⠇⠀⠀⠀⠀⠀⠀⣠⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢨⡗⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣤⡴⠴⠶⠒⠒⠒⠶⠶⠶⠤⣤⣄⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢰⡟⠀⠀⠀⠀⠀⢀⣼⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡶⠛⠉⣹⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠳⢦⣄⡀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣿⠁⠀⠀⠀⠀⣠⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠿⣤⣴⣤⣉⣀⣀⣀⣀⡀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⢷⣄⠀⠀⠀⠀
⠀⠀⢰⡟⠀⠀⠀⢀⣴⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡗⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⣹⡟⠉⠉⠉⠉⠉⠙⠛⠛⠃⠀⠀⠀⠀⠀⠀⠀ ⠀⠹⣦⠀⠀⠀
⠀⠀⣸⡇⠀⠀⢠⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠙⣷⡀⠀
⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⢸⡧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ⠹⣇⠀
⠀⢸⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠃⠀⢠⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⡤⠶⠒⠀⠀  ⢻⡇
⠀⣼⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡟⠀⠀⠀⠉⠙⠲⢦⣄⣀⣀⣀⡤⠶⠶⠛⠉⠁⠀⠀⠀⠀⠀⠀ ⠸⡇
⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣷⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠰⡇
⢰⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⢸⡗
⣾⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ⢼⡇


-- indekseeritud view
-- MS SQL's on indekseeritud view nime all ja 
-- Oracle-s materjaliseeritud view

create table product
(
Id int primary key,
Name nvarchar(20),
UnitPrice int
)

insert into Product values (1, 'Books', 20)
insert into Product values (2, 'Pens', 14)
insert into Product values (3, 'Pencils', 11)
insert into Product values (4, 'Clips', 10)

create table ProductSales
(
Id int,
QuantitySold int
)

insert into ProductSales values
(1, 10),
(3, 23),
(4, 21),
(2, 12),
(1, 13),
(3, 12),
(4, 13),
(1, 11),
(2, 12),
(1, 14)

-- loome view, mis annab meile veerud TotalSales ja TotalTransactions

create view vTotalSalesByProduct
with schemabinding
as 
select Name,
sum(isnull((QuantitySold * UnitPrice), 0)) as TotalSales,
count_big(*) as TotalTransactions
from dbo.ProductSales
join dbo.Product
on dbo.Product.Id = ProductSales.Id
group by Name

-- kui soovid luua indeksi view sisse, siis peab järgima teatud reegleid
-- 1. view tuleb luua koos schemabinding-ga
-- 2. kui lisafunktsioon select list viitab väljendile ja selle tulemuseks
-- võib olla NULL, siis asendusväärtus peaks olema täpsustatud.
-- Antud juhul kasutasime ISNULL funktsiooni asnedamaks NULL väärtust
-- 3. kui GroupBy on täpsustatud, siis view select list peab 
-- sisaldama COUNT_BIG(*) väljendit
-- 4. Baastabelis peaksid view-d olema viidatud kaheosalise nimega
-- e antud juhul dbo.ProductSales.

select * from vTotalSalesByProduct

create unique clustered index UIX_TotalSalesByProduct_Name
on vTotalSalesByProduct(Name)






⠀⠀⠀⠀⠀⠀⠀⠔⢻⡀⠀⠀⢀⣀⡿⡂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠈⢨⡧⣀⣤⣤⣿⣿⣷⣅⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢠⠁⢾⢟⡟⢻⠻⢳⠚⢯⢆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠉⠉⠀⠀⠀⠉⠀⠀⠁⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢀⢄⠀⠐⢤⣶⣶⣲⣦⣵⣈⠹⢋⡷⣿⣾⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⡎⡜⡀⢈⣽⢾⡻⡿⣿⣦⢹⣼⡿⢱⣿⣿⡿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⡤⡰⢧⠨⡜⢖⢧⠹⣭⢎⡿⣽⢳⢯⣟⡷⣿⣿⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠸⠽⣬⡱⣷⣸⣉⠦⠝⣲⢯⡾⣯⢿⣾⡽⣿⡿⠷⣤⣆⣄⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⡮⠑⠌⢻⠿⣾⣿⣯⣉⣭⣿⣾⣿⣿⣿⣿⣿⡞⡵⢂⠏⠻⢿⣷⣄⠀⠀⠀⠀⠀
⠀⠀⠀⠰⢀⡉⡸⡀⠎⠈⠹⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢷⣏⢹⡷⠎⣿⣷⡆⠀⠀⠀⠀
⠀⠀⠀⡈⢆⣱⢧⡽⣆⠂⠀⠀⠀⠀⠉⠉⠉⠙⠹⡋⠻⠹⠷⠪⡑⠹⢮⡘⣿⣯⡀⠀⠀⠀
⠀⠀⢠⠐⡤⢐⣿⣿⣿⡎⠀⠀⠀⠀⠀⠀⠀⠀⠀⢂⠀⢍⠃⡳⣀⡼⣱⢽⣻⣿⣗⠄⠀⠀
⠀⡘⡠⣘⠦⣿⣾⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠴⢑⣸⡷⢟⣺⣿⣿⣿⣿⠻⣷⡀⠀
⠀⠔⠤⣕⣿⢿⣿⣿⣿⡇⡀⠀⠀⠀⠀⠀⢀⢀⣤⣰⣽⠞⠁⠊⡁⠂⢍⣻⣿⣿⡦⢈⡗⡄
⡘⠘⡘⢬⣺⣿⣿⣿⣿⣉⣄⣢⣤⣑⣰⣼⣯⣿⡿⢏⠁⠂⠀⠄⠀⠁⣂⠲⣹⣿⣯⣿⣿⡡
⣧⡓⣼⢳⣭⢷⢫⢏⠻⢟⡛⢟⡿⢿⠿⣟⠻⢏⡱⢠⠁⠀⠀⠀⠀⠁⢂⡙⢧⣹⣿⠟⠁⠀
⠑⣿⣾⣯⣿⣯⣿⣟⣶⣀⠉⢯⣔⢂⣿⣤⣏⣒⡄⢂⠀⠀⠀⠀⠀⢀⠂⡹⣆⠇⡄⠀⠀⠀
⠀⠀⠉⠻⢻⣿⣿⣿⣿⣷⣷⣼⣿⣿⣿⣿⡷⣆⡻⠞⡠⠀⢀⠀⡈⠄⣈⠳⣬⣓⡇⠀⠀⠀
⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⡿⢟⣙⠲⢬⢇⠣⢳⡍⠀⡀⡀⢆⢄⢳⡳⢎⠀⠀⠀⠀

-- view piirangud

create view vEmployeeDetails
@Gender nvarchar(20)
as
select Id, FirstName, Gender, DepartmentId
from Employees
where Gender = @Gender
-- view'sse ei saa kaasa panna parameetred e antud juhul Gender

-- tuleb teha funktsioon, kus parameetriks on gender
create function fnEmployeeDetails(@Gender nvarchar(20))
returns table
as
	return (select Id, FirstName, Gender, DepartmentId from Employees where Gender = @Gender)

-- funktsiooni esile kutsumine koos parameetritega
select * from fnEmployeeDetails('Male')

-- order by kasutamine
create view vEmployeeDetailsSorted
as
select Id, FirstName, Gender, DepartmentId
from Employees
order by Id
-- order by'd ei saa kasutada

-- temp table kasutamine

create table ##TestTempTable(Id int, FirstName nvarchar(20), Gender nvarchar(10))

drop table ##TestTempTable 

insert into ##TestTempTable values(101, 'Martin', 'Male')
insert into ##TestTempTable values(102, 'Joe', 'Female')
insert into ##TestTempTable values(103, 'Pam', 'Female')
insert into ##TestTempTable values(104, 'James', 'Male')


select * from ##TestTempTable

create view vOnTempTable
as
select Id, FirstName, Gender
from ##TestTempTable
-- temp table's ei saa kasutada view'd

-- TRIGGER
-- kokku on kolme tüüpi triggereid: DML, DDL JA LOGON

-- trigger on stored procedure eriliik, mis automaatselt käivitub, kui mingi tegevs
-- peaks andmebaasis aset leidma

-- DML - data manipulation language
-- DML'i põhilised käsklused: insert, update ja delete

-- DML triggereid saab klasifitseerida kahte tüüpi
-- 1. After trigger (kutsutakse ka FOR triggeriks)
-- 2. Instead of trigger (selmet trigger e selle asmel trigger)

-- after trigger käivitud peale sündmust, kui kuskil on tehtud insert
-- update and delete

-- loome uue tabeli
create table EmployeeAudit
(
Id int identity(1, 1) primary key,
AuditData nvarchar(1000),
)

-- peale iga töötaja sisestamist tahame teada saada töötaja Id-d,
-- päeva ning aega (millal sisestati)
-- kõik andmed tulevad EmployeeAudit tabelisse

create trigger trEmployeeForInsert
on Employees
for insert
as begin
declare @Id int
select @Id = Id from inserted
insert into EmployeeAudit
values ('New employee with Id = ' + cast(@Id as nvarchar(5)) + ' is added at ' 
+ cast(getdate() as nvarchar(20)))
end

select * from Employees 

insert into Employees values(11,'Bob', NULL , 'Marley', 'Male', 3000, 1, 3, 'bob@marley.com')

select * from EmployeeAudit

-- update trigger

alter trigger trEmployeeForUpdate
on Employees
for update
as begin
	--muutujate deklareerimine
	declare @Id int
	declare @OldGender nvarchar(20), @NewGender nvarchar(20)
	declare @OldSalary int, @NewSalary int
	declare @OldDepartmentId int, @NewDepartmentId int
	declare @OldManagerId int, @NewManagerId int
	declare @OldFirstName nvarchar(20), @NewFirstName nvarchar(20)
	declare @OldMiddleName nvarchar(20), @NewMiddleName nvarchar(20)
	declare @OldLastName nvarchar(20), @NewLastName nvarchar(20)
	declare @OldEmail nvarchar(20), @NewEmail nvarchar(20)

	---muutuja, kuhu läheb lõpptekst
	declare @AuditString nvarchar(1000)

	--laeb kõik uuendatud andmed temp table alla
	select * into #TempTable
	from inserted

	--käib läbi kõik andmed temp table-s
	while(exists(select Id from #TempTable))
	begin
		set @AuditString = ''
		--selekteerib esimese rea andmed temp tabel-st
		select top 1 @Id = Id, @NewGender = Gender,
		@NewSalary = Salary, @NewDepartmentId = DepartmentId,
		@NewManagerId = ManagerId, @NewFirstName = FirstName,
		@NewMiddleName = MiddleName, @NewLastName = LastName,
		@NewEmail = Email
		from #TempTable
		-- võtab vanad andmed kustutatud tabelist
		select @OldGender = Gender,
		@OldSalary = Salary, @OldDepartmentId = DepartmentId,
		@OldManagerId = ManagerId, @OldFirstName = FirstName,
		@OldMiddleName = MiddleName, @OldLastName = LastName,
		@OldEmail = Email
		from deleted where Id = @Id

		--loob auditi stringi dünaamiliselt
		set @AuditString = 'Employee with Id = ' + cast(@Id as nvarchar(4)) + ' changed '
		if(@OldGender <> @NewGender)
			set @AuditString = @AuditString + ', Gender from ' + @OldGender + ' to ' +
			@NewGender

		if(@OldSalary <> @NewSalary)
			set @AuditString = @AuditString + ', Salary from ' + cast(@OldSalary as nvarchar(20)) 
			+ ' to ' + cast(@NewSalary as nvarchar(10))

		if(@OldDepartmentId <> @NewDepartmentId)
			set @AuditString = @AuditString + ', DepartmentId from ' + cast(@OldDepartmentId as nvarchar(20)) 
			+ ' to ' + cast(@NewDepartmentId as nvarchar(10))

		if(@OldManagerId <> @NewManagerId)
			set @AuditString = @AuditString + ', Manager from ' + cast(@OldManagerId as nvarchar(20)) 
			+ ' to ' + cast(@NewManagerId as nvarchar(10))

		if(@OldFirstName <> @NewFirstName)
			set @AuditString = @AuditString + ', Firstname from ' + @OldFirstName + ' to ' +
			@NewFirstName

		if(@OldMiddleName <> @NewMiddleName)
			set @AuditString = @AuditString + ', Middlename from ' + @OldMiddleName + ' to ' +
			@NewMiddleName

		if(@OldLastName <> @NewLastName)
			set @AuditString = @AuditString + ', Lastname from ' + @OldLastName + ' to ' +
			@NewLastName

		if(@OldEmail <> @NewEmail)
			set @AuditString = @AuditString + ', Email from ' + @OldEmail + ' to ' +
			@NewEmail

		insert into dbo.EmployeeAudit values (@AuditString)
		-- kustutab temp table-st rea, et saaksime liikuda uue rea juurde
		delete from #TempTable where Id = @Id
	end
end

update Employees set FirstName = 'test890', Salary = 4120, MiddleName = 'testXXXXXXX'
where Id = 10

select * from Employees
select * from EmployeeAudit

update Employees set FirstName = 'test153', Salary = 4100, MiddleName = 'test556'
where Id = 11

select * from Employees
select * from EmployeeAudit

-- instead of trigger
create table Employee
(
Id int primary key,
Name nvarchar(30),
Gender nvarchar(10),
DepartmentId int
)

insert into Employee values 
(1, 'John', 'Male', 3),
(2, 'Mike', 'Male', 2),
(3, 'Pam', 'Female', 1),
(4, 'Todd', 'Male', 4),
(5, 'Sara', 'Female', 1),
(6, 'Ben', 'Male', 3)

-- teeme view
create view vEmployeeDetails
as
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Department
on Employee.DepartmentId = Department.Id


select * from vEmployeeDetails

insert into vEmployeeDetails values
(7, 'Valarie', 'Female', 'IT')
-- tuleb veateade
-- vaatame kuidas saab lahendada probleemi "instead triggeriga"

create trigger tr_vEmployeeDetails_InsteadOfInsert
on vEmployeeDetails
instead of insert
as begin
	declare @DeptId int

	select @DeptId = dbo.Department.id
	from Department
	join inserted
	on inserted.DepartmentName = Department.DepartmentName

	if (@DeptId is null)
		begin
		raiserror('Invalid department name. Statement terminated', 16, 1)
		return
	end
	
	insert into dbo.Employee(Id, Name, Gender, DepartmentId)
	select Id, Name, Gender, @DeptId
	from inserted
end

-- raiseerror funktsioon
-- selle eesmärk on tuua välja veateade, kui DepartmentName ei ole väärtust
-- ja ei klapi uue sisestatud väärtusega.
-- Esimene parameeter on veateaete sisu, teine on veataseme nr
-- (nr 16 tähendab üldiseid vigu),
-- kolmas on olek

select * from Employee
delete from Employee where Id = 6

update vEmployeeDetails
set Name = 'Johnny', DepartmentName = 'IT'
where Id = 1
-- ei saa uuendada andmeid, sest mitu tabelit on sellest mõjutatud

update vEmployeeDetails
set DepartmentName = 'IT'
where Id = 1
-- saab uuendada kuna ainult ühes tabelis tahame muuta andmeid

select * from vEmployeeDetails

create trigger tr_vEmployee_InsteadOfUpdate
on vEmployeeDetails
instead of update
as begin
	
	if (update(Id))
	begin 
		raiserror('Id cannot be changed', 16, 1)
		return
	end

	if(update(DepartmentName))
	begin 
		declare @DeptId int
		select @DeptId = Department.Id
		from Department
		join inserted
		on inserted.DepartmentName = Department.DepartmentName

		if (@DeptId is null)
		begin 
			raiserror('Invalid Department Name', 16, 1)
			return
		end

		update Employee  set DepartmentId = @DeptId
		from inserted
		join Employee on Employee.Id = inserted.id

	end

	if (update(Gender))
	begin 
		update Employee set Gender = inserted.Gender
		from inserted
		join Employee
		on Employee.Id = inserted.id
	end

	if (update(Name))
	begin 
		update Employee set Name = inserted.Name
		from inserted
		join Employee
		on Employee.Id = inserted.id
	end
end


	


	
██╗░░░░░░█████╗░██╗░░░██╗███████╗██╗░░░░░███████╗░██████╗░██████╗
██║░░░░░██╔══██╗██║░░░██║██╔════╝██║░░░░░██╔════╝██╔════╝██╔════╝
██║░░░░░██║░░██║╚██╗░██╔╝█████╗░░██║░░░░░█████╗░░╚█████╗░╚█████╗░
██║░░░░░██║░░██║░╚████╔╝░██╔══╝░░██║░░░░░██╔══╝░░░╚═══██╗░╚═══██╗
███████╗╚█████╔╝░░╚██╔╝░░███████╗███████╗███████╗██████╔╝██████╔╝
╚══════╝░╚════╝░░░░╚═╝░░░╚══════╝╚══════╝╚══════╝╚═════╝░╚═════╝░


-- Nüüd saame mitmes tabelis korraga muuta andmeid
update Employee set Name = 'John123', Gender = 'Male', DepartmentId = 3
where Id = 1

select * from vEmployeeDetails

--tund 11 28.04.2025
-- delete trigger

create view vEmployeeCount
as
select DepartmentId, DepartmentName, count(*) as TotalEmployees
from Employee
join Department
on Employee.DepartmentId = Department.Id
group by DepartmentName, DepartmentId

select * from vEmployeeCount

---näitab ära osakonnad, kus on töötajaid 2tk või rohkem
select  DepartmentName, TotalEmployees from vEmployeeCount
where TotalEmployees >= 2

select DepartmentName, DepartmentId, count(*) as TotalEmployees
into #TempEmployeeCount
from Employee
join Department
on Employee.DepartmentId = Department.Id
group by DepartmentName, DepartmentId

select * from #TempEmployeeCount

select  DepartmentName, TotalEmployees 
from #TempEmployeeCount
where TotalEmployees >= 2

create view vEmployeeDetails
as
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Department
on Employee.DepartmentId = Department.Id


-- kustutada 

create trigger trEmployeeDetails_InsteadOfDelete
on vEmployeeDetails
instead of delete
as begin
delete Employee
from Employee
join deleted
on Employee.Id = deleted.Id
end

delete from vEmployeeDetails where Id = 2

---
select * from Employee

-- p'ritud tabelid ja CTE
-- CTE tähendab common table expression

insert into Employee values(2, 'Mike', 'Male',2)
--CTE
--- CTE-d võivad sarnaneda temp table-ga
-- sarnane päritud tabelile ja ei ole salvestatud objektina
-- ning kestab päringu ulatuses

with EmployeeCount(DepartmentName, DepartmentId, TotalEmployees)
as
	(
	select DepartmentName, DepartmentId, count(*) as TotalEmployees
	from Employee
	join Department
	on Employee.DepartmentId = Department.Id
	group by DepartmentName, DepartmentId
	)
select DepartmentName, TotalEmployees
from EmployeeCount
where TotalEmployees >= 2

--mitu CTE-d järjest
with EmployeeCountBy_Payroll_IT_Dept(DepartmentName, Total)
as
(
	select DepartmentName, count(Employee.Id) as TotalEmployees
	from Employee
	join Department
	on Employee.DepartmentId = Department.Id
	where DepartmentName in('Payroll', 'IT')
	group by DepartmentName
),
--peale koma panemist saad uue CTE juurde kirjutada
EmployeeCountBy_HR_Admin_Dept(DepartmentName, Total)
as
(
	select DepartmentName, count(Employee.Id) as TotalEmployees
	from Employee
	join Department
	on Employee.DepartmentId = Department.Id
	group by DepartmentName
)
--kui on kaks CTE-d, siis unioni abil ühendada päringud
select * from EmployeeCountBy_Payroll_IT_Dept
union
select * from EmployeeCountBy_HR_Admin_Dept

---
with EmployeeCount(DepartmentId, TotalEmployees)
as
	(
	select DepartmentId, count(*) as TotalEmployees
	from Employee
	group by DepartmentId
	)
---select 'Hello'
--- peale CTE-d peab kohe tulema käsklus SELECT, INSERT, UPDATE või DELETE
--- kui proovid midagi muud, siis tuleb veateade
select DepartmentName, TotalEmployees
from Department
join EmployeeCount
on Department.Id = EmployeeCount.DepartmentId
order by TotalEmployees


-- uuendamine CTE-s
-- loome lihtsa CTE
with Employees_Name_Gender
as
(
	select Id, Name, Gender from Employee
)

select * from Employees_Name_Gender

-- uuendame andmeid läbi CTE
-- kasutame CTEd: Employees Name Gender
-- muudame Id 1 all ovela isiku sugu Female
with Employees_Name_Gender
as
(
	select Id, Name, Gender from Employee
)

update Employees_Name_Gender set Gender = 'Male' where Id = 1

select * from Employee

-- kasutame joini CTE tegemisel

with EmployeesByDepartment
as
(
	select Employee.Id, Name, Gender, DepartmentName
	from Employee
	join Department
	on Department.Id = Employee.DepartmentId
)

select * from EmployeesByDepartment

-- kasutame joini ja muudame ühes tabelis andmeid

with EmployeesByDepartment
as
(
	select Employee.Id, Name, Gender, DepartmentName
	from Employee
	join Department
	on Department.Id = Employee.DepartmentId
)

update EmployeesByDepartment set Gender = 'Female' where Id = 1

-- kasutame joini ja muudame ühes tabelis andmeid
with EmployeesByDepartment
as
(
	select Employee.Id, Name, Gender, DepartmentName
	from Employee
	join Department
	on Department.Id = Employee.DepartmentId
)

update Employees_Name_Gender set Gender = 'Male' where Id = 1

-- ei luba mitmes tabelis andmeid korraga muuta

with EmployeesByDepartment
as
(
	select Employee.Id, Name, Gender, DepartmentName
	from Employee
	join Department
	on Department.Id = Employee.DepartmentId
)

update EmplyoeesByDepartment set DepartmentName = 'HR'
where Id = 1

-- kokkuvõte CTE-st
-- 1. kui CTE baseerub ühel tabelil, siis uuendus töötab
-- 2. kui CTE baseerub mitmel tabelil, siis tuleb veateade
-- 3. kui CTE baseerub mitmel tabelil ja tahame muuta ianult ühte tabelit, siis
-- uuendus saab tehtud


-- korduv CTE
-- CTE, mis viitab iseendale, kutsutakse korduvaks CTE-ks
-- kui tahad andmeid näidata hierarhiliselt

select * from Employee

-- kustutame kõik andmed tabelist Employee

truncate table Employee

-- kustutada ära veerg nimega gender

alter table Employee
drop column Gender


insert into Employee values
(1, 'Tom', 2),
(2, 'Josh', NULL),
(3, 'Mike', 2),
(4, 'John', 3),
(5, 'Pam', 1),
(6, 'Mary', 3),
(7, 'James', 1),
(8, 'Sam', 5),
(9, 'Simon', 1)


-- uks võimalus on teha self join
-- ja kuvada NULL veeru asemel Super Boss


select Emp.Name as [Employee Name],
isnull(Manager.Name, 'Super Boss') as [Manager Name]
from dbo.Employee Emp
left join Employee Manager
on Emp.ManagerId = Manager.Id


-- muudke DepartmentId veerg ManagerId nimeks
exec sp_rename 'Employee.DepartmentId', 'ManagerId', 'COLUMN';

with EmployeesCTE(Id, Name, ManagerId, [Level])
as
(
	select Employee.Id, Name, ManagerId, 1
	from Employee
	where ManagerId is null
	
	union all

	select Employee.Id, Employee.Name,
	Employee.ManagerId, EmployeesCTE.[Level] + 1
	from Employee
	join EmployeesCTE
	on Employee.ManagerId = EmployeesCTE.Id
)

select EmpCTE.Name as Employee, isnull(MgrCTE.Name, 'SuperBoss') as Manager,
EmpCTE.[Level]
from EmployeesCTE EmpCTE
left join EmployeesCTE MgrCTE
on EmpCTE.ManagerId = MgrCTE.Id

-- PIVOT

create table ProductSales
(
SalesAgent nvarchar(50),
SalesCountry nvarchar(50),
SalesAmount int
)

drop table ProductsSales
drop view vTotalSalesByProduct

insert into ProductSales values
('Tom', 'UK', 200),
('John', 'US', 180),
('John', 'UK', 250),
('David', 'India', 450),
('Tom', 'India', 350),
('David', 'US', 200),
('Tom', 'US', 130),
('John', 'India', 540),
('John', 'UK', 120),
('David', 'UK', 220),
('John', 'UK', 420),
('David', 'US', 320),
('Tom', 'US', 340),
('Tom', 'UK', 660),
('John', 'India', 430),
('David', 'India', 230),
('David', 'India', 280),
('Tom', 'UK', 480),
('John', 'UK', 360),
('David', 'UK', 140)

select * from ProductSales

select SalesCountry, SalesAgent, SUM(SalesAmount) as TotalSales 
from ProductSales
group by SalesCountry, SalesAgent
order by SalesCountry

-- pivot näide
select SalesAgent, India US, UK
from ProductSales
pivot 
(
sum(SalesAmount) for SalesCountry in ([India], [US], [UK])
)
as PivotTable

-- päring muudab unikaalsete veergude väärtust (India, US ja UK) SalesCountry veerus
-- omaette veergudeks koos veergude SalesAmount liitmisega.

create table ProductSalesWithId
(
Id int primary key,
SalesAgent nvarchar(50),
SalesCountry nvarchar(50),
SalesAmount int
)
insert into ProductSalesWithId values
(1, 'Tom', 'UK', 200),
(2, 'John', 'US', 180),
(3, 'John', 'UK', 250),
(4, 'David', 'India', 450),
(5, 'Tom', 'India', 350),
(6, 'David', 'US', 200),
(7, 'Tom', 'US', 130),
(8, 'John', 'India', 540),
(9, 'John', 'UK', 120),
(10, 'David', 'UK', 220),
(11, 'John', 'UK', 420),
(12, 'David', 'US', 320),
(13, 'Tom', 'US', 340),
(14, 'Tom', 'UK', 660),
(15, 'John', 'India', 430),
(16, 'David', 'India', 230),
(17, 'David', 'India', 280),
(18, 'Tom', 'UK', 480),
(19, 'John', 'UK', 360),
(20, 'David', 'UK', 140)