SELECT *
FROM audiolang;

SELECT DISTINCT p.ownerid, t2.tracktitle
FROM profile AS p
         JOIN trackview t on p.ownerid = t.ownerid and p.profilename = t.profilename
         JOIN track t2 on t.trackid = t2.trackid AND t2.tagerestriction IS NOT NULL
WHERE (t.viewenddatetime - t.viewstartdatetime) < '7 minutes 5 seconds'::interval
  AND t.viewstartdatetime >= (NOW() - '18 days'::interval);

SELECT t.trackid,
       t.tracktitle,
       CASE
           WHEN t.trackrating IS NULL THEN 'nepoznato'
           WHEN t.trackrating < 50 THEN 'loš'
           WHEN t.trackrating < 80 THEN 'dobar'
           WHEN t.trackrating > 80 THEN 'odličan'
           END as rating
FROM track as t
         JOIN movie m on t.trackid = m.trackid AND m.boxincome > 100000000
WHERE t.tracktitle ILIKE '%in%'
  AND t.tracktitle NOT ILIKE 'in%';

SELECT DISTINCT t.tracktitle, t.duration, p.profilename, p.pemail
FROM track as t
         JOIN trackgenre t2 on t.trackid = t2.trackid
         JOIN genre g on t2.genreid = g.genreid
         JOIN trackview tv
              on t.trackid = tv.trackid AND (tv.viewenddatetime - tv.viewstartdatetime) < t.duration / 2
         JOIN profile p on tv.ownerid = p.ownerid and tv.profilename = p.profilename
WHERE t.tagerestriction >= 17
  AND g.genrename = 'Horror'
ORDER BY t.tracktitle ASC, p.profilename DESC;

SELECT o.ownerid,
       o.firstname,
       o.lastname,
       p.profilename,
       ((SELECT COUNT(*)::FLOAT
         FROM profiletrack AS pt
         WHERE pt.profilename = p.profilename
           AND pt.ownerid = o.ownerid
           AND pt.liked = -1) /
        (SELECT COUNT(*)::FLOAT
         FROM profiletrack AS pt
         WHERE pt.profilename = p.profilename
           AND pt.ownerid = o.ownerid
           AND pt.liked IS NOT NULL) * 100)::DECIMAL(20, 16) || ' %' as postotak
FROM owner as o
         JOIN profile p on o.ownerid = p.ownerid
WHERE (SELECT COUNT(*)::FLOAT
       FROM profiletrack AS pt
       WHERE pt.profilename = p.profilename
         AND pt.ownerid = o.ownerid
         AND pt.liked = 1) -
      (SELECT COUNT(*)::FLOAT
       FROM profiletrack AS pt
       WHERE pt.profilename = p.profilename
         AND pt.ownerid = o.ownerid
         AND pt.liked = -1) >= 10;

SELECT DISTINCT s.showtitle, COUNT(s2.episodeno) as numberOfEpisodes
FROM show AS s
         JOIN showep s2 on s.showid = s2.showid
         JOIN track t on s2.trackid = t.trackid
WHERE t.releasedate >= '01.01.2021.'
GROUP BY s.showtitle;

SELECT track.tracktitle, track.trackrating FROM track
-- UPDATE track
-- SET trackrating = trackrating * 1.07
WHERE track.trackid IN (SELECT t.trackid
                        FROM track AS t
                                 JOIN movie m ON t.trackid = m.trackid
                                 JOIN movie m2 ON m.prevmovieid = m2.trackid
                        WHERE m.boxincome::FLOAT / m2.boxincome::FLOAT >= 1.6
                          AND m.boxincome::FLOAT / m2.boxincome::FLOAT <= 1.8);

SELECT track.tracktitle, COUNT(track.trackid) FROM track
JOIN profiletrack p on track.trackid = p.trackid
JOIN profile p2 on p.ownerid = p2.ownerid and p.profilename = p2.profilename
JOIN owner o on p2.ownerid = o.ownerid
WHERE o.dateofbirth >= '01.01.2003.' AND releasedate >= '01.01.2021.'
GROUP BY track.tracktitle