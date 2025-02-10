    CREATE TABLE #temp_rankings (
        [Season] VARCHAR (100)
        ,[Position] INT 
        ,[Team] VARCHAR (100)
        ,[GamesPlayed] INT
        ,[Wins] INT
        ,[Draws] INT
        ,[Losses] INT
        ,[GoalsFor] INT
        ,[GoalsAgainst] INT
        ,[GoalDifference] INT
        ,[Points] INT
        ,[Qualification or relegation] VARCHAR (200)
    );

BULK INSERT #temp_rankings
    FROM "C:\Users\tokam\Documents\Big Projects\Year 2024\Machine Learning\Premier league prediction\data\Data sets\set1\EPL_Standings.csv"
    WITH
    (
	FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '0x0A'   --Use to shift the control to next row
    )


INSERT INTO pl.pl_team_rankings (
    [SeasonSk]
    ,[Position] 
    ,[Team]
    ,[GamesPlayed]
    ,[Wins]
    ,[Draws]
    ,[Losses]
    ,[GoalsFor]
    ,[GoalsAgainst]
    ,[GoalDifference]
    ,[Points]
    ,[Qualification or relegation]
    ,[load_date]  -- Add the load_date column
)
SELECT 
    REPLACE(Season, '-', '') AS season_sk
    ,Position 
    ,Team
    ,GamesPlayed
    ,Wins
    ,Draws
    ,Losses
    ,GoalsFor
    ,GoalsAgainst
    ,GoalDifference
    ,Points
    ,[Qualification or relegation],
    GETDATE() AS load_date  -- Get the current timestamp for load_date
FROM #temp_rankings;

-- Clean up the temporary table after use
DROP TABLE #temp_rankings;