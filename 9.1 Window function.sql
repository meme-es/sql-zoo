-- 01 shows the lastName, party and votes for the constituency 'S14000024' in 2017
SELECT lastName, party, votes
FROM ge
WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY votes DESC;

-- 02 shows the party and RANK for constituency S14000024 in 2017. List the output by party
SELECT party, votes, RANK() OVER (ORDER BY votes DESC) as posn
FROM ge
WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY party;


-- 03 shows the ranking of each party in S14000021 in each year. Include yr, party, votes and ranking (the party with the most votes is 1)
SELECT yr, party, votes, RANK() OVER (PARTITION BY yr ORDER BY votes DESC) as posn
FROM ge
WHERE constituency = 'S14000021'
ORDER BY party, yr;

-- 04 shows the ranking of each party in Edinburgh in 2017. The winners are shown first, then ordered by constituency
SELECT constituency, party, votes, RANK() OVER (PARTITION BY constituency  ORDER BY votes DESC )as posn
FROM ge
WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
    AND yr  = 2017
ORDER BY posn, constituency ASC;

-- 05 shows the parties that won for each Edinburgh constituency in 2017
SELECT el.constituency, el.party FROM (SELECT yr, party, votes, constituency, 
                                       RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) AS posn
                                       FROM ge
                                       WHERE constituency BETWEEN 'S14000021' AND 'S14000026' AND yr  = 2017 
                                      ) AS el
where posn = 1;

-- 06 shows how many seats for each party in Scotland in 2017
SELECT party, COUNT(*) 
FROM (SELECT party, RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) AS posn
      FROM ge 
      WHERE LEFT(constituency, 1) = 'S'
          AND yr  = 2017) AS tab
WHERE posn = 1
GROUP BY party;
