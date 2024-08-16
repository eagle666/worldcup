#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# 查询所有队伍
echo "All teams:"
$PSQL "SELECT name FROM teams ORDER BY name"

# 查询所有比赛
echo "All games:"
$PSQL "SELECT year, round, winner, opponent, winner_goals, opponent_goals FROM (SELECT g.year, g.round, t1.name AS winner, t2.name AS opponent, g.winner_goals, g.opponent_goals FROM games g LEFT JOIN teams t1 ON g.winner_id = t1.team_id LEFT JOIN teams t2 ON g.opponent_id = t2.team_id) AS full_game ORDER BY year, round"

# 查询特定年份的比赛
echo "Games in 2018:"
$PSQL "SELECT year, round, winner, opponent, winner_goals, opponent_goals FROM (SELECT g.year, g.round, t1.name AS winner, t2.name AS opponent, g.winner_goals, g.opponent_goals FROM games g LEFT JOIN teams t1 ON g.winner_id = t1.team_id LEFT JOIN teams t2 ON g.opponent_id = t2.team_id) AS full_game WHERE year = 2018 ORDER BY year, round"

# 查询特定队伍的比赛
echo "France games:"
$PSQL "SELECT year, round, winner, opponent, winner_goals, opponent_goals FROM (SELECT g.year, g.round, t1.name AS winner, t2.name AS opponent, g.winner_goals, g.opponent_goals FROM games g LEFT JOIN teams t1 ON g.winner_id = t1.team_id LEFT JOIN teams t2 ON g.opponent_id = t2.team_id) AS full_game WHERE winner = 'France' OR opponent = 'France' ORDER BY year, round"

# 查询特定队伍赢得的比赛
echo "France wins:"
$PSQL "SELECT year, round, winner, opponent, winner_goals, opponent_goals FROM (SELECT g.year, g.round, t1.name AS winner, t2.name AS opponent, g.winner_goals, g.opponent_goals FROM games g LEFT JOIN teams t1 ON g.winner_id = t1.team_id LEFT JOIN teams t2 ON g.opponent_id = t2.team_id) AS full_game WHERE winner = 'France' ORDER BY year, round"

# 查询特定队伍输掉的比赛
echo "France losses:"
$PSQL "SELECT year, round, winner, opponent, winner_goals, opponent_goals FROM (SELECT g.year, g.round, t1.name AS winner, t2.name AS opponent, g.winner_goals, g.opponent_goals FROM games g LEFT JOIN teams t1 ON g.winner_id = t1.team_id LEFT JOIN teams t2 ON g.opponent_id = t2.team_id) AS full_game WHERE opponent = 'France' AND winner != 'France' ORDER BY year, round"

# 查询特定队伍参加的所有比赛
echo "France all games:"
$PSQL "SELECT year, round, winner, opponent, winner_goals, opponent_goals FROM (SELECT g.year, g.round, t1.name AS winner, t2.name AS opponent, g.winner_goals, g.opponent_goals FROM games g LEFT JOIN teams t1 ON g.winner_id = t1.team_id LEFT JOIN teams t2 ON g.opponent_id = t2.team_id) AS full_game WHERE winner = 'France' OR opponent = 'France' ORDER BY year, round"