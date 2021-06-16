SELECT g.genrename, ROUND(AVG(t.trackrating), 2), COUNT(t.trackid) as tracktitle_count
FROM genre as g
         JOIN trackgenre tg on g.genreid = tg.genreid
         JOIN track t on tg.trackid = t.trackid
GROUP BY g.genreid
HAVING COUNT(t.trackid) > 100
   AND AVG(t.trackrating) >= 50;