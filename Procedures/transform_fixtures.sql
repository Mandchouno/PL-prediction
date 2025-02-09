
-- -- Insert data from CSV column into the target table
-- INSERT INTO pl.pl_fixtures (
--     fixture_id,
--     Season,
--     season_sk,
--     fixture_date,
--     HomeTeam,
--     AwayTeam,
--     FullTimeResults,
--     HomeGoals,
--     AwayGoals,
--     StandingDiff,
--     HomeWins,
--     AwayWins,
--     HomeDraws,
--     AwayDraws,
--     AvgHomeGoals,
--     AvgAwayGoals,
--     AvgHomeShots,
--     AvgAwayShots,
--     AvgHomeShotsOnTarget,
--     AvgAwayShotsOnTarget,
--     AvgHomeCorners,
--     AvgAwayCorners,
--     AvgHomeGoalsConceded,
--     AvgAwayGoalsConceded,
--     AvgHomeShotsConceded,
--     AvgAwayShotsConceded,
--     load_date
-- )

BULK INSERT pl.pl_fixtures
    FROM "C:\Users\tokam\Downloads\EPL_processed_results.csv"
    WITH
    (
	FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '0x0A'   --Use to shift the control to next row
    )