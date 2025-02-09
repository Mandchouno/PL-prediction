
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

CREATE TABLE #temp_fixtures (
        fixture_id INT,
        Season VARCHAR(20),
		Date DATE,
		HomeTeam VARCHAR(100),
		AwayTeam VARCHAR(100),
		FullTimeResults CHAR(1),
		HomeGoals INT,
		AwayGoals INT,
		StandingDiff INT,
		HomeWins FLOAT,
		AwayWins FLOAT,
		HomeDraws FLOAT,
		AwayDraws FLOAT,
		AvgHomeGoals FLOAT,
		AvgAwayGoals FLOAT,
		AvgHomeShots FLOAT,
		AvgAwayShots FLOAT,
		AvgHomeShotsOnTarget FLOAT,
		AvgAwayShotsOnTarget FLOAT,
		AvgHomeCorners FLOAT,
		AvgAwayCorners FLOAT,
		AvgHomeGoalsConceded FLOAT,
		AvgAwayGoalsConceded FLOAT,
		AvgHomeShotsConceded FLOAT,
		AvgAwayShotsConceded FLOAT
    );

BULK INSERT #temp_fixtures
    FROM "C:\Users\tokam\Downloads\EPL_processed_results.csv"
    WITH
    (
	FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '0x0A'   --Use to shift the control to next row
    )


INSERT INTO stg.stg_fixtures (
    fixture_id,
    Season,
    Date,
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
    load_date  -- Add the load_date column
)
SELECT 
    *, GETDATE() AS load_date  -- Get the current timestamp for load_date
FROM #temp_fixtures;

-- Clean up the temporary table after use
DROP TABLE #temp_fixtures;