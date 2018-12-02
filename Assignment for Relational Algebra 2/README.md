# Assignment for Relational Algebra 2

We've created a small sample database to use for this assignment. It contains four relations:
    
    Person(name, age, gender)       // name is a key
    
    Frequents(name, pizzeria)  // [name,pizzeria] is a key
    
    Eats(name, pizza)               // [name,pizza] is a key
    
    Serves(pizzeria, pizza, price)  // [pizzeria,pizza] is a key

## Note：Symbols and Query SQL may not be unique

[Symbols References](https://github.com/branner-courses/databases_widom/blob/master/NOTES/subterranean/QUIZZES/Relational_algebra_Exercises_Core_Set_CoreEx-RA.md)

### Q1
#### Find all pizzas eaten by at least one female over the age of 20. 
Symbols：
```
π_{pizza} σ_{gender='female' ∧ age>20) (Person) ⨝ Eats
```
SQL：
```sql
SELECT
	pizza 
FROM
	( SELECT * FROM person WHERE gender = 'female' AND age > 20 ) AS r
	NATURAL JOIN eats;
```
```
+----------+
| pizza    |
+----------+
| mushroom |
| supreme  |
| cheese   |
+----------+
```

### Q2
#### Find the names of all females who eat at least one pizza served by Straw Hat. (Note: The pizza need not be eaten at Straw Hat.) 
Symbols：
```
π_{name} σ_{gender='female' ∧ pizzeria='Straw Hat'} (Person ⨝ Eats ⨝ Serves)
```
SQL：
```sql
SELECT NAME 
FROM
	eats
	NATURAL JOIN serves
	NATURAL JOIN person 
WHERE
	gender = 'female' 
	AND pizzeria = 'Straw Hat';
```
```
+------+
| NAME |
+------+
| Amy  |
| Hil  |
+------+
```

### Q3
#### Find all pizzerias that serve at least one pizza for less than $10 that either Amy or Fay (or both) eat.
Symbols：
```
π_{name} 
    (σ_{name='Amy' ∨ name='Fay'} (Eats) 
    ⨝ 
    (σ_{price<10} (Serves) )
```
SQL：
```sql
SELECT DISTINCT
	pizzeria 
FROM
	( SELECT * FROM eats WHERE `name` = 'Amy' OR `name` = 'Fay' ) AS r1
	NATURAL JOIN ( SELECT * FROM serves WHERE price < 10 ) AS r2;
```
```
+----------------+
| pizzeria       |
+----------------+
| Little Caesars |
| Straw Hat      |
| New York Pizza |
+----------------+
```

### Q4
#### Find all pizzerias that serve at least one pizza for less than $10 that both Amy and Fay eat. 
Symbols：
```
π_{pizzeria} (
  σ_{price<10} (Serves)
  ⨝ (
    ρ_{name=amyName} π_{pizza} σ_{name='Amy'} (Eats)
    ⨝ 
    π_{pizza} σ_{name='Fay'} (Eats) 
    )
)
```
SQL：
```sql
SELECT DISTINCT
	pizzeria 
FROM
	( SELECT * FROM serves WHERE price < 10 ) AS r1
	NATURAL JOIN (
		( SELECT pizza FROM eats WHERE `name` = 'Amy' ) AS r2
		NATURAL JOIN ( SELECT pizza FROM eats WHERE `name` = 'Fay' ) AS r3 
	);
```
```
+----------------+
| pizzeria       |
+----------------+
| Little Caesars |
+----------------+
```

### Q5
#### Find the names of all people who eat at least one pizza served by Dominos but who do not frequent Dominos.
Symbols：
```
π_{name} (
  Eats
    ⨝
  π_{pizza} σ_{pizzeria='Dominos'} (Serves)
} -
π_{name} σ_{pizzeria='Dominos'} (Frequents)
```
SQL：
```sql
SELECT DISTINCT
	`name` 
FROM
	eats
	NATURAL JOIN serves 
WHERE
	pizzeria = 'Dominos' 
	AND `name` NOT IN ( SELECT `name` FROM frequents WHERE pizzeria = 'Dominos' );
```
```
+------+
| name |
+------+
| Amy  |
| Ben  |
| Dan  |
| Eli  |
| Gus  |
+------+
```
