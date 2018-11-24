# Description

You've started a new movie-rating website, and you've been collecting data on reviewers' ratings of various movies. There's not much data yet, but you can still try out some interesting queries. Here's the schema:

Movie ( mID, title, year, director )
English: There is a movie with ID number mID, a title, a release year, and a director.

Reviewer ( rID, name )
English: The reviewer with ID number rID has a certain name.

Rating ( rID, mID, stars, ratingDate )
English: The reviewer rID gave the movie mID a number of stars rating (1-5) on a certain ratingDate.

(Notes: Some query SQL are not unique)

### Q1
#### Find the titles of all movies directed by Steven Spielberg.
```sql
SELECT
	title 
FROM
	movie 
WHERE
	director = 'Steven Spielberg';
```
```
+-------------------------+
| title                   |
+-------------------------+
| E.T.                    |
| Raiders of the Lost Ark |
+-------------------------+
```

### Q2
#### Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.
```sql
SELECT DISTINCT
	`year` 
FROM
	movie,
	rating 
WHERE
	( movie.mID = rating.mID AND ( rating.stars = 4 OR rating.stars = 5 ) ) 
ORDER BY
	`year` ASC;
```
```
+------+
| year |
+------+
| 1937 |
| 1939 |
| 1981 |
| 2009 |
+------+
```

### Q3
#### Find the titles of all movies that have no ratings.
```sql
SELECT
	title 
FROM
	movie 
WHERE
	mID NOT IN ( SELECT mID FROM rating );
```
```
+-----------+
| title     |
+-----------+
| Star Wars |
| Titanic   |
+-----------+
```

### Q4
#### Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date.
```sql
SELECT
	`name` 
FROM
	rating,
	reviewer 
WHERE
	reviewer.rID = rating.rID 
	AND rating.ratingDate IS NULL;
```
```
+---------------+
| name          |
+---------------+
| Daniel Lewis  |
| Chris Jackson |
+---------------+
```

### Q5
#### Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.
```sql
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
```
```
+------------------+-------------------------+-------+------------+
| name             | title                   | stars | ratingDate |
+------------------+-------------------------+-------+------------+
| Ashley White     | E.T.                    |     3 | 2011-01-02 |
| Brittany Harris  | Raiders of the Lost Ark |     2 | 2011-01-30 |
| Brittany Harris  | Raiders of the Lost Ark |     4 | 2011-01-12 |
| Brittany Harris  | The Sound of Music      |     2 | 2011-01-20 |
| Chris Jackson    | E.T.                    |     2 | 2011-01-22 |
| Chris Jackson    | Raiders of the Lost Ark |     4 | NULL       |
| Chris Jackson    | The Sound of Music      |     3 | 2011-01-27 |
| Daniel Lewis     | Snow White              |     4 | NULL       |
| Elizabeth Thomas | Avatar                  |     3 | 2011-01-15 |
| Elizabeth Thomas | Snow White              |     5 | 2011-01-19 |
| James Cameron    | Avatar                  |     5 | 2011-01-20 |
| Mike Anderson    | Gone with the Wind      |     3 | 2011-01-09 |
| Sarah Martinez   | Gone with the Wind      |     2 | 2011-01-22 |
| Sarah Martinez   | Gone with the Wind      |     4 | 2011-01-27 |
+------------------+-------------------------+-------+------------+
```

### Q6
#### For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie.
```sql
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
```
```
+----------------+--------------------+
| name           | title              |
+----------------+--------------------+
| Sarah Martinez | Gone with the Wind |
+----------------+--------------------+
```

### Q7
#### For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title.
```sql
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
```
```
+-------------------------+-------+
| title                   | stars |
+-------------------------+-------+
| Avatar                  |     5 |
| E.T.                    |     3 |
| Gone with the Wind      |     4 |
| Raiders of the Lost Ark |     4 |
| Snow White              |     5 |
| The Sound of Music      |     3 |
+-------------------------+-------+
```

### Q8
#### List movie titles and average ratings, from highest-rated to lowest-rated. If two or more movies have the same average rating, list them in alphabetical order.
```sql
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
```
```
+-------------------------+------------+
| title                   | AVG(stars) |
+-------------------------+------------+
| Snow White              |     4.5000 |
| Avatar                  |     4.0000 |
| Raiders of the Lost Ark |     3.3333 |
| Gone with the Wind      |     3.0000 |
| E.T.                    |     2.5000 |
| The Sound of Music      |     2.5000 |
+-------------------------+------------+
```

### Q9
#### Find the names of all reviewers who have contributed three or more ratings. (As an extra challenge, try writing the query without HAVING or without COUNT.)
```sql
SELECT NAME 
FROM
	reviewer 
WHERE
	rID IN ( SELECT rID FROM ( SELECT rID, count( mID ) AS ratingtimes FROM rating GROUP BY rID HAVING ratingtimes >= 3 ) AS t );
```
```
+-----------------+
| NAME            |
+-----------------+
| Brittany Harris |
| Chris Jackson   |
+-----------------+
```

### Q10
#### Find the names of all reviewers who rated Gone with the Wind.
```sql
SELECT DISTINCT
	`name` 
FROM
	movie
	NATURAL JOIN rating
	NATURAL JOIN reviewer 
WHERE
	title = 'Gone with the Wind';
```
```
+----------------+
| name           |
+----------------+
| Sarah Martinez |
| Mike Anderson  |
+----------------+
```

### Q11
#### For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars.
```sql
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
```
```
+---------------+--------+-------+
| name          | title  | stars |
+---------------+--------+-------+
| James Cameron | Avatar |     5 |
+---------------+--------+-------+
```

### Q12
#### Return all reviewer names and movie names together in a single list, alphabetized. (Sorting by the first name of the reviewer and first word in the title is fine; no need for special processing on last names or removing "The".)
```sql
SELECT
	* 
FROM
	( SELECT `name` FROM reviewer UNION SELECT title FROM movie ) AS r 
ORDER BY
	`name`;
```
```
+-------------------------+
| name                    |
+-------------------------+
| Ashley White            |
| Avatar                  |
| Brittany Harris         |
| Chris Jackson           |
| Daniel Lewis            |
| E.T.                    |
| Elizabeth Thomas        |
| Gone with the Wind      |
| James Cameron           |
| Mike Anderson           |
| Raiders of the Lost Ark |
| Sarah Martinez          |
| Snow White              |
| Star Wars               |
| The Sound of Music      |
| Titanic                 |
+-------------------------+
```

### Q13
#### Find the titles of all movies not reviewed by Chris Jackson.
```sql
SELECT
	title 
FROM
	movie 
WHERE
	mID NOT IN ( SELECT mID FROM rating NATURAL JOIN reviewer WHERE `name` = 'Chris Jackson' );
```
```
+--------------------+
| title              |
+--------------------+
| Gone with the Wind |
| Star Wars          |
| Titanic            |
| Snow White         |
| Avatar             |
+--------------------+
```

### Q14
#### For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. For each pair, return the names in the pair in alphabetical order.
```sql
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
```
```
+------------------+------------------+
| name             | name             |
+------------------+------------------+
| Ashley White     | Chris Jackson    |
| Brittany Harris  | Chris Jackson    |
| Daniel Lewis     | Elizabeth Thomas |
| Elizabeth Thomas | James Cameron    |
| Mike Anderson    | Sarah Martinez   |
+------------------+------------------+
```

### Q15
#### For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and number of stars.
```sql
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
```
```
+-----------------+-------------------------+-------+
| name            | title                   | stars |
+-----------------+-------------------------+-------+
| Sarah Martinez  | Gone with the Wind      |     2 |
| Brittany Harris | The Sound of Music      |     2 |
| Brittany Harris | Raiders of the Lost Ark |     2 |
| Chris Jackson   | E.T.                    |     2 |
+-----------------+-------------------------+-------+
```

### Q16
#### For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title. 
```sql
SELECT
	title,
	ratingspread 
FROM
	movie
	NATURAL JOIN ( SELECT mID, MAX( stars ) - MIN( stars ) AS 'ratingspread' FROM movie JOIN rating USING ( mID ) GROUP BY mID ) AS r 
ORDER BY
	ratingspread DESC,title;
```
```
+-------------------------+--------------+
| title                   | ratingspread |
+-------------------------+--------------+
| Avatar                  |            2 |
| Gone with the Wind      |            2 |
| Raiders of the Lost Ark |            2 |
| E.T.                    |            1 |
| Snow White              |            1 |
| The Sound of Music      |            1 |
+-------------------------+--------------+
```

### Q17
#### Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.) 
```sql
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
```
```
+------------+
| difference |
+------------+
| 0.05556666 |
+------------+
```

### Q18
#### Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, along with the director name. Sort by director name, then movie title. (As an extra challenge, try writing the query both with and without COUNT.) 
```sql
SELECT DISTINCT
	title,
	director 
FROM
	movie
	NATURAL JOIN ( SELECT director FROM movie GROUP BY director HAVING COUNT( title ) > 1 ) AS r 
ORDER BY
	director,
	title;
```
```
+-------------------------+------------------+
| title                   | director         |
+-------------------------+------------------+
| Avatar                  | James Cameron    |
| Titanic                 | James Cameron    |
| E.T.                    | Steven Spielberg |
| Raiders of the Lost Ark | Steven Spielberg |
+-------------------------+------------------+
```

### Q19
#### Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. (Hint: This query is more difficult to write in SQLite than other systems; you might think of it as finding the highest average rating and then choosing the movie(s) with that average rating.) 
```sql
SELECT
	title,
	avg 
FROM
	movie
	NATURAL JOIN ( SELECT mID, AVG( stars ) AS avg FROM rating GROUP BY mID ) AS r1 
WHERE
	avg = ( SELECT MAX( avg ) FROM ( SELECT mID, AVG( stars ) AS avg FROM rating GROUP BY mID ) AS r2 );
```
```
+------------+--------+
| title      | avg    |
+------------+--------+
| Snow White | 4.5000 |
+------------+--------+
```

### Q20
#### Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. (Hint: This query may be more difficult to write in SQLite than other systems; you might think of it as finding the lowest average rating and then choosing the movie(s) with that average rating.) 
```sql
SELECT
	title,
	avg 
FROM
	movie
	NATURAL JOIN ( SELECT mID, AVG( stars ) AS avg FROM rating GROUP BY mID ) AS r1 
WHERE
	avg = ( SELECT MIN( avg ) FROM ( SELECT mID, AVG( stars ) AS avg FROM rating GROUP BY mID ) AS r2 );
```
```
+--------------------+--------+
| title              | avg    |
+--------------------+--------+
| The Sound of Music | 2.5000 |
| E.T.               | 2.5000 |
+--------------------+--------+
```

### Q21
#### For each director, return the director's name together with the title(s) of the movie(s) they directed that received the highest rating among all of their movies, and the value of that rating. Ignore movies whose director is NULL. 
```sql
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
```
```
+------------------+-------------------------+------+
| director         | title                   | max  |
+------------------+-------------------------+------+
| Victor Fleming   | Gone with the Wind      |    4 |
| Steven Spielberg | Raiders of the Lost Ark |    4 |
| Robert Wise      | The Sound of Music      |    3 |
| James Cameron    | Avatar                  |    5 |
+------------------+-------------------------+------+
```
