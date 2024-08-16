#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# 清空表格
$PSQL "TRUNCATE TABLE games, teams"

# 读取 CSV 文件
cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS; do
  # 跳过第一行标题
  if [[ $YEAR != "year" ]]; then
    # 插入队伍（如果不存在）
​    TEAM_NAME="$WINNER"
​    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$TEAM_NAME'")
​    if [[ -z $TEAM_ID ]]; then
​      INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$TEAM_NAME')")
​      if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]; then
​        echo "Inserted team: $TEAM_NAME"
​      fi
​    fi
​    TEAM_NAME="$OPPONENT"
​    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$TEAM_NAME'")
​    if [[ -z $TEAM_ID ]]; then
​      INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$TEAM_NAME')")
​      if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]; then
​        echo "Inserted team: $TEAM_NAME"
​      fi
​    fi

    # 获取队伍 ID
​    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
​    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    # 插入比赛
​    INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
​    if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]; then
​      echo "Inserted game: $YEAR, $ROUND, $WINNER, $OPPONENT, $WINNER_GOALS, $OPPONENT_GOALS"
​    fi
  fi
done