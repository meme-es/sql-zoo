-- 01 shows the matchid and player name for all goals scored by German players
SELECT matchid, player
FROM goal
WHERE teamid = 'GER';

-- 02 shows id, stadium, team1, team2 for just game 1012
SELECT id, stadium, team1, team2
FROM game
WHERE id = 1012;

-- 03 shows the player, teamid, stadium and mdate for every German goal
SELECT player, teamid, stadium, mdate
FROM game JOIN goal ON game.id = goal.matchid
WHERE teamid = 'GER';

-- 04 show the team1, team2 and player for every goal scored by a player called Mario as first name
SELECT team1, team2, player
FROM game JOIN goal ON game.id = goal.matchid
WHERE player LIKE 'Mario%';

-- 05 shows player, teamid, coach, gtime for all goals scored in the first 10 minutes
SELECT player, teamid, coach, gtime
FROM goal JOIN eteam ON goal.teamid = eteam.id
WHERE gtime <= 10;

-- 06 lists the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach
SELECT mdate, teamname
FROM game JOIN eteam ON game.team1 = eteam.id
WHERE coach = 'Fernando Santos';

-- 07 lists the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
SELECT player
FROM game JOIN goal ON game.id = goal.matchid
WHERE stadium = 'National Stadium, Warsaw';

-- 08 shows the name of all players who scored a goal against Germany
SELECT DISTINCT player
FROM game JOIN goal ON game.id = goal.matchid
WHERE (game.team1 ='GER' OR game.team2='GER')
    AND goal.teamid <> 'GER';

-- 09 shows teamname and the total number of goals scored
SELECT teamname, COUNT(*)
FROM eteam JOIN goal ON eteam.id = goal.teamid
GROUP BY eteam.teamname;

-- 10 shows the stadium and the number of goals scored in each stadium.
SELECT stadium, COUNT(*)
FROM game JOIN goal ON game.id = goal.matchid
GROUP BY game.stadium;

-- 11 shows the matchid, date and the number of goals scored involving 'POL' team
SELECT matchid, mdate, COUNT(*)
FROM game JOIN goal ON game.id = goal.matchid
WHERE game.team1 = 'POL' OR game.team2 = 'POL'
GROUP BY game.id, game.mdate;

-- 12 shows matchid, match date and the number of goals scored by 'GER'
SELECT matchid, mdate, COUNT(*)
FROM game JOIN goal ON game.id = goal.matchid
WHERE goal.teamid = 'GER'
GROUP BY game.id, game.mdate;

-- 13 lists every match with the goals scored by each team. Sorted by mdate, matchid, team1 and team2
SELECT mdate,
       team1, SUM(CASE WHEN goal.teamid = team1 THEN 1 ELSE 0 END) AS score1,
       team2, SUM(CASE WHEN goal.teamid = team2 THEN 1 ELSE 0 END) AS score2
FROM game LEFT JOIN goal ON game.id = goal.matchid
GROUP BY game.mdate, game.id, game.team1, game.team2;
