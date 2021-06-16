SELECT trackId, savedProgress
  FROM trackView
 WHERE profilename = 'curiouswimp'
   AND savedprogress > '40 min'::INTERVAL
ORDER BY trackId;


BEGIN TRANSACTION;
2 	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
3 		BEGIN TRANSACTION;
4 		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
5 		DELETE FROM trackview
WHERE profilename = 'curiouswimp'
AND savedprogress > '1 HOUR'::INTERVAL;
6 	INSERT INTO TRACKVIEW (deviceid, viewstartdatetime,
profilename, trackid, savedprogress)
VALUES ('B2', CURRENT_TIMESTAMP,
'curiouswimp', 10890, '45 MINUTES'::INTERVAL);
7 	SELECT ... ORDER BY trackId;
8 	COMMIT;
9 		UPDATE trackview
SET savedProgress = '50 minutes'::INTERVAL
WHERE profilename = 'curiouswimp'
AND savedProgress = '45 MINUTES'::INTERVAL;
10 		SELECT ... ORDER BY trackId;
11 	BEGIN TRANSACTION;
12 	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
13 		DELETE FROM trackview
WHERE profilename = 'curiouswimp'
AND savedprogress = '44 MINUTES'::INTERVAL;
14 	UPDATE trackview
SET savedProgress = '1 HOUR'::INTERVAL
WHERE profilename = 'curiouswimp'
AND savedProgress = '44 MINUTES'::INTERVAL;
15 		SELECT ... ORDER BY trackId;
16 		COMMIT;
17 	COMMIT;