-- 01 number of stops in the database
SELECT COUNT(*)
FROM stops;

-- 02 id value for the stop 'Craiglockhart'
SELECT id
FROM stops
WHERE name = 'Craiglockhart';

-- 03 id and the name for the stops on the '4' 'LRT' service
SELECT id, name
FROM stops JOIN route ON stops.id = route.stop
WHERE route.num = '4' AND route.company = 'LRT';

-- 04 gives the number of routes that visit either London Road (149) or Craiglockhart (53)
SELECT company, num, COUNT(*)
FROM route WHERE stop = 149 OR stop = 53
GROUP BY company, num
HAVING COUNT(*) = 2;

-- 05 shows the services from Craiglockhart to London Road
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON a.company = b.company AND a.num = b.num
WHERE a.stop = 53 AND b.stop = 149;

-- 06 shows the services from Craiglockhart to London Road
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON a.company = b.company AND a.num = b.num
             JOIN stops stopa ON a.stop = stopa.id
             JOIN stops stopb ON b.stop = stopb.id
WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'London Road';

-- 07 gives a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON a.company = b.company AND a.num = b.num
WHERE a.stop = 115 AND b.stop = 137;


-- 08 gives a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
SELECT a.company, a.num
FROM route a JOIN route b ON a.company = b.company AND a.num = b.num
             JOIN stops stopa ON a.stop = stopa.id
             JOIN stops stopb ON b.stop = stopb.id
WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'Tollcross';

-- 09 list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself
SELECT stopa.name, a.company, a.num
FROM route a JOIN route b ON a.company = b.company AND a.num = b.num
             JOIN stops stopa ON a.stop = stopa.id
             JOIN stops stopb ON b.stop = stopb.id
WHERE stopb.name = 'Craiglockhart'
ORDER BY a.num, a.pos;

-- 10 routes involving two buses that can go from Craiglockhart to Lochend
SELECT ra.num, ra.company, ra.s_transfer, rb.num, rb.company 
FROM (SELECT stopa.name, a.company, a.num, b.stop, stopb.name as s_transfer
      FROM route a JOIN route b  ON  (select a.company = b.company AND a.num = b.num)
		               JOIN stops stopa ON a.stop = stopa.id
		               JOIN stops stopb ON b.stop = stopb.id
      WHERE stopa.name = 'Craiglockhart'
      ORDER BY a.num, a.pos
) AS ra
JOIN (SELECT stopa.name, a.company, a.num, b.stop
      FROM route a JOIN route b  ON a.company = b.company AND a.num = b.num
		               JOIN stops stopa ON a.stop = stopa.id
		               JOIN stops stopb ON b.stop = stopb.id
      WHERE stopa.name='Lochend'
      ORDER BY a.num, a.pos) as rb
ON (ra.stop=rb.stop)
ORDER BY ra.num, ra.s_transfer, rb.num;
