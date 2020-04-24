-- 01 shows name, continent and population of all countries
SELECT name, continent, population
FROM world;

-- 02 shows the name for the countries that have a population of at least 200 million
SELECT name
FROM world
WHERE population >= 200000000;

-- 03 gives the name and the per capita GDP for those countries with a population of at least 200 million
SELECT name, GDP/population
FROM world
WHERE population >= 200000000;

-- 04 shows the name and population in millions for the countries of the continent 'South America'
SELECT name, population/1000000
FROM world
WHERE continent = 'South America';

-- 05 shows the name and population for France, Germany, Italy
SELECT name, population
FROM world
WHERE name IN ('France', 'Germany', 'Italy');

-- 06 shows the countries which have a name that includes the word 'United'
SELECT name
FROM world
WHERE name LIKE '%United%';

-- 07 shows name, population and area by countries that are big by area or big by population 
SELECT name, population, area
FROM world
WHERE area > 3000000 OR population > 250000000;

-- 08 shows name, population and area by the countries that more than 3 million area or more than 250 million population, but not both
SELECT name, population, area
FROM world
WHERE area > 3000000 XOR population > 250000000;

-- 09 shows the name and population in millions and the GDP in billions for the countries of the continent 'South America'
SELECT name, ROUND(population/1000000, 2), ROUND(gdp/1000000000, 2)
FROM world
WHERE continent = 'South America';

-- 10 shows the name and per-capita GDP for those countries with a GDP of at least one trillion. Round this value to the nearest 1000
SELECT name, ROUND(gdp/population, -3)
FROM world
WHERE gdp >= 1000000000000;

-- 11 shows the name and capital where the name and the capital have the same number of characters
SELECT name, capital
FROM world
WHERE LENGTH(name) = LENGTH(capital);

-- 12 shows the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word
SELECT name, capital
FROM world
WHERE name <> capital
    AND LEFT(name, 1) = LEFT(capital, 1);

-- 13 finds the country that has all the vowels and no spaces in its name
SELECT name FROM world
WHERE name LIKE '%a%' 
    AND name LIKE '%e%' 
    AND name LIKE '%i%' 
    AND name LIKE '%o%' 
    AND name LIKE '%u%'
    AND name NOT LIKE '% %';
