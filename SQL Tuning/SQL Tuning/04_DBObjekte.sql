--a) adhoc .. select 
--b) View
--c) Prozedur
--d) F()

--langsam------> schnell
--   a|b   d   c

--faktisch...
-- d  a|b   c

--Prozedur:

create proc gpName @par1 int, ...
as
SEL, INS DEL UP  EXEC

exec gpName @par1

Select * from Tabelle --adhoc
--es muss ein Plan generiert werden
set statistics io, time on
select * from [Order Details] where orderid = 10260

--die Prozedur merkt sich den Plan auf Dauer .. auch nach Neustart


select * from orders o inner join [Order Details] od 
on o.orderid = od.orderid
where o.orderid = 10260



----Views... 
--gemerkte Abfrage mit Namen


--Grund für Sichten
--bequemlichkeit
create view KundeUmsatz
as
SELECT Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Orders.EmployeeID, Orders.OrderDate, Orders.Freight, Orders.ShipCity, Orders.ShipCountry, [Order Details].OrderID, [Order Details].ProductID, [Order Details].UnitPrice, [Order Details].Quantity, Products.ProductName, Products.UnitsInStock, Employees.FirstName, Employees.LastName
FROM   Customers INNER JOIN
         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
         Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
         Products ON [Order Details].ProductID = Products.ProductID


	select * from kundeUmsatz

	--Die Summe der Lieferkosten pro Kunde

	--Customerid, Summe Freight

	select customerid, sum(freight) from kundeUmsatz 
	group by customerid


	select customerid, sum(freight) from orders group by customerid

	--also nicht zweckentfremden



	--tats. Grund für Sichten

	select * from employees

	--dem Jens den Zugriff auf employees verweigern

	--sicht, in der sensible Daten fehlen aber auf employees zugegriffen wird... klappt

	--das geht aber nur dann , wenn: Besitzverkettung

	--dbo        dbo     dbo   dbo  dbo
	--TAB < ---V1<---V2<--V3<--V4


	--Bad View
	--drop table slf
	create table slf (id int, stadt int, land int)

	insert into slf
	select 1,10,100
	UNION ALL
	select 2,20,200
	UNION ALL
	select 3,30,300

	select * from slf


	create view v1
	as
	select * from slf

	select * from v1

	alter table slf add fluss int
	update slf set fluss = id *1000

	select * from slf

	select * from v1

	alter table slf drop column land

	--Sicht bringt falsche Ausgaben Land mit Werten von Fluss

	create view dbo.v2 with schemabinding --exaktes Schreiben erforderlich.. kein *
	as
	select id, stadt , land from dbo.slf

	alter table slf add fluss int

	select * from v2

	alter table slf drop column Land

	--Tipp: immer schemgbundenen Sichten







