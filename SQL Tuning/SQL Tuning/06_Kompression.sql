--Kompression


--f¸r Client transparent

--Tabellen ---> Zeilen/Seiten
-- zu erwarten :  40 bis 60%


--Was passiert mit komprimierten Tabellen:

--Annahme: 1000 MB   200.000 Seiten

--Nicht komprimiert: TABLE SCAN:  Seiten: 200.000     11000ms CPU   4500ms Dauer
								  RAM: 1000MB

--Komprimiert:  500MB   -->  100.000   
							     RAM:      500MB
								 CPU: steigt

--Mit der Kompressiion gewinne ich RAM und bezahle mit CPU
set statistics io, time on
use testdb

select * from t1
, CPU-Zeit = 125 ms, verstrichene Zeit = 1283 ms.--- 32 Seiten

select * into t3 from t1

select * from t3
, CPU-Zeit = 172 ms, verstrichene Zeit = 1314 ms. --20000


--Kompression l‰ﬂt sich auch auf Part anwenden!!

USE [Northwind]
ALTER TABLE [dbo].[ptab] REBUILD PARTITION = 1 WITH(DATA_COMPRESSION = NONE )
USE [Northwind]
ALTER TABLE [dbo].[ptab] REBUILD PARTITION = 2 WITH(DATA_COMPRESSION = NONE )
USE [Northwind]
ALTER TABLE [dbo].[ptab] REBUILD PARTITION = 3 WITH(DATA_COMPRESSION = PAGE )
