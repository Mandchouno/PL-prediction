DECLARE @JsonData NVARCHAR(MAX);

-- Read JSON data from source table
SELECT @JsonData = [rankings]
FROM src.src_team_rankings
ORDER BY [load_date] ASC;

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
    ,[load_date]
)

SELECT 
    REPLACE(JSON_VALUE(rankings.value, '$.Season'), '-', '') AS season_sk
    ,JSON_VALUE(rankings.value, '$.Pos ')
    ,JSON_VALUE(rankings.value, '$.Team')
    ,JSON_VALUE(rankings.value, '$.Pld')
    ,JSON_VALUE(rankings.value, '$.W')
    ,JSON_VALUE(rankings.value, '$.D')
    ,JSON_VALUE(rankings.value, '$.L')
    ,JSON_VALUE(rankings.value, '$.GF')
    ,JSON_VALUE(rankings.value, '$.GA')
    ,JSON_VALUE(rankings.value, '$.GD')
    ,JSON_VALUE(rankings.value, '$.Pts')
    ,JSON_VALUE(rankings.value, '$."Qualification or relegation"')
    ,GETDATE() AS load_date

FROM OPENJSON(@JsonData, '$.rankings') AS rankings;