-- 01 uses a WHERE clause to show the cases in 'Spain' in March
SELECT name, DAY(whn), confirmed, deaths, recovered
FROM covid
WHERE name = 'Spain' AND MONTH(whn) = 3
ORDER BY whn;

-- 02 show cases confirmed for the day before
SELECT name, DAY(whn), confirmed, LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) AS dbf
FROM covid
WHERE name = 'Italy' AND MONTH(whn) = 3
ORDER BY whn;

-- 03 shows the number of new cases for each day, for Italy, for March
SELECT name, DAY(whn), confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)
FROM covid
WHERE name = 'Italy' AND MONTH(whn) = 3
ORDER BY whn;

-- 04 shows the number of new cases in Italy for each week, mondays only usiong LAG
SELECT name, DATE_FORMAT(whn,'%Y-%m-%d'), 
       confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) AS 'new this week' 
FROM covid
WHERE name = 'Italy' AND WEEKDAY(whn) = 0
ORDER BY whn;

-- 05 shows the number of new cases in Italy for each week, mondays only using JOIN
SELECT tw.name, DATE_FORMAT(tw.whn,'%Y-%m-%d'), tw.confirmed - lw.confirmed
FROM covid tw LEFT JOIN covid lw ON DATE_ADD(lw.whn, INTERVAL 1 WEEK) = tw.whn AND tw.name = lw.name
WHERE tw.name = 'Italy' AND WEEKDAY(tw.whn) = 0
ORDER BY tw.whn;

-- 06 shows the number of confirmed cases together with the world ranking for cases and for deaths
SELECT name, confirmed, RANK() OVER (ORDER BY confirmed DESC) rc, 
             deaths, RANK() OVER (ORDER BY deaths DESC) rd
FROM covid
WHERE whn = '2020-04-20'
ORDER BY confirmed DESC;

-- 07 show the infect rate ranking for each country. It nly includes countries with a population of at least 10 million
SELECT world.name, 
       ROUND(100000 * confirmed / population, 0) rate,
       RANK() OVER (ORDER BY confirmed / population) rank
FROM covid JOIN world ON covid.name = world.name
WHERE whn = '2020-04-20' AND population >= 10000000
ORDER BY population DESC;
