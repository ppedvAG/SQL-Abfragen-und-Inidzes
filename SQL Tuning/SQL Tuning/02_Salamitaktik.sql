/*
Dateigruppen
[PRIMARY]-- mdf
 weiter Datendateien : .ndf

 neue DGruppe: STAMM  ---stammdaten.ndf


*/

create table xyz (id)  --mdf

create table xyz (id) on [PRIMARY]

create table xyz (id) on STAMM

USE [master]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [HOT]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'NwindHotData', FILENAME = N'D:\_SQLDB\NwindHotData.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [HOT]
GO


create table test1 (id int) on HOT

---wie kann ich best Tabellen auf andere Dgruppen schieben?


--Tabelle Umsatz : wird jeden Tag größer!!

--kleiner machen--->
--splitten in viele kleine Tabellen

--> U2022 U2021 U2020 U2019

select * from umsatz where....

--Sicht

create table u2022 (id int identity, jahr int, spx int)
create table u2021 (id int identity, jahr int, spx int)
create table u2020 (id int identity, jahr int, spx int)
create table u2019 (id int identity, jahr int, spx int)


create view Umsatz
as
select * from u2022
UNION ALL --keine Suche nach doppelte Werten , wenn es die nicht geben kann
select * from u2021
UNION ALL
select * from u2020
UNION ALL
select * from u2019



select * from umsatz where jahr = 2021

--mit Check Constraint
ALTER TABLE dbo.u2019 ADD CONSTRAINT
	CK_u2019 CHECK (jahr=2019)

	--nur noch 3 Tabellen

	--Nachteile: juppp: 
	--INS UP DEL ..geht , aber nur dann wenn:
	--kein identity
	--PK,der über alle Tabelle eindeutig wird

	--NULL oder NOT NULL


	--Partitionierung

	--Part Funktion
	--        100                200
	---------]---------------]----------
	--   1                 2               3

	-->  f(117)--- 2

	--Tabelle auf Part Schema
	--Schema weist mit Hilfe der f() die entpsrechende Dgruppe zu



	use northwind

	create partition function fZahl (int)
	as
	RANGE LEFT FOR VALUES (100,200)

	select $partition.fzahl(117) -->2


	--- 4 Dgruppen: bis100 bis200 rest bis5000

	create partition scheme schZahl
	as
	partition fzahl to (bis100, bis200, rest)
	---                            1           2         3

	create table ptab (id int identity,
									nummer int,
									spx char(4100)) ON schZahl(nummer)



declare @i as int = 1

begin tran
while @i <=20000
	begin
			--begin tran  --neeeeeinnn!!
			insert into ptab (nummer, spx) values (@i, 'XY')
			set @i+=1 --  set @i=+1 !!!
	end
commit


set statistics io , time on

select * from ptab where nummer = 117 
--100 Seiten ... 0 ms

select * from ptab where id = 117
--20000 Seiten ... 31 ms / 16ms

--blöde Situation: wir brauchen oft Werte aus dem großen Bereich:

--Neue Grenze einführen:  5000

--Tabelle, Dgruppen, F(), Schema

--Tabelle ..never!!
--Druppe: neue Gruppe
--F() ändern
--Schema: neue Dgruppe angeben


	
select * from ptab where nummer = 1117

alter partition scheme schZahl next used bis5000

select $partition.fzahl(nummer),	
			min(nummer), 
			max(nummer), 
			count(*)
from ptab group by $partition.fzahl(nummer)

----100----------200----------------5000--------------------
alter partition function fzahl() split range(5000)


select * from ptab where nummer = 1117


---Grenze entfernen... 100

--Tabelle: never
--f(): jupp
--scheme: nope
--Drguppen: nö

alter partition function fzahl() merge range(100)


USE [Northwind]
GO


CREATE PARTITION FUNCTION [fZahl](int) AS
RANGE LEFT FOR VALUES (200, 5000)
GO

CREATE PARTITION SCHEME [schZahl] AS 
PARTITION [fZahl] TO ([bis200], [bis5000], [rest])
GO

select * from ptab where id = 117

--Alte Socken archivieren


create table archiv (id int not null, nummer int, spx char(4100))
ON bis200

--muss sein: partion muss auf gleicher Dgruppe wie Archiv sein
alter table ptab switch partition 1 to archiv

select * from archiv

select * from ptab








