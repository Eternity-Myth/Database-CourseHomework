# Database-CourseHomework

  UESTC Database course homework,using examples and tests from Stanford University's db course（电子科技大学《数据库原理及应用》课程作业，使用斯坦福大学DB课程的例子与练习）
  
  Codes are based on MySQL 5.7.22

# Assignment for Relational Algebra 2（This assignment contains 5 questions）

## Description

We've created a small sample database to use for this assignment. It contains four relations:
    
    Person(name, age, gender)       // name is a key
    
    Frequents(name, pizzeria)  // [name,pizzeria] is a key
    
    Eats(name, pizza)               // [name,pizza] is a key
    
    Serves(pizzeria, pizza, price)  // [pizzeria,pizza] is a key

# Assignment for SQL 1（This assignment contains 21 questions）

## Description

  You've started a new movie-rating website, and you've been collecting data on reviewers' ratings of various movies. There's not much data yet, but you can still try out some interesting queries. Here's the schema:

  Movie ( mID, title, year, director )
English: There is a movie with ID number mID, a title, a release year, and a director.

  Reviewer ( rID, name )
English: The reviewer with ID number rID has a certain name.

  Rating ( rID, mID, stars, ratingDate )
English: The reviewer rID gave the movie mID a number of stars rating (1-5) on a certain ratingDate.

# Assignment for SQL 2（This assignment contains 14 questions）

## Description

Students at your hometown high school have decided to organize their social network using databases. So far, they have collected information about sixteen students in four grades, 9-12. Here's the schema:

Highschooler ( ID, name, grade ) English: There is a high school student with unique ID and a given first name in a certain grade.

Friend ( ID1, ID2 ) English: The student with ID1 is friends with the student with ID2. Friendship is mutual, so if (123, 456) is in the Friend table, so is (456, 123).

Likes ( ID1, ID2 ) English: The student with ID1 likes the student with ID2. Liking someone is not necessarily mutual, so if (123, 456) is in the Likes table, there is no guarantee that (456, 123) is also present.

Instructions: Each problem asks you to write a query in SQL.

# Constraints Movie-Ratings Exercises

## Description

You will enhance the movie-ratings database that was also used for the SQL Movie-Ratings Query Exercises. In this set of exercises you will declare integrity constraints on the data, and you will verify that they are being enforced by the underlying database management system. You will experiment with several types of constraints: key constraints, non-null constraints, attribute-based andtuple-based check constraints, and referential integrity. A SQL file to set up the original schema and data for the movie-ratings database is downloadable here. You will be using the same data, but modifying the schema to add constraints. The original schema and data can be loaded as specified in the file into SQLite, MySQL, or PostgreSQL. ***However, currently MySQL does not enforce constraints (even though it accepts some of them syntactically). For these exercises, currently you must use SQLite or PostgreSQL.*** See our quick guide for installing and using all three systems.

## Note：This Experiment is based on PostGreSQL-11.0-1-windows-x64

# 参考资料

[1]. 《数据库系统及应用》.魏祖宽.电子工业出版社

[2]. 斯坦福大学的DB课程
