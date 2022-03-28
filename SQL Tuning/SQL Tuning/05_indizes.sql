/*


HEAP = TABELLE in unsortierter Form


NON CLUSTERED IX
Kopie der DS in sortierter Form mit Baumstruktur
ca 1000 mal
wenn rel wenig rauskommt am besten einer oder keiner


CLUSTERED IX (gruppierte) = Tabelle in sortierter Form
nur 1 mal
gut wenn Bereichsabfragen

-----------------------------
eindeutiger IX    !

gefilterten IX nur ein Teil der DAten , macht Sinn wenn am Ende weniger Ebenen

ind Sicht  ! kaum einsetzbar.. viele Randbedingungen Count, eindeutigkeit
zusammengesetzter IX   !    (max 16 Spalten  900bytes)
sind nur die where Spalten 


IX mit eingeschlossenen Spalten     !
ca 1000 Spalten   SELECT 


abdeckender IX   !  reiner Seek ,der alles beantwortet ohne Lookup

part IX  jede Menge gefilt Ix .. für jeden ! Umstand

-------Alb----Arg----Ag------Bel-------------FR----------------------------------------------------

realen hypothetischen IX
-------------------------------
Columnstore IX 


*/

100000 Seiten   20 Spalten 200DS pro Seiten
5000 Seiten     
25 Seiten
1 Seiten


--TABLE SCAN.. komlettes Lesen der Tabellen
--IX SCAN .. komplettes durchsuchen des IX
--IX SEEK.. Herauspicken.. best !!!!!




select * from orders where orderid = 10248

select * from customers

insert into customers (customerid, CompanyName) values ('ppedv', 'Fa ppedv AG')



select * into ku from kundeumsatz


--wiederholen bis 551000 rows affected
insert into ku
select * from ku



select * into ku2 from ku


--Spalte mit ID dazu
alter table ku add id int identity


dbcc showcontig('ku') --41098 Seiten


set statistics io, time on

select * from ku where id = 100   --57388, Seiten
--KU = HEAP --> TABLE SCAN

--??? ca 17000 Seiten mehr als Tabelle hat???

--17000 Seiten mit IDs


alter table ku2 add id int identity

dbcc showcontig ('ku2')--depricated

select * from ku2 where id = 100


select * from sys.dm_db_index_physical_stats(db_id(), object_id('ku2'), NULL, NULL, 'detailed')
--forward_record count 



select id  from ku where id = 100
--TABLE SCAN --> IX SEEK


--IX WAHL

--welche Spalte wird vermutlich am häufigsten mit > < oder between abgefragt
--> Orderdate GR IX

select id  from ku where id = 100 --0 ms 3 Seiten
--ix seek

select id, customerid from ku where id = 100
--ix seek it Lookup

--bei ca 10500 die Grenze zw Table scan und IX Seek
select id, customerid from ku where id < 905000


--IX mit ID und Customerid  --kein Lookup
--N CL zusammengesetzt , eindeutig


--IX mit eingeschlossenen Spalten :
--NIX_ID_i_CUSTID_CI_CY
select id, CustomerID, country , city from ku where id = 100



select  Shipcountry, shipcity, sum(freight) from ku
where ProductID < 10
group by shipcountry, ShipCity


--   NIX_PID_i_sc_sci_fr


USE [Northwind]

GO

CREATE NONCLUSTERED INDEX [NonClusteredIndex-20220325-112024] ON [dbo].[ku]
(
	[ProductID] ASC
)
INCLUDE([Freight],[ShipCity],[ShipCountry]) 
GO


CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
ON [dbo].[ku] ([ProductID])
INCLUDE ([Freight],[ShipCity],[ShipCountry])



--OR....
select shipcity, shipcountry from ku
where 
		quantity < 5 or freight < 2
--eigtl 2 Inidzes

NIX_QU_FR_i_sc_scy



--AND
select shipcity, shipcountry from ku
where 
		quantity < 5 and freight < 2


select freight, unitprice
from ku
where country = 'UK' and City = 'London'

USE [Northwind]



CREATE NONCLUSTERED INDEX [NonClusteredIndex-20220325-112635] ON [dbo].[ku]
(
	[City] ASC,
	[Country] ASC
)
INCLUDE([Freight],[UnitPrice]) 


Select country , count(*) from ku
group by country

create view vdemo 
as
Select country , count(*)  as Anz from ku
group by country


Select country , count(*) from ku
group by country

select * from vdemo


create or alter view vdemo with schemabinding
as
Select country , COUNT_BIG(*)  as Anz from dbo.ku
group by country




CREATE UNIQUE CLUSTERED INDEX [CLIX_Vdemo] ON [dbo].[vdemo]
(
	[country] ASC
)

---Amazon: 

---leider geht das nur in Kombi mit Count_big(*)


select  city , lastname from ku
where freight < 5 and country = 'UK'




CREATE NONCLUSTERED INDEX [NIX_1] ON [dbo].[ku]
(
	[Freight] ASC,
	[Country] ASC
)
INCLUDE([City],[LastName]) 
USE [Northwind]



CREATE NONCLUSTERED INDEX [NIX_1_FilerUK] ON [dbo].[ku]
(
	[Freight] ASC,
	[Country] ASC
)
INCLUDE([City],[LastName]) 
WHERE Country = 'UK'




--Abfrage: best Spalten , Aggregate where 

select top 3 * from ku


select lastname, year(orderdate), month(orderdate), sum(unitprice*quantity)
from ku2
where  shipcountry = 'USA' 
group by lastname, year(orderdate), month(orderdate)
order by 1,2,3


--trigger: delete --> deleted 
--            insert --> inserted
--            update --> deleted und inserted



---oooo1o
--update = INS und DEL








--NIX_SC_i_lnodate_Up_qu
--CPU-Zeit = 63 ms, verstrichene Zeit = 50 ms.  --Seiten 1317


--statt 500MB nur 3 MB

--stimmt!
--Komprimiert!!--kleiner !!!!


--3MB in RAM!!!--mit weniger CPU Leistung




Werte werden spaltenweise abgelegt
LAND   STADT  LASTNAME   FIRMA 
SEG       SEG SEG SEG
SEG		 SEG
SEG       SEG


Reduzieren massiv IO 



--------------------------------------> IO
-------------------> CPU


-->IO
->CPU------>

Batchmodus



KRUX:

I UP D

Schweden

SEG 
SC
SE
SCHW

DELTA STORE = HEAP  ab  MIO DS im HEAP.-> SEG





select * from sys.dm_db_column_store_row_group_physical_stats

--REBUILD .. REORG
--REBUILD..  ganzer Baum 
--REORG_   Blattebene (Zeiger)


















--




select lastname, year(orderdate), month(orderdate), sum(unitprice*quantity)
from ku2
where  shipcountry = 'USA' 
group by lastname, year(orderdate), month(orderdate)
order by 1,2,3






