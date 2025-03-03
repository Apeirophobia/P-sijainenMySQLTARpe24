print('HELLO WORLD')
-- comment

-- loome db

create database TARpe24SQL

-- db valimine
use TARpe24SQL

-- db kustutamine

-- drop database TARpe24SQL

-- tabeli loomine
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null,
)

-- andmete sisestamine

insert into Gender (Id, Gender)
values (2, 'Male')
insert into Gender (Id, Gender)
values (1, 'Female')
insert into Gender (Id, Gender)
values (3, 'Unknown')

-- vaatame tabeli sisu
select * from Gender

-- loome tabeli Person
create table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)

-- andmete sisestamine

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

-- soovime vaadata Person tabeli andmeid

select * from Person

print('no one cares')

-- võõrvõtme ühenduse loomine kahe tabeli vahel

alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

-- kui sisestad uue rea andmeid ja ei ole sisestanud GenderId alla väärtust,
-- siis see automaatselt ssestab sellele reale väärtuse 3 e nagu meil
-- on unknown

alter table Person
add constraint DF_Persons_GenderId
default 3 for GenderId

--
insert into Person (Id, Name, Email)
values (10, 'Kalevipoeg', 'k@k.com')

-- piirangu kustutamine


alter table Person
drop constraint DF_Persons_GenderId

-- lisame uue veeru
alter table Person
add Age nvarchar(10)

-- lisame nr piirangu vanuse sisestamisel
alter table Person
add constraint  CK_Person_Age check (Age > 0 and Age < 155)

--kustutame rea
delete from Person where Id = 10

select * from Person

-- kuidas uuendada andmeid 
update Person
set Age = 50
where Id = 4

alter table Person
add City nvarchar(50)

-- kõik, kes elavad Gothami linnas
select * from Person where City = 'Gotham'

-- kõik, kes ei ela Gothamis

select * from Person where City != 'Gotham'

-- variant nr 2
select * from Person where City <> 'Gotham'

-- Näitab teatud vanusega inimesi

select * from Person where Age = 100 or Age = 35 or Age = 25 or Age = 27
select * from Person where Age in (100, 35, 25, 27)

-- näitab teatud vanusevahemikus olevaid inimesi 
select * from Person where Age between 22 and 50

-- wildcard e näitab kõik a-tähega linnad
select * from Person where City like '%a%'
-- kõik emailid, kus on @-märk emailis

select Email from Person where Email like '%@%'

-- näitab kõiki, kellel ei ole @-märki emailis
select * from Person where Email not like '%@%'

