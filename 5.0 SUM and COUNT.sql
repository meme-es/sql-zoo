-- 01 shows the total population of the world
SELECT SUM(population)
FROM world;

-- 02 list all the continents, once each.
SELECT DISTINCT continent
FROM world;

-- 03 gives the total GDP of Africa
SELECT SUM(gdp)
FROM world
WHERE continent = 'Africa';

-- 04 countries that have an area of at least 1000000
SELECT COUNT(*)
FROM world
WHERE area >= 1000000;

-- 05 total population of ('Estonia', 'Latvia', 'Lithuania')
SELECT SUM(population)
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania');

-- 06 shows the continent and number of countries
SELECT continent, COUNT(*)
FROM world
GROUP BY continent;

-- 07 shows the continent and number of countries with populations of at least 10 million
SELECT continent, COUNT(*)
FROM world
WHERE population > 10000000
GROUP BY continent;

-- 08 lists the continents that have a total population of at least 100 million
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) > 100000000;
