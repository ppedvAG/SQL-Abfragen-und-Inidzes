/*
Seiten 
je weniger Seiten --> desto weniger CPU --> weniger RAM

 8kb
 1 DS muss in Seite passen

 Füllgrad des Seiten: dbcc showcontig()

 8 Seiten am Stück --> Block

 --HDD mit 64k Sektoren formatieren

 set statistics io, time on

 
 MIttel um großen Tabellen kleiner zu machen

 part Sicht
 Nachteil: Identity, komplexe Verwaltung

 
 Partitionierung (ab SQL 2016 SP1 aucb in SSEX)


 --Was ist schneller:

 TAB A   10000
 TAB B   100000

 Abfrage -> 5 Zeilen aus
 TAB A und B sind abs identisch

 ..ca 23 Sekunden







 
 */


 	create partition scheme schZahl
	as
	partition fzahl to ([PRIMARY], [PRIMARY], [PRIMARY])