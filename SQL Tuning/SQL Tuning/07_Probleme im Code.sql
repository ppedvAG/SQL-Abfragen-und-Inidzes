
select * from customers c
inner join orders o 
	on c.CustomerID= o.CustomerID

	--inner join left right cross 
	--loop   hash   merge

	--merge join mach t auf beiden Seiten nur einen
	--Durchlauf .. --> sortiert!!


select * from customers c
inner merge  join orders o 
	on c.CustomerID= o.CustomerID
	where o.customerid like 'A%'

select * from customers c
inner loop   join orders o 
	on c.CustomerID= o.CustomerID

select * from customers c
inner hash  join orders o 
	on c.CustomerID= o.CustomerID





create proc gpname @par datentyp
as
code

--Tab Customers  customerid nchar(5)

exec gpSucheKunden 'ALFKI'  --1 Treffer

exec gpSucheKunden 'A'  --4  Treffer

exec gpsucheKunden   --alle 91


create or alter proc gpSucheKunden @Kdid  nvarchar(5) = '%'      
as
select * from customers where customerid like @kdid +'%'


--Regel: wer sagt, dass Variablen od Parameter immer denselben Dtyp haben müssen?

--vor allem bei Variablen und order by in Schleifen !!!!
--nicht blöd.. statt varchar(50) in der DB , dann ein varchar(140)

= 100
like '100'

--Regel:  Schreibe nie benutzerfreundliche Prozeduren

select * from ku where id < 2

--wir wollen lne immer wieder verwenden können.. auch nach Neustart!


create proc gpdemo2 @id int
as
select * from ku where id < @id

set statistics io , time on

select * from ku where id < 2

exec gpdemo2 2



select * from ku where id < 1000000 -- 57388,   7000ms CPU

exec gpdemo2 1000000   ---1 MIo Seiten    11700 ms CPU



create proc gpdemo2 @id int 
as
IF @id <= 10500 
exec gpdemox  --IX SEEK
else 
exec gpdemoy @id --- TAB SCAN


create proc gpdemo4 @id
as
IF @id < 100
select * from customers where....
else
select * from orders where ....



select * from ku where id < @id


exec gpdemo2 --immer seek oder lieber immer SCAN
--

--Häufiger Id unter 10500 oder öfters große Zahlen 10500


dbcc freeproccache

exec gpdemo2 1000000

exec gpdemo2 2



--Ist TSQL case sensitive?

--Suche alle Angetsellten aus Employees , die im Rentenalter heute sind:... 65?
select * from employees --BirthDate

select * from employees where datediff(yy, Birthdate, getdate()) >=65 --stimmt ..aber schlecht gelöst

--Var 2: 
declare @Datum datetime
select @datum = dateadd(yy, -65, Getdate())

select * from employees where birthdate < @Datum

--Plan kann nur sehr schlecht geschätzt


--var 3
select * from employees where birthdate < dateadd(yy, -65, Getdate()) --Seek


--Idee: Datum aufteilen mehr Spalten (Jahr, Quartal  KW)
--  andreasr@ppedv.de -- andreasr | ppedv.de









