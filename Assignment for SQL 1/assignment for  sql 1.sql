/* Q1
SELECT
	title 
FROM
	movie 
WHERE
	director = 'Steven Spielberg';
*/ 

/* Q2
SELECT DISTINCT
	`year` 
FROM
	movie,
	rating 
WHERE
	( movie.mID = rating.mID AND ( rating.stars = 4 OR rating.stars = 5 ) ) 
ORDER BY
	`year` ASC;
*/


/* Q3
SELECT
	title 
FROM
	movie 
WHERE
	mID NOT IN ( SELECT mID FROM rating );
*/

/* Q4
SELECT
	`name` 
FROM
	rating,
	reviewer 
WHERE
	reviewer.rID = rating.rID 
	AND rating.ratingDate IS NULL;
*/

/* Q5
SELECT
	reviewer.`name`,
	title,
	stars,
	ratingDate 
FROM
	movie,
	rating,
	reviewer 
WHERE
	reviewer.rID = rating.rID 
	AND rating.mID = movie.mID 
ORDER BY
	reviewer.`name`,
	title,
	stars;
*/

/* Q6
SELECT
	reviewer.`name`,
	title 
FROM
	movie,
	reviewer,
	rating r1,
	rating r2 
WHERE
	(
		r1.rID = r2.rID 
		AND r1.mID = r2.mID 
		AND r1.stars < r2.stars 
		AND r1.ratingDate < r2.ratingDate 
		AND r2.rID = reviewer.rID 
	AND r2.mID = movie.mID 
	);
*/

/* Q7
SELECT
	title,
	stars 
FROM
	(
	SELECT DISTINCT
		r1.mID,
		r1.stars 
	FROM
		rating r1,
		rating 
	WHERE
		r1.mID = rating.mID 
		AND r1.stars >= ALL ( SELECT stars FROM rating WHERE rating.mID = r1.mID ) 
	) AS r,
	movie 
WHERE
	movie.mID = r.mID 
ORDER BY
	title;
*/

/* Q8
SELECT
	title,
	`AVG(stars)` 
FROM
	movie,
	( SELECT mID, AVG(stars) FROM rating GROUP BY mID ) AS r 
WHERE
	movie.mID = r.mID 
ORDER BY
	`AVG(stars)` DESC,
	title;
*/

/* Q9
SELECT NAME 
FROM
	reviewer 
WHERE
	rID IN ( SELECT rID FROM ( SELECT rID, count( mID ) AS ratingtimes FROM rating GROUP BY rID HAVING ratingtimes >= 3 ) AS t )
*/

/* Q10
SELECT DISTINCT
	`name` 
FROM
	movie
	NATURAL JOIN rating
	NATURAL JOIN reviewer 
WHERE
	title = 'Gone with the Wind';
*/

/* Q11
SELECT
	`name`,
	title,
	stars 
FROM
	movie
	NATURAL JOIN rating
	NATURAL JOIN reviewer 
WHERE
	`name` = director;
*/

/* Q12
SELECT
	* 
FROM
	( SELECT `name` FROM reviewer UNION SELECT title FROM movie ) AS r 
ORDER BY
	`name`;
*/

/* Q13
SELECT
	title 
FROM
	movie 
WHERE
	mID NOT IN ( SELECT mID FROM rating NATURAL JOIN reviewer WHERE `name` = 'Chris Jackson' );
*/

/* Q14
SELECT DISTINCT
	r1.`name`,
	r2.`name` 
FROM
	reviewer r1,
	reviewer r2,
	rating t1,
	rating t2 
WHERE
	r1.rID = t1.rID 
	AND r2.rID = t2.rID 
	AND t1.mID = t2.mID 
	AND r1.`name` < r2.`name` 
ORDER BY
	r1.`name`,
	r2.`name`;
*/

/* Q15
SELECT
	`name`,
	title,
	stars 
FROM
	movie
	NATURAL JOIN rating
	NATURAL JOIN reviewer 
WHERE
	stars = ( SELECT MIN( stars ) FROM rating );
*/

/* Q16
SELECT
	title,
	ratingspread 
FROM
	movie
	NATURAL JOIN ( SELECT mID, MAX( stars ) - MIN( stars ) AS 'ratingspread' FROM movie JOIN rating USING ( mID ) GROUP BY mID ) AS r 
ORDER BY
	ratingspread DESC,title;
*/

/* Q17
SELECT
	MAX( avg ) - MIN( avg ) AS difference 
FROM
	(
	SELECT
		AVG( avg ) AS avg 
	FROM
		(
		SELECT
			`year`,
			avg 
		FROM
			movie
			NATURAL JOIN ( SELECT mID, AVG( stars ) AS avg FROM rating GROUP BY mID ) AS r1 
		WHERE
			`year` < 1980 
		) AS r2 UNION
	SELECT
		AVG( avg ) AS avg 
	FROM
		(
		SELECT
			`year`,
			avg 
		FROM
			movie
			NATURAL JOIN ( SELECT mID, AVG( stars ) AS avg FROM rating GROUP BY mID ) AS r3 
		WHERE
			`year` > 1980 
		) AS r4 
	) AS r5;
*/

/* Q18
SELECT DISTINCT
	title,
	director 
FROM
	movie
	NATURAL JOIN ( SELECT director FROM movie GROUP BY director HAVING COUNT( title ) > 1 ) AS r 
ORDER BY
	director,
	title;
*/

/* Q19
SELECT
	title,
	avg 
FROM
	movie
	NATURAL JOIN ( SELECT mID, AVG( stars ) AS avg FROM rating GROUP BY mID ) AS r1 
WHERE
	avg = ( SELECT MAX( avg ) FROM ( SELECT mID, AVG( stars ) AS avg FROM rating GROUP BY mID ) AS r2 );
*/

/* Q20
SELECT
	title,
	avg 
FROM
	movie
	NATURAL JOIN ( SELECT mID, AVG( stars ) AS avg FROM rating GROUP BY mID ) AS r1 
WHERE
	avg = ( SELECT MIN( avg ) FROM ( SELECT mID, AVG( stars ) AS avg FROM rating GROUP BY mID ) AS r2 );
*/

/* Q21
SELECT DISTINCT
	r2.director,
	title,
	stars AS max 
FROM
	( SELECT director, title, stars FROM movie NATURAL JOIN rating ) AS r1,
	( SELECT director, MAX( stars ) AS max FROM movie NATURAL JOIN rating WHERE director IS NOT NULL GROUP BY director ) AS r2 
WHERE
	r1.director = r2.director 
	AND r1.stars = r2.max;
*/