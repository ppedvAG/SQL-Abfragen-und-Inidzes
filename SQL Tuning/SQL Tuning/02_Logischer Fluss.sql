select country as land, city as Stadt, count(*) as Anzahl
from customers c
--where Country = 'UK'
group by country, city having Anzahl  >1 --count(*) > 1
order by Land, City

--FROM ALIAS ---> JOIN (Alias) --> WHERE  --
---> GROUP BY --> AGG --> HAVING 
--niemal etwas mit having, was ein where kann
-->SELECT (ALIAS, MATHE..) --ORDER BY --> TOP /DISTINCT
--->AUSGABE


select country as land, city as Stadt, count(*) as Anzahl
from customers c
--where Country = 'UK'
group by country, city having count(*) > 1
order by 2 desc, 1 asc --besser nicht..