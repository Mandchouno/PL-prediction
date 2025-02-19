INSERT INTO pl.pl_fixtures (
    fixture_id,
    Season,
    season_sk,
    fixture_date,
    HomeTeam,
    AwayTeam,
    FullTimeResults,
    HomeGoals,
    AwayGoals,
    StandingDiff,
    HomeWins,
    AwayWins,
    HomeDraws,
    AwayDraws,
    AvgHomeGoals,
    AvgAwayGoals,
    AvgHomeShots,
    AvgAwayShots,
    AvgHomeShotsOnTarget,
    AvgAwayShotsOnTarget,
    AvgHomeCorners,
    AvgAwayCorners,
    AvgHomeGoalsConceded,
    AvgAwayGoalsConceded,
    AvgHomeShotsConceded,
    AvgAwayShotsConceded,
    load_date
)
SELECT
    s.fixture_id,
    s.Season,
    REPLACE(s.Season, '-', '') AS season_sk, -- Replace dashes in 'Season' to 'season_sk'
    CAST(s.[Date] AS DATE) AS fixture_date, -- Convert string date to DATE
    s.HomeTeam,
    s.AwayTeam,
    s.FullTimeResults,
    CAST(s.HomeGoals AS INT) AS HomeGoals, -- Ensure the HomeGoals are cast to INT
    CAST(s.AwayGoals AS INT) AS AwayGoals, -- Ensure the AwayGoals are cast to INT
    s.StandingDiff,
    s.HomeWins,
    s.AwayWins,
    s.HomeDraws,
    s.AwayDraws,
    s.AvgHomeGoals,
    s.AvgAwayGoals,
    s.AvgHomeShots,
    s.AvgAwayShots,
    s.AvgHomeShotsOnTarget,
    s.AvgAwayShotsOnTarget,
    s.AvgHomeCorners,
    s.AvgAwayCorners,
    s.AvgHomeGoalsConceded,
    s.AvgAwayGoalsConceded,
    s.AvgHomeShotsConceded,
    s.AvgAwayShotsConceded,
    GETDATE()
FROM stg.stg_fixtures s


-- WHERE s.fixture_id NOT IN (SELECT fixture_id FROM pl.pl_fixtures);
--
WHERE NOT EXISTS (
    SELECT fixture_id FROM pl.pl_fixtures p WHERE p.fixture_id = s.fixture_id
);
--
-- LEFT JOIN pl.pl_fixtures p ON p.fixture_id = s.fixture_id
-- WHERE p.fixture_id IS NULL;
--
--
-- WHERE (NOT EXISTS
--     (SELECT 1 AS Expr1
--     FROM pl.pl_fixtures p
--     WHERE (s.fixture_id = s.fixture_id)))
