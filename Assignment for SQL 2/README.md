# Description

Students at your hometown high school have decided to organize their social network using databases. So far, they have collected information about sixteen students in four grades, 9-12. Here's the schema: 

Highschooler ( ID, name, grade ) 
English: There is a high school student with unique ID and a given first name in a certain grade. 

Friend ( ID1, ID2 ) 
English: The student with ID1 is friends with the student with ID2. Friendship is mutual, so if (123, 456) is in the Friend table, so is (456, 123). 

Likes ( ID1, ID2 ) 
English: The student with ID1 likes the student with ID2. Liking someone is not necessarily mutual, so if (123, 456) is in the Likes table, there is no guarantee that (456, 123) is also present. 

Instructions: Each problem asks you to write a query in SQL.

(Notes: Some query SQL are not unique)

### Q1
#### Find the names of all students who are friends with someone named Gabriel. 
```sql
SELECT DISTINCT
	`name` 
FROM
	( friend INNER JOIN highschooler ON friend.ID2 = highschooler.ID ) 
WHERE
	ID1 IN ( SELECT ID FROM highschooler WHERE `name` = 'Gabriel' );
```
```
+-----------+
| name      |
+-----------+
| Jordan    |
| Cassandra |
| Andrew    |
| Alexis    |
| Jessica   |
+-----------+
```

### Q2
#### For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like. 
```sql
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
```
```
+------+-------+-------+-------+
| name | grade | name  | grade |
+------+-------+-------+-------+
| John |    12 | Haley |    10 |
+------+-------+-------+-------+
```

### Q3
#### For every pair of students who both like each other, return the name and grade of both students. Include each pair only once, with the two names in alphabetical order. 
```sql
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
```
```
+-----------+-------+---------+-------+
| name      | grade | name    | grade |
+-----------+-------+---------+-------+
| Cassandra |     9 | Gabriel |     9 |
| Jessica   |    11 | Kyle    |    12 |
+-----------+-------+---------+-------+
```

### Q4
#### Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by name within each grade. 
```sql
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
```
```
+----------+-------+
| name     | grade |
+----------+-------+
| Jordan   |     9 |
| Brittany |    10 |
| Haley    |    10 |
| Kris     |    10 |
| Gabriel  |    11 |
| John     |    12 |
| Logan    |    12 |
+----------+-------+
```

### Q5
#### Find the name and grade of all students who are liked by more than one other student. 
```sql
SELECT
	`name`,
	grade 
FROM
	( SELECT ID2, COUNT( ID2 ) AS c FROM likes GROUP BY ID2 HAVING c > 1 ) AS r,
	highschooler 
WHERE
	r.ID2 = highschooler.ID;
```
```
+-----------+-------+
| name      | grade |
+-----------+-------+
| Cassandra |     9 |
| Kris      |    10 |
+-----------+-------+
```

### Q6
#### Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. Sort by grade, then by name within each grade.
```sql
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
```
```
+---------+-------+
| name    | grade |
+---------+-------+
| Jordan  |     9 |
| Tiffany |     9 |
| Logan   |    12 |
+---------+-------+
```

### Q7
#### For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can introduce them!). For all such trios, return the name and grade of A, B, and C.
```sql
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
```
```
+--------+-------+-----------+-------+---------+-------+
| name   | grade | name      | grade | name    | grade |
+--------+-------+-----------+-------+---------+-------+
| Andrew |    10 | Cassandra |     9 | Gabriel |     9 |
| Austin |    11 | Jordan    |    12 | Andrew  |    10 |
| Austin |    11 | Jordan    |    12 | Kyle    |    12 |
+--------+-------+-----------+-------+---------+-------+
```

### Q8
#### Find the difference between the number of students in the school and the number of different first names. 
```sql
SELECT
	COUNT( * ) - COUNT( DISTINCT `name` ) AS difference 
FROM
	highschooler;
```
```
+------------+
| difference |
+------------+
|          2 |
+------------+
```

### Q9
#### What is the average number of friends per student? (Your result should be just one number.) 
```sql
SELECT AVG(count)
FROM (
  SELECT COUNT(*) AS count
  FROM friend
  GROUP BY ID1
)AS r;
```
```
+------------+
| AVG(count) |
+------------+
|     2.5000 |
+------------+
```

### Q10
#### Find the number of students who are either friends with Cassandra or are friends of friends of Cassandra. Do not count Cassandra, even though technically she is a friend of a friend. 
```sql
SELECT
	count( ID2 ) 
FROM
	friend 
WHERE
	ID1 IN ( SELECT ID2 FROM friend WHERE ID1 IN ( SELECT ID FROM highschooler WHERE `name` = 'Cassandra' ) ) 
	AND ID1 NOT IN ( SELECT ID FROM highschooler WHERE `name` = 'Cassandra' );
```
```
+--------------+
| count( ID2 ) |
+--------------+
|            7 |
+--------------+
```

### Q11
#### Find the name and grade of the student(s) with the greatest number of friends. 
```sql
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
```
```
+--------+-------+
| name   | grade |
+--------+-------+
| Andrew |    10 |
| Alexis |    11 |
+--------+-------+
```

### Q12
#### For every situation where student A likes student B, but we have no information about whom B likes (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades. 
```sql
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
```
```
+----------+-------+--------+-------+
| name     | grade | name   | grade |
+----------+-------+--------+-------+
| John     |    12 | Haley  |    10 |
| Brittany |    10 | Kris   |    10 |
| Alexis   |    11 | Kris   |    10 |
| Austin   |    11 | Jordan |    12 |
+----------+-------+--------+-------+
```

### Q13
#### For every situation where student A likes student B, but student B likes a different student C, return the names and grades of A, B, and C. 
```sql
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
```
```
+---------+-------+-----------+-------+---------+-------+
| name    | grade | name      | grade | name    | grade |
+---------+-------+-----------+-------+---------+-------+
| Andrew  |    10 | Cassandra |     9 | Gabriel |     9 |
| Gabriel |    11 | Alexis    |    11 | Kris    |    10 |
+---------+-------+-----------+-------+---------+-------+
```

### Q14
#### Find those students for whom all of their friends are in different grades from themselves. Return the students' names and grades. 
```sql
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
```
```
+--------+-------+
| name   | grade |
+--------+-------+
| Austin |    11 |
+--------+-------+
```
