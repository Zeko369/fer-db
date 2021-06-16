SELECT p.sifpredmet, p.nazpredmet, p.ectsbod
FROM predmet as p
         LEFT JOIN upisanpredmet u
                   ON p.sifpredmet = u.sifpredmet AND u.akgodina = 2019
WHERE ectsbod > 4
GROUP BY p.sifpredmet
HAVING COUNT(u.sifpredmet) = 0;

SELECT p.nazpredmet,
       n.prezimenastavnik,
       n.imenastavnik,
       i.jmbag,
       i.ocjena
FROM nastavnik as n
         JOIN ispit i
              on n.sifnastavnik = i.sifnastavnik
                  AND EXTRACT(year FROM i.datumispit - '3 months'::INTERVAL) = 2019
                  AND i.ocjena > (SELECT avg(ii.ocjena)
                                  FROM ispit as ii
                                  WHERE ii.sifpredmet = i.sifpredmet
                                    AND EXTRACT(year from ii.datumispit - '3 months'::INTERVAL) = 2019)
         JOIN predmet p on i.sifpredmet = p.sifpredmet;
