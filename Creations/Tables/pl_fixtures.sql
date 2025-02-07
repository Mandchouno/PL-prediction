CREATE TABLE [pl].[pl_fixtures]
(
	[fixture_id] INT NOT NULL PRIMARY KEY
	,[home_team] VARCHAR (100)
	,[away_team] VARCHAR (100)
	,[home_team_goals] INT
	,[away_team_goals] INT
	,[load_date] DATETIME2
)
