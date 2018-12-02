/* Q1
SELECT
	pizza 
FROM
	( SELECT * FROM person WHERE gender = 'female' AND age > 20 ) AS r
	NATURAL JOIN eats;
*/

/* Q2
SELECT NAME 
FROM
	eats
	NATURAL JOIN serves
	NATURAL JOIN person 
WHERE
	gender = 'female' 
	AND pizzeria = 'Straw Hat';
*/

/* Q3
SELECT DISTINCT
	pizzeria 
FROM
	( SELECT * FROM eats WHERE `name` = 'Amy' OR `name` = 'Fay' ) AS r1
	NATURAL JOIN ( SELECT * FROM serves WHERE price < 10 ) AS r2;
*/

/* Q4
SELECT DISTINCT
	pizzeria 
FROM
	( SELECT * FROM serves WHERE price < 10 ) AS r1
	NATURAL JOIN (
		( SELECT pizza FROM eats WHERE `name` = 'Amy' ) AS r2
		NATURAL JOIN ( SELECT pizza FROM eats WHERE `name` = 'Fay' ) AS r3 
	);
*/

/* Q5
SELECT DISTINCT
	`name` 
FROM
	eats
	NATURAL JOIN serves 
WHERE
	pizzeria = 'Dominos' 
	AND `name` NOT IN ( SELECT `name` FROM frequents WHERE pizzeria = 'Dominos' );
*/