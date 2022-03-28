select Country,City, max(freight) as MaxFracht
from Customers c 
	inner join orders o	on c.CustomerID=o.customerid
group by 
	country, city
order by 
	1,2,3

--Was ist der durchschittliche Max Wert?
--wie bekommen wir das hin

--CTE  Common Table Expression


;with CTE (SP, Sp, Sp)
as
(
select ....
)
Select * from cte


;WITH CTE(Firma, KdNr)
AS
(select companyname, customerid from Customers) --virt Tabelle
select * from CTE where KdNr ='ALFKI'



;WITH CityMaxFracht (Land, Stadt, MaxFracht)
as
(
select Country,City, max(freight) 
from Customers c 
	inner join orders o	on c.CustomerID=o.customerid
group by 
	country, city
)
select AVG(maxfracht) from CityMaxFracht

--Alle Angestellen ausgeben 
--AngId, Lastanem, Country, city
--mit CTE


;WITH CTE
as
(Select employeeid, lastname, country, city from Employees)
select * from cte



select * from employees
select employeeid, COUNT(*) from Orders
group by employeeid

--Wie hoch ist die durchschn, Anzahl an Bestellungen pro Mitarbeiter

;WITH CTE(angid, Anzahl) 
as
(
select employeeid, COUNT(*) from Orders
group by employeeid
)
select AVG(Anzahl) from cte


select EmployeeID, ReportsTo, LastName from employees

;WITH CTE (SP,SP,SP)
as
(
select ...... --Anker
UNION ALL
select ... Tab join CTE)
select CTE

;WITH CTE
AS
(
select Lastname, employeeid, reportsto from Employees where ReportsTo is null--Anker
UNION ALL
select e.Lastname, e.employeeid,e.ReportsTo from Employees e 
		inner join CTE on CTE.EmployeeID=e.ReportsTo
)
select * from cte


;WITH CTE
AS
(
select Lastname, employeeid, 1 as RANG from Employees where ReportsTo is null
UNION ALL
select e.Lastname,e.employeeid, RANG+1 from Employees e 
		inner join CTE on CTE.EmployeeID=e.ReportsTo
)
select * from cte where RANG = 2

--Suche alle die im Rang 2 sind

3 Rauch   3/5/2/1
5 Schmitt 5/4/9/1

With myEmps (lastname, firstname, Knechte, Chef)
as
(select lastname,firstname, 
	(select count(1) from employees e2 where
		 e1.EmployeeID=e2.ReportsTo)
	,reportsto
from employees e1)
Select Lastname, firstname, knechte,  Chef from myEmps 



--Liste ergänzen um:
--zu jedem Ang den manager und die Anzahl der Knechte

;WITH EmployeeSubordinatesReport (EmployeeID, LastName, FirstName, NumberOfSubordinates, ReportsTo) AS
(
   SELECT
      EmployeeID,
      LastName,
      FirstName,
      (SELECT COUNT(1) FROM Employees e2
       WHERE e2.ReportsTo = e.EmployeeID) as NumberOfSubordinates,
      ReportsTo
   FROM Employees e
)

SELECT Employee.LastName, Employee.FirstName, Employee.NumberOfSubordinates,
   Manager.LastName as ManagerLastName, Manager.FirstName as ManagerFirstName, Manager.NumberOfSubordinates as ManagerNumberOfSubordinates
FROM EmployeeSubordinatesReport Employee
   LEFT JOIN EmployeeSubordinatesReport Manager ON
      Employee.ReportsTo = Manager.EmployeeID
