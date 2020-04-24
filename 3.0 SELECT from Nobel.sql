-- 01 displays Nobel prizes for 1950
SELECT *
FROM nobel
WHERE yr = 1950;

-- 02 shows who won the 1962 prize for Literature
SELECT winner
FROM nobel
WHERE yr = 1962 AND subject = 'Literature';

-- 03 show the year and subject that won 'Albert Einstein' his prize
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein';

-- 04 gives the name of the 'Peace' winners since the year 2000, including 2000
SELECT winner
FROM nobel
WHERE yr >= 2000 AND subject = 'Peace';

-- 05 shows all details of the Literature prize winners for 1980 to 1989 inclusive
SELECT *
FROM nobel
WHERE yr BETWEEN 1980 AND 1989 AND subject = 'Literature';

-- 06 shows all details of the presidential winners: Theodore Roosevelt, Woodrow Wilson, Jimmy Carter, Barack Obama
SELECT *
FROM nobel
WHERE winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Barack Obama',
                  'Jimmy Carter');


-- 07 show the winners with first name John
SELECT winner
FROM nobel
WHERE winner LIKE 'John %';

-- 08 show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984
SELECT *
FROM nobel
WHERE yr = 1980 AND subject = 'Physics' 
    OR yr = 1984 AND subject = 'Chemistry';

-- 09 show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine
SELECT * FROM nobel
WHERE yr = 1980 AND subject NOT IN('Chemistry', 'Medicine');

-- 10 shows all attributes of people who won a 'Medicine' prize before 1910 together with winners of a 'Literature' prize after or in 2004
SELECT *
FROM nobel
WHERE subject = 'Medicine' AND yr < 1910 
    OR subject = 'Literature' AND yr >= 2004;

-- 11 finds all details of the prize won by PETER GRÜNBERG
SELECT * FROM nobel
WHERE winner = 'Peter Grünberg';

-- 12 finds all details of the prize won by EUGENE O'NEILL
SELECT * FROM nobel
WHERE winner = 'Eugene O''neill';

-- 13 winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order
SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE 'Sir %'
ORDER BY yr DESC, winner;

-- 14 shows the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last
SELECT winner, subject
FROM nobel
WHERE yr = 1984
ORDER BY subject IN ('Physics','Chemistry'), subject, winner;
