/* Q1
SELECT
	hotel_name,
	room_name 
FROM
	hotel
	NATURAL JOIN room_type;
*/

/* Q2
SELECT
	hotel_name,
	date,
	AVG( price ) AS avgprice 
FROM
	room_info
	NATURAL JOIN room_type
	NATURAL JOIN hotel 
	WHERE date='2018-11-14'
GROUP BY
	hotel_name,
	date 
ORDER BY
	avgprice;
*/

/* Q3
SELECT
	hotel_name,
	room_name,
	avg( price ) AS avgprice 
FROM
	hotel
	NATURAL JOIN room_type
	NATURAL JOIN room_info 
WHERE
	date >= '2018-11-14' AND date <= '2018-11-15' 
GROUP BY
	room_id 
HAVING
	min( remain ) >= 4 
ORDER BY
	avgprice;
*/

/* Q4
INSERT INTO `order`
VALUES
	( 5, 2, '2018-11-14', '2018-11-15', 3, 666, '2018-11-02' );
UPDATE room_info 
	SET remain = remain - 3 
WHERE
	date <= '2018-11-15' AND date >= '2018-11-14' 
	AND room_id = 2;
*/

/* Q5
SELECT
	hotel_name,
	start_date,
	room_name,
	amount 
FROM
	`order`
	NATURAL JOIN room_type
	NATURAL JOIN hotel 
WHERE
	start_date = '2018-11-14';
*/

/* Q6
SELECT
	hotel_name,
	date,
	totalremain,
	totalprice / totalremain AS avgprice 
FROM
	(
	SELECT
		hotel_name,
		date,
		SUM( remain ) AS totalremain,
		SUM( price * remain ) AS totalprice 
	FROM
		hotel
		NATURAL JOIN room_type
		NATURAL JOIN room_info
	WHERE date>='2018-11-14'AND date<='2018-11-16'	
	GROUP BY
		hotel_name,
		date 
	) AS r1
ORDER BY
	avgprice;
*/

/* Q2 Select all
SELECT
	hotel_name,
	date,
	AVG( price ) AS avgprice 
FROM
	room_info
	NATURAL JOIN room_type
	NATURAL JOIN hotel
GROUP BY
	hotel_name,
	date
ORDER BY
	avgprice;
*/

/* Q3 Select all
SELECT
	hotel_name,
	room_name,
	avg( price ) AS avgprice 
FROM
	hotel
	NATURAL JOIN room_type
	NATURAL JOIN room_info 
GROUP BY
	room_id 
ORDER BY
	avgprice;
*/

/* Q5 Select all
SELECT
	hotel_name,
	start_date,
	room_name,
	amount 
FROM
	`order`
	NATURAL JOIN room_type
	NATURAL JOIN hotel;
*/
