---MAXDOP.. mehr CPUs pro Abfrage

--nicht jede gleich! 
--ab einem best Kostenschwellwert werden alle CPUs verwendet
--KSchwellert: 5 

--die DS werden ungerecht verteilt

--je merh CPUs desto scheller...--> 

set statistics time on

select country, sum(freight) from ku group by country option (maxdop 6)

---8-, CPU-Zeit = 2281 ms, verstrichene Zeit = 429 ms.

--1 CPU  , CPU-Zeit = 703 ms, verstrichene Zeit = 728 ms.

--,4   CPU-Zeit = 892 ms, verstrichene Zeit = 267 ms.