#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

# 总进球数（获胜队伍）
echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

# 总进球数（所有队伍）
echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games")"

# 平均进球数（获胜队伍），保留所有小数位
echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"

# 平均进球数（获胜队伍），保留两位小数
echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT round(AVG(winner_goals)::numeric, 2) FROM games")"

# 平均进球数（所有队伍），保留所有小数位
echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games")"

# 单场比赛最高进球数
echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(winner_goals) FROM games")"

# 获胜队伍进球超过2个的比赛场次
echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals > 2")"

# 2018年冠军队伍名称
echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT t.name FROM games g INNER JOIN teams t ON g.winner_id = t.team_id WHERE year = 2018 AND round = 'Final'")"

# 2014年八分之一决赛队伍列表
echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT DISTINCT t.name FROM games g INNER JOIN teams t ON g.winner_id = t.team_id OR g.opponent_id = t.team_id WHERE year = 2014 AND round = 'Eighth-Final' ORDER BY name")"

# 历史冠军队伍列表
echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT DISTINCT t.name FROM games g INNER JOIN teams t ON g.winner_id = t.team_id ORDER BY name")"

# 所有冠军队伍及年份
echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT year, t.name AS champion FROM games g INNER JOIN teams t ON g.winner_id = t.team_id WHERE round = 'Final' ORDER BY year")"

# 以 "Co" 开头的队伍列表
echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name FROM teams WHERE name LIKE 'Co%' ORDER BY name")"
