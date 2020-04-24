-- 01 lists id and title of the films where the yr is 1962
SELECT id, title
FROM movie
WHERE yr = 1962;

-- 02 gives year of 'Citizen Kane' released.
SELECT yr
FROM movie
WHERE title ='Citizen Kane';

-- 03 lists all of the Star Trek movies, include the id, title and yr (include the words Star Trek in the title). Order results by year.
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;

-- 04 id of 'Glenn Close'
SELECT id
FROM actor
WHERE name = 'Glenn Close';

-- 05 id of the film 'Casablanca'
SELECT id
FROM movie
WHERE title = 'Casablanca';

-- 06 obtains the cast list for 'Casablanca'
SELECT name
FROM actor JOIN casting ON actor.id = casting.actorid
WHERE movieid = 11768;

-- 07 gets the cast list for the film 'Alien'
SELECT name
FROM actor JOIN casting ON actor.id = casting.actorid
           JOIN movie ON casting.movieid = movie.id
WHERE title = 'Alien';

-- 08 lists films in which 'Harrison Ford' has appeared
SELECT title
FROM movie JOIN casting ON movie.id = casting.movieid
           JOIN actor ON casting.actorid = actor.id
WHERE actor.name = 'Harrison Ford';

-- 09 lists the films where 'Harrison Ford' has appeared, but not in the starring role
SELECT title
FROM movie JOIN casting ON movie.id = casting.movieid
           JOIN actor ON casting.actorid = actor.id
WHERE actor.name = 'Harrison Ford' AND casting.ord > 1;


-- 10 lists the films together with the leading star for all 1962 films.
SELECT title, name
FROM movie JOIN casting ON movie.id = casting.movieid
           JOIN actor ON casting.actorid = actor.id
 WHERE movie.yr = 1962 AND casting.ord = 1;

-- 11 lists the busiest years for 'Rock Hudson', show the year and the number of more than 2 movies.
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id = casting.movieid
        JOIN actor   ON casting.actorid = actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;

-- 12 lists the film title and the leading actor for all of the films 'Julie Andrews' played in
SELECT title, name
FROM movie JOIN casting ON movie.id = casting.movieid AND casting.ord = 1
           JOIN actor ON casting.actorid = actor.id
WHERE movie.id IN (SELECT movieid 
                   FROM casting
                   WHERE actorid IN (SELECT id FROM actor
                                     WHERE name='Julie Andrews'));

-- 13 gets a list, in alphabetical order, of actors who've had at least 15 starring roles
SELECT name
FROM actor
JOIN casting ON actor.id = casting.actorid 
WHERE casting.ord = 1
GROUP BY actor.name
HAVING COUNT(*) >= 15
ORDER BY actor.name;

-- 14 lists the films released in the year 1978 ordered by the number of actors in the cast, then by title
SELECT title, COUNT(*)
FROM movie JOIN casting ON movie.id = casting.movieid
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(*) DESC, title;

-- 15 lists all the people who have worked with 'Art Garfunkel'
SELECT name
FROM actor JOIN casting ON actor.id = casting.actorid
WHERE casting.movieid IN (SELECT movie.id
                          FROM movie JOIN casting ON movie.id = casting.movieid
                                     JOIN actor ON casting.actorid = actor.id
                          WHERE name = 'Art Garfunkel')
    AND name != 'Art Garfunkel';
