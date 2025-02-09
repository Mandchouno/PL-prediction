CREATE TABLE [pl].[pl_team_rankings]
(
	--[team_id] INT NOT NULL PRIMARY KEY
	--[ranking_id] INT NOT NULL PRIMARY KEY
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
)
