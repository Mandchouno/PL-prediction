DECLARE @JsonData NVARCHAR(MAX);

-- Read JSON data from source table
SELECT @JsonData = [fixtures]
FROM src.src_fixtures
ORDER BY [load_date] ASC;

-- Parse JSON array and insert each transaction into the destination table
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
    load_date
)

SELECT
    JSON_VALUE(fixtures.value, '$.fixture_id'),
    JSON_VALUE(fixtures.value, '$.Season'),
    JSON_VALUE(fixtures.value, '$.Date'),
    JSON_VALUE(fixtures.value, '$.HomeTeam'),
    JSON_VALUE(fixtures.value, '$.AwayTeam'),
    JSON_VALUE(fixtures.value, '$.FTR'),
    JSON_VALUE(fixtures.value, '$.HomeGoals'),
    JSON_VALUE(fixtures.value, '$.AwayGoals'),
    JSON_VALUE(fixtures.value, '$.StandingDiff'),
    JSON_VALUE(fixtures.value, '$.HomeWins'),
    JSON_VALUE(fixtures.value, '$.AwayWins'),
    JSON_VALUE(fixtures.value, '$.HomeDraws'),
    JSON_VALUE(fixtures.value, '$.AwayDraws'),
    JSON_VALUE(fixtures.value, '$.AvgHomeGoals'),
    JSON_VALUE(fixtures.value, '$.AvgAwayGoals'),
    JSON_VALUE(fixtures.value, '$.AvgHomeShots'),
    JSON_VALUE(fixtures.value, '$.AvgAwayShots'),
    JSON_VALUE(fixtures.value, '$.AvgHomeShotsOnTarget'),
    JSON_VALUE(fixtures.value, '$.AvgAwayShotsOnTarget'),
    JSON_VALUE(fixtures.value, '$.AvgHomeCorners'),
    JSON_VALUE(fixtures.value, '$.AvgAwayCorners'),
    JSON_VALUE(fixtures.value, '$.AvgHomeGoalsConceded'),
    JSON_VALUE(fixtures.value, '$.AvgAwayGoalsConceded'),
    JSON_VALUE(fixtures.value, '$.AvgHomeShotsConceded'),
    JSON_VALUE(fixtures.value, '$.AvgAwayShotsConceded'),
    SYSDATETIME()
FROM OPENJSON(@JsonData, '$.fixtures') AS fixtures;