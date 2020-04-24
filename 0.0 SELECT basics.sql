-- 01 shows the population of Germany
SELECT population
FROM world
WHERE name = 'Germany';

-- 02 Shows the name and the population for 'Sweden', 'Norway' and 'Denmark'
SELECT name, population
FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');

-- 03 shows the country and the area for countries with an area between 200,000 and 250,000
SELECT name, area
FROM world
WHERE area BETWEEN 200000 AND 250000;
