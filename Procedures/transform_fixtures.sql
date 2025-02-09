
-- -- Insert data from CSV column into the target table
-- INSERT INTO stg.stg_fixtures (
--     Season,
--     Date,
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

BULK INSERT stg.stg_fixtures
    FROM "C:\Users\tokam\Downloads\EPL_processed_results.csv"
    WITH
    (
	FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '0x0A'   --Use to shift the control to next row
    )