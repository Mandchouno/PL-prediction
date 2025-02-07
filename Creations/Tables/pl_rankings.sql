CREATE TABLE [pl].[pl_team_rankings]
(
	[team_id] INT NOT NULL PRIMARY KEY
	,[team_name] VARCHAR (100)
	,[position_id] INT
	,[goals_scored] INT
	,[goals_conceeded] INT
	,[goal_difference] INT
)
