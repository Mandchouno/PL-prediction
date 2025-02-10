CREATE TABLE [pl].[pl_team_rankings]
(
	--[team_id] INT NOT NULL PRIMARY KEY
	--[ranking_id] INT NOT NULL PRIMARY KEY
	[SeasonSk] INT
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
	,[load_date] DATETIME2
)
