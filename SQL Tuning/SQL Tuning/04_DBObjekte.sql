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

15:22