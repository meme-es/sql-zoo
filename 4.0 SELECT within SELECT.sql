-- 01 list each country name where the population is larger than that of 'Russia'
SELECT name
FROM world
WHERE population > (SELECT population FROM world
                    WHERE name='Russia');

-- 02 shows the countries in Europe with a per capita GDP greater than 'United Kingdom'
SELECT name FROM world
WHERE continent = 'Europe'
     AND gdp/population > (SELECT gdp/population FROM world
                           WHERE name='United Kingdom');

-- 03 lists the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country
SELECT name, continent
FROM world
WHERE continent IN (SELECT continent FROM world
                    WHERE name IN ('Argentina', 'Australia'))
ORDER BY name;

-- 04 shows the name and the population of countries has a population that is more than Canada but less than Poland
SELECT name, population
FROM world
WHERE population > (SELECT population FROM world WHERE name = 'Canada')
      AND population < (SELECT population FROM world WHERE name = 'Poland');

-- 05 shows the name and the population as a percentaje of the population of Germany of each country in Europe
SELECT name, CONCAT(ROUND(population/(SELECT population FROM world WHERE name = 'Germany')*100, 0), '%')
FROM world
WHERE continent = 'Europe';

-- 06 gives the name oft countries with a GDP greater than every country in Europe
SELECT name
FROM world
WHERE gdp > ALL(SELECT gdp FROM world WHERE continent = 'Europe' AND gdp > 0);

-- 07 finds the largest country (by area) in each continent, show the continent, the name and the area
SELECT continent, name, area
FROM world x
WHERE area >= ALL (SELECT area FROM world y WHERE y.continent=x.continent);

-- 08 lists each continent and the name of the country that comes first alphabetically
SELECT continent, name
FROM world x
WHERE name <= ALL (SELECT name FROM world y WHERE y.continent=x.continent);

-- 09 finds the name, continent and population of countries associated with continents where all countries have a populations <= 25000000
SELECT name, continent, population
FROM world
WHERE continent NOT IN (SELECT DISTINCT continent FROM world WHERE population > 25000000);

-- 10 searches for the countries that have populations more than three times their neighbours in the same continent
SELECT name, continent
FROM world x
WHERE population > ALL (SELECT population * 3 FROM world y
                        WHERE x.continent = y.continent
                            AND x.name <> y.name);
