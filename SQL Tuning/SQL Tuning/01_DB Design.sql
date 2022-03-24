/*
Normalform
1. jede Zelle hat nur einen Wert
2. jeder DS hat einen eindeutigen Wert .. PK
3. keine Abhängigkeit zw. den nicht PK Spalten geben
4.5  für Irre



Redundanz  = schnell

Generalisierung  


PK  --Beziehung--->FK 

Zweck des PK: für Beziehungen
Beziehung: 

Datentypen


Kundentab  1 MIO

Bestelltabelle  2 MIO - + RngSumme

Positionstabelle  4 MIO 


Redundante Systeme in SQL Server

#tabellen

SSAS SQL Server AnalysisServer  Datewarehouse Cube

*/

use Northwind


delete from customers where customerid = 'ALFKI'

sp_help 'Customers'

select * from INFORMATION_SCHEMA.Columns---


/*
Seiten und Blöcke

1 Seite hat immer 8192 bytes
Nutzlast max 8072 bytes
1 DS max 8060 bytes bei fixen Längen
1 DS muss in Seite passen. 
Leerer Raum wird nicht weiterverwendet
Seiten kommen 1:1 in RAM





*/

create database Testdb;
GO

use Testdb;
GO

create table t1 (id int identity, spx char(4100));
GO

insert into t1
select 'XY'
GO 20000 --10 Sek

--Wie groß ist die Tabelle t1?
--sollte 4100*20000 = 80MB  hat aber 160MB

set statistics io , time on 
--Datenträgerzugriffe ,Dauer in ms und CPU  Zeit in ms

select * from t1 where id = 10 --0 Sek
--CPU-Zeit = 16 ms, verstrichene Zeit = 20 ms.
--logische Lesevorgänge: 20000 = Seiten  ???


1 DS mit 4100 Zeichen
1 MIO DS

--> Seite: pro Seite nur 1 DS , weil 1 DS mit 4100 51%
--> 1 MIO Seiten-> 8 GB

--Seiten werden 1:1 in RAM geschoben
---> Seiten müssen reduziert werden

-----------------durch : bessere Datentypen od Redesign

--Tabelle mit 4000 bytes pro Ds + Tabelle mit 100 pro Tabellen

--1 MIO * (2DS/Seite)--> 500000 Seiten --> 4 GB
--1 MIO (80DS/seiten) --> 12500 Seiten --> 110 MB
--woher weiss ich das denn wie groß der Füllfaktor ist

set statistics io , time off

create table t2 ( id int, sp1 varchar(4100), sp2 char(4100))


dbcc showcontig('t1')
--- Gescannte Seiten.............................: 2000000
--- Mittlere Seitendichte (voll).....................: 50.79%

dbcc showcontig('customers')



--DB Design NOrthwind

-- Customerid = textgewusel
--Nvarchar = Unicode

--OTTO
--char(50)...............:   50
--varchar(50).........:     4
--nchar(50)............:    50*2
--nvarchar(50)......:      4*2 
--text()..depricated seit 2005


decimal(10,2) 

--datetime (ms)

use northwind

select * from orders

--Suche alle Bestellungen heraus, die aus dem Jahr 1997 --orderdate

--408
select * from orders where year(orderdate) = 1997 --langsam und richtig

--408
select * from orders where orderdate between '1.1.1997 00:00:00.000' and '31.12.1997 23:59:59'

select * from orders where orderdate between '1.1.1997' and '31.12.1997 23:59:59.997' --schnell und falsch



select * from orders





select country, customerid from customers