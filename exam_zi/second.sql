SELECT t.trackid                                  as idFilma,
       t.tracktitle                               as nazivFilma,
       t.releasedate                              as datumIzlaska,
       t2.tracktitle                              as nazivPreth,
       t2.releasedate                             as datumIzlaskaPreth,
       (m2.boxincome::FLOAT / m.boxincome::FLOAT) as omjerZarada,
       (
           CASE
               WHEN m2.trackid IS NULL THEN 'nema podataka'
               WHEN (m2.boxincome::FLOAT / m.boxincome::FLOAT) >= 2 THEN 'prethodnik zaradio barem dvostruko više'
               ELSE 'prethodnik nije zaradio dvostruko više'
               END
           )                                      as poruka
FROM movie m
         JOIN track t ON m.trackid = t.trackid
    AND t.duration <= '75 minutes'::interval
    AND t.duration >= '60 minutes'::interval
    AND (EXTRACT(YEAR from t.releasedate) = 2019
        OR EXTRACT(YEAR from t.releasedate) = 2020)
         LEFT JOIN movie m2 ON m2.trackid = m.prevmovieid AND m2.boxincome > m.boxincome
         LEFT JOIN track t2 ON t2.trackid = m2.trackid
ORDER BY omjerZarada, t.tracktitle;

-- SELECT *
-- FROM track
-- WHERE trackid = 3879;