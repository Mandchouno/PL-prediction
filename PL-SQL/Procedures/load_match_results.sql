DECLARE @JsonData NVARCHAR(MAX);

SELECT @JsonData = [fixtures]
FROM src.src_fixtures
ORDER BY [load_date] ASC;

INSERT INTO pl.match_results (
    fixture_id
	, Season
	, season_sk
	, Date
	, HomeTeam
	, AwayTeam
	, FTHG
	, FTAG
	, FTR
	, HT_match_played
	, HT_current_standing
	, HT_past_standing
	, HT_past_goal_diff
	, HT_past_win_rate
	, HT_goal_for
	, HT_goal_against
	, HT_goal_diff
	, HT_win_rate_season
	, AT_match_played
	, AT_current_standing
	, AT_past_standing
	, AT_past_goal_diff
	, AT_past_win_rate
	, AT_goal_for
	, AT_goal_against
	, AT_goal_diff
	, AT_win_rate_season
	, HT_3_win_streak
	, HT_5_win_streak
	, HT_3_lose_Streak
	, HT_5_lose_Streak
	, AT_3_win_streak
	, AT_5_win_streak
	, AT_3_lose_Streak
	, AT_5_lose_Streak
	, HT_5_win_rate
	, AT_5_win_rate
	, current_standing_diff
	, past_standing_diff
	, past_goal_diff_diff
	, past_win_rate_diff
	, win_rate_season_diff
	, goal_diff_diff
    , load_date
)


SELECT
    JSON_VALUE(fixtures.value, '$.fixture_id'),
    JSON_VALUE(fixtures.value, '$.season'),
    REPLACE(JSON_VALUE(fixtures.value, '$.season'), '-', ''),
    JSON_VALUE(fixtures.value, '$.Date'),
    JSON_VALUE(fixtures.value, '$.HomeTeam'),
    JSON_VALUE(fixtures.value, '$.AwayTeam'),
    JSON_VALUE(fixtures.value, '$.FTHG'),
    JSON_VALUE(fixtures.value, '$.FTAG'),
    JSON_VALUE(fixtures.value, '$.FTR'),
    JSON_VALUE(fixtures.value, '$.HT_match_played'),
    JSON_VALUE(fixtures.value, '$.HT_current_standing'),
    JSON_VALUE(fixtures.value, '$.HT_past_standing'),
    JSON_VALUE(fixtures.value, '$.HT_past_goal_diff'),
    JSON_VALUE(fixtures.value, '$.HT_past_win_rate'),
    JSON_VALUE(fixtures.value, '$.HT_goal_for'),
    JSON_VALUE(fixtures.value, '$.HT_goal_against'),
    JSON_VALUE(fixtures.value, '$.HT_goal_diff'),
    JSON_VALUE(fixtures.value, '$.HT_win_rate_season'),
    JSON_VALUE(fixtures.value, '$.AT_match_played'),
    JSON_VALUE(fixtures.value, '$.AT_current_standing'),
    JSON_VALUE(fixtures.value, '$.AT_past_standing'),
    JSON_VALUE(fixtures.value, '$.AT_past_goal_diff'),
    JSON_VALUE(fixtures.value, '$.AT_past_win_rate'),
    JSON_VALUE(fixtures.value, '$.AT_goal_for'),
    JSON_VALUE(fixtures.value, '$.AT_goal_against'),
    JSON_VALUE(fixtures.value, '$.AT_goal_diff'),
    JSON_VALUE(fixtures.value, '$.AT_win_rate_season'),
    JSON_VALUE(fixtures.value, '$.HT_3_win_streak'),
    JSON_VALUE(fixtures.value, '$.HT_5_win_streak'),
    JSON_VALUE(fixtures.value, '$.HT_3_lose_Streak'),
    JSON_VALUE(fixtures.value, '$.HT_5_lose_Streak'),
    JSON_VALUE(fixtures.value, '$.AT_3_win_streak'),
    JSON_VALUE(fixtures.value, '$.AT_5_win_streak'),
    JSON_VALUE(fixtures.value, '$.AT_3_lose_Streak'),
    JSON_VALUE(fixtures.value, '$.AT_5_lose_Streak'),
    JSON_VALUE(fixtures.value, '$.HT_5_win_rate'),
    JSON_VALUE(fixtures.value, '$.AT_5_win_rate'),
    JSON_VALUE(fixtures.value, '$.current_standing_diff'),
    JSON_VALUE(fixtures.value, '$.past_standing_diff'),
    JSON_VALUE(fixtures.value, '$.past_goal_diff_diff'),
    JSON_VALUE(fixtures.value, '$.past_win_rate_diff'),
    JSON_VALUE(fixtures.value, '$.win_rate_season_diff'),
    JSON_VALUE(fixtures.value, '$.goal_diff_diff'),
    SYSDATETIME()
FROM OPENJSON(@JsonData, '$.fixtures') AS fixtures
-- WHERE JSON_VALUE(fixtures.value, '$.FTHG') IS NOT NULL;

WHERE NOT EXISTS (
    SELECT fixture_id FROM pl.match_results p WHERE p.fixture_id = JSON_VALUE(fixtures.value, '$.fixture_id')
);

-- WHERE JSON_VALUE(fixtures.value, '$.FTHG') IS NOT NULL
--   AND NOT EXISTS (
--       SELECT fixture_id FROM pl.match_results p WHERE p.fixture_id = fixtures.fixture_id
--   );