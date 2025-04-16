CREATE TABLE [pl].[match_results]
(
	[fixture_id] INT NOT NULL PRIMARY KEY
	, Season VARCHAR (100)
	, [season_sk] INT
	, [Date] DATE
	, HomeTeam VARCHAR (100)
	, AwayTeam VARCHAR (100)
	, FTHG FLOAT
	, FTAG FLOAT
	, FTR VARCHAR (100)
	, HT_match_played INT
	, HT_current_standing INT
	, HT_past_standing INT
	, HT_past_goal_diff INT
	, HT_past_win_rate FLOAT
	, HT_goal_for FLOAT
	, HT_goal_against FLOAT
	, HT_goal_diff FLOAT
	, HT_win_rate_season FLOAT
	, AT_match_played INT
	, AT_current_standing INT
	, AT_past_standing INT
	, AT_past_goal_diff INT
	, AT_past_win_rate FLOAT
	, AT_goal_for FLOAT
	, AT_goal_against FLOAT
	, AT_goal_diff FLOAT
	, AT_win_rate_season FLOAT
	, HT_3_win_streak INT
	, HT_5_win_streak INT
	, HT_3_lose_Streak INT
	, HT_5_lose_Streak INT
	, AT_3_win_streak INT
	, AT_5_win_streak INT
	, AT_3_lose_Streak INT
	, AT_5_lose_Streak INT
	, HT_5_win_rate FLOAT
	, AT_5_win_rate FLOAT
	, current_standing_diff INT
	, past_standing_diff INT
	, past_goal_diff_diff INT
	, past_win_rate_diff FLOAT
	, win_rate_season_diff FLOAT
	, goal_diff_diff FLOAT
	, load_date DATETIME
)
