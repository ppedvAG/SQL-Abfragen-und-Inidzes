--Temp Tabellen

/*
#tabelle
lokale temp Tabelle

lokal: existiert nur in er der Sitzung , in der es erstellt wurde
temp.: sie lebt bis die Sitzung geschlossen wird oder sie aktiv gelöscht wird drop table #t

##tabelle
globale temp Tabelle
global: exisitiert auch in anderen Sitzungen
temp: sie exisitert bis sie aktiv gelöscht wird oder die Sitzung geschlossen wird
aber best Abfragen ,die gerade laufen werden nicht unterbrochen


*/

select * into #t from  sysfiles
select * into ##t from  sysfiles

select * from #t
select * from ##t
















--mal wieder  ABC Analyse 

select var(freight), avg(freight), stdev(freight) from orders










with cte
as
(
select employeeid , sum(freight) as Frachtsumme , 
rank()  over (order by sum(freight)) as Rang1,
rank()  over (order by sum(freight) desc) as Rang2
from orders group by employeeid
) 
select * from cte where Rang1 = 1 or Rang2 = 1





		with cte
		as
		(	
		select companyname, o.orderid, sum(unitprice * quantity) as RngSumme,
			rank() over (partition by companyname order by sum(unitprice * quantity) desc) as RANG
			from customers c
												inner join orders o on c.CustomerID = o.CustomerID
												inner join [Order Details] od on od.orderid = o.OrderID
			group by companyname, o.orderid
			)
			select * from cte where Rang = 1