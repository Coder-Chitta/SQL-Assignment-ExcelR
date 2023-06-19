# Assignment 2

use assignment;

-- 1. select all employees in department 10 whose salary is greater than 3000. [table: employee]
select * from employee
where deptno = 10 and salary > 3000;


-- 2. The grading of students based on the marks they have obtained is done as follows:

/* 40 to 50 -> Second Class
 50 to 60 -> First Class
 60 to 80 -> First Class
 80 to 100 -> Distinctions */

select * from students;

-- a. How many students have graduated with first class?
SELECT COUNT(*) AS first_class_count
FROM students
WHERE marks >= 50 AND marks <= 80;

--  b. How many students have obtained distinction? [table: students]
SELECT COUNT(*) AS Distinction_count
FROM students
WHERE marks >= 80 AND marks <= 100;


-- 3. Get a list of city names from station with even ID numbers only. Exclude duplicates from your answer.[table: station]
select * from station;

select distinct city from station
where id % 2 = 0;

-- 4. Find the difference between the total number of city entries in the table and the number of distinct city entries in the table. 
-- In other words, if N is the number of city entries in station, and N1 is the number of distinct city names in station, 
-- write a query to find the value of N-N1 from station.
-- table: station

SELECT COUNT(city) AS total_entries, COUNT(DISTINCT city) AS distinct_entries, 
COUNT(city) - COUNT(DISTINCT city) AS difference
FROM station;


-- 5. Answer the following
-- a. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates. [Hint: Use RIGHT() / LEFT() methods ]
select distinct city from station
where lower(left(city,1)) in ('a','e','i','o','u');

-- b. Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
select distinct city from station
where lower(left(city,1)) in ('a','e','i','o','u') and lower(right(city,1)) in ('a','e','i','o','u');

-- c. Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
select distinct city from station
where lower(left(city,1)) not in ('a','e','i','o','u');

-- d. Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates. [table: station]
select distinct city from station
where lower(left(city,1)) not in ('a','e','i','o','u') and lower(right(city,1)) not in ('a','e','i','o','u');


-- 6. Write a query that prints a list of employee names having a salary greater than $2000 per month 
-- who have been employed for less than 36 months. Sort your result by descending order of salary. [table: emp]

SELECT CONCAT(first_name, ' ', last_name) AS employee_name, salary, DATE_FORMAT(hire_date, '%Y-%m') AS employment_month
FROM emp
WHERE salary > 2000.00 AND  DATEDIFF(CURDATE(), hire_date) < 36
ORDER BY salary DESC;


-- 7. How much money does the company spend every month on salaries for each department? [table: employee]
SELECT deptno, SUM(salary) AS total_salary
FROM employee
GROUP BY deptno;

-- 8. How many cities in the CITY table have a Population larger than 100000. [table: city]
select count(*) as city_count
from city
where population > 100000;

-- 9. What is the total population of California? [table: city]
select district,sum(population) as total_population_california
from city
where district = 'California';

-- 10. What is the average population of the districts in each country? [table: city]
SELECT countrycode, district, AVG(population) AS average_population
FROM city
GROUP BY countrycode, district;

-- 11. Find the ordernumber, status, customernumber, customername and comments for all orders that are ‘Disputed=  [table: orders, customers]

SELECT o.orderNumber, o.status, o.customerNumber, c.customerName, o.comments
FROM orders o
INNER JOIN customers c ON o.customerNumber = c.customerNumber
WHERE o.status = 'Disputed';

