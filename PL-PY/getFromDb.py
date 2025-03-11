import pyodbc

server = "master-vitam-aeternam.database.windows.net"
database = "PL-prediction-azure"
username = "mandiSql"
password = "mandiTeo25"
driver = "ODBC Driver 17 for SQL Server"
conn_str = f"Driver={driver};Server=tcp:{server},1433;Database={database};UID={username};PWD={password};Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30"

def get_conn():
    return pyodbc.connect(conn_str)


def get_all_fixtures():
    rows = []
    with get_conn() as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM pl.pl_fixtures")

        for row in cursor.fetchall():
            rows.append(f"{row.fixture_id},{row.Season},{row.season_sk},{row.fixture_date},{row.HomeTeam},{row.AwayTeam},{row.FullTimeResults},{row.HomeGoals},{row.AwayGoals},{row.StandingDiff},{row.HomeWins},{row.AwayWins},{row.HomeDraws},{row.AwayDraws},{row.AvgHomeGoals},{row.AvgAwayGoals},{row.AvgHomeShots},{row.AvgAwayShots},{row.AvgHomeShotsOnTarget},{row.AvgAwayShotsOnTarget},{row.AvgHomeCorners},{row.AvgAwayCorners},{row.AvgHomeGoalsConceded},{row.AvgAwayGoalsConceded},{row.AvgHomeShotsConceded},{row.AvgAwayShotsConceded},{row.load_date}")
        return rows
    
    
def get_all_standings():
    rows = []
    with get_conn() as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM pl.pl_team_rankings")

        for row in cursor.fetchall():
            rows.append(f"{row.SeasonSk},{row.Position},{row.Team},{row.GamesPlayed},{row.Wins},{row.Draws},{row.Losses},{row.GoalsFor},{row.GoalsAgainst},{row.GoalDifference},{row.Points},{row.load_date}")
            
        return rows


def get_fixture(fixture_id):
    with get_conn() as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM pl.pl_fixtures WHERE fixture_id = ?", fixture_id)

        row = cursor.fetchone()
        return f"{row.fixture_id}, {row.Season}, {row.HomeTeam}, {row.AwayTeam}, {row.FullTimeResults}"
    
    
# print(get_all_fixtures())
# print(get_all_standings())
# print(get_fixture(111))
