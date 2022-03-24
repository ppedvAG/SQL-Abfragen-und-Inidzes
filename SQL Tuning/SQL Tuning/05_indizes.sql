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
eindeutiger IX 
gefilterten IX
ind Sicht
zusammengesetzter IX
IX mit eingeschlossenen Spalten
abdeckender IX
part IX
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