/* Q1
SELECT DISTINCT
	`name` 
FROM
	( friend INNER JOIN highschooler ON friend.ID2 = highschooler.ID ) 
WHERE
	ID1 IN ( SELECT ID FROM highschooler WHERE `name` = 'Gabriel' );
*/

/* Q2
SELECT
	r1.`name`,
	r1.grade,
	r2.`name`,
	r2.grade 
FROM
	highschooler AS r1
	JOIN likes ON likes.ID1 = r1.ID
	JOIN highschooler AS r2 ON likes.ID2 = r2.ID 
WHERE
	r1.grade - r2.grade >= 2;
*/

/* Q3
SELECT DISTINCT
	hs1.`name`,
	hs1.grade,
	hs2.`name`,
	hs2.grade 
FROM
	highschooler AS hs1,
	highschooler AS hs2,
	likes AS l1,
	likes AS l2 
WHERE
	( hs1.id = l1.id1 AND l1.id2 = hs2.id ) 
	AND ( hs2.id = l2.id1 AND l2.id2 = hs1.id ) 
	AND hs1.NAME < hs2.NAME;
*/

/* Q4
SELECT
	`name`,
	grade 
FROM
	highschooler h1 
WHERE
	NOT EXISTS (
	SELECT
		* 
	FROM
		highschooler h2
		JOIN friend ON friend.ID2 = h2.ID 
	WHERE
		friend.ID1 = h1.ID 
		AND h2.grade != h1.grade 
	) 
ORDER BY
	grade,
	`name`;
*/

/* Q5
SELECT
	`name`,
	grade 
FROM
	( SELECT ID2, COUNT( ID2 ) AS c FROM likes GROUP BY ID2 HAVING c > 1 ) AS r,
	highschooler 
WHERE
	r.ID2 = highschooler.ID;
*/

/* Q6
SELECT
	`name`,
	grade 
FROM
	highschooler 
WHERE
	highschooler.ID NOT IN ( SELECT ID1 FROM likes ) 
	AND highschooler.ID NOT IN ( SELECT ID2 FROM likes ) 
ORDER BY
	grade,
	`name`;
*/

/* Q7
SELECT DISTINCT
	H1.`name`,
	H1.grade,
	H2.`name`,
	H2.grade,
	H3.`name`,
	H3.grade 
FROM
	highschooler H1,
	highschooler H2,
	highschooler H3,
	likes L,
	friend F1,
	friend F2 
WHERE
	( H1.ID = L.ID1 AND H2.ID = L.ID2 ) 
	AND H2.ID NOT IN ( SELECT ID2 FROM friend WHERE ID1 = H1.ID ) 
	AND ( H1.ID = F1.ID1 AND H3.ID = F1.ID2 ) 
	AND ( H2.ID = F2.ID1 AND H3.ID = F2.ID2 );
*/

/* Q8
SELECT
	COUNT( * ) - COUNT( DISTINCT `name` ) AS difference 
FROM
	highschooler;
*/

/* Q9
SELECT AVG(count)
FROM (
  SELECT COUNT(*) AS count
  FROM friend
  GROUP BY ID1
)AS r;
*/

/* Q10
SELECT
	count( ID2 ) 
FROM
	friend 
WHERE
	ID1 IN ( SELECT ID2 FROM friend WHERE ID1 IN ( SELECT ID FROM highschooler WHERE `name` = 'Cassandra' ) ) 
	AND ID1 NOT IN ( SELECT ID FROM highschooler WHERE `name` = 'Cassandra' );
*/

/* Q11
SELECT
	`name`,
	grade 
FROM
	( SELECT ID1, COUNT( ID1 ) AS c FROM friend GROUP BY ID1 ) AS r1
	NATURAL JOIN (
	SELECT
		MAX( c ) AS c 
	FROM
		( SELECT ID1, COUNT( ID1 ) AS c FROM friend GROUP BY ID1 ) AS r2 
	) AS r3,
	highschooler 
WHERE
	highschooler.ID = r1.ID1;
*/

/* Q12
SELECT
	H1.`name`,
	H1.grade,
	H2.`name`,
	H2.grade 
FROM
	likes,
	highschooler H1,
	highschooler H2 
WHERE
	H1.ID = likes.ID1 
	AND H2.ID = likes.ID2 
	AND H2.ID NOT IN ( SELECT ID1 FROM likes );
*/


/* Q13
SELECT
	H1.`name`,
	H1.grade,
	H2.`name`,
	H2.grade,
	H3.`name`,
	H3.grade 
FROM
	likes L1,
	likes L2,
	highschooler H1,
	highschooler H2,
	highschooler H3 
WHERE
	L1.ID2 = L2.ID1 
	AND L2.ID2 != L1.ID1 
	AND L1.ID1 = H1.ID 
	AND L1.ID2 = H2.ID 
	AND L2.ID2 = H3.ID;
*/

/* Q14
SELECT
	`name`,
	grade 
FROM
	highschooler 
WHERE
	ID NOT IN (
	SELECT
		H1.ID 
	FROM
		highschooler H1,
		friend F1,
		highschooler H2 
	WHERE
		H1.ID = F1.ID1 
		AND H2.ID = F1.ID2 
	AND H2.grade = H1.grade 
	);
*/