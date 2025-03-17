import pandas as pd

# Load the results data
df = pd.read_csv("PL-Classifier\\results_predictions.csv")  # Replace with the correct file path

# Dictionary to store team standings
standings = {}

# Process each match
for _, row in df.iterrows():
    season = row["Season"]
    home_team = row["HomeTeam"]
    away_team = row["AwayTeam"]
    home_goals = row["HomeGoals"]
    away_goals = row["AwayGoals"]
    result = row["FTR"]  # H, A, D

    for team in [home_team, away_team]:
        if (season, team) not in standings:
            standings[(season, team)] = {"Pld": 0, "W": 0, "D": 0, "L": 0,
                                         "GF": 0, "GA": 0, "GD": 0, "Pts": 0}

    # Update matches played, goals scored, and goals conceded
    standings[(season, home_team)]["Pld"] += 1
    standings[(season, away_team)]["Pld"] += 1
    standings[(season, home_team)]["GF"] += home_goals
    standings[(season, away_team)]["GF"] += away_goals
    standings[(season, home_team)]["GA"] += away_goals
    standings[(season, away_team)]["GA"] += home_goals

    # Assign wins, draws, losses, and points
    if result == "H":
        standings[(season, home_team)]["W"] += 1
        standings[(season, away_team)]["L"] += 1
        standings[(season, home_team)]["Pts"] += 3
    elif result == "A":
        standings[(season, away_team)]["W"] += 1
        standings[(season, home_team)]["L"] += 1
        standings[(season, away_team)]["Pts"] += 3
    else:  # Draw
        standings[(season, home_team)]["D"] += 1
        standings[(season, away_team)]["D"] += 1
        standings[(season, home_team)]["Pts"] += 1
        standings[(season, away_team)]["Pts"] += 1

# Convert dictionary to DataFrame
standings_df = pd.DataFrame([(season, team, stats["Pld"], stats["W"], stats["D"], stats["L"],
                              stats["GF"], stats["GA"], stats["GF"] - stats["GA"], stats["Pts"])
                             for (season, team), stats in standings.items()],
                            columns=["Season", "Team", "Pld", "W", "D", "L", "GF", "GA", "GD", "Pts"])

# Sort by season, points, goal difference, and goals scored
standings_df.sort_values(by=["Season", "Pts", "GD", "GF"], ascending=[True, False, False, False], inplace=True)

# Assign positions
standings_df["Pos"] = standings_df.groupby("Season").cumcount() + 1

# Assign qualification/relegation based on position
def assign_status(pos):
    if pos == 1:
        return "Champions"
    elif pos <= 4:
        return "Qualification for the Champions League"
    elif pos == 5:
        return "Qualification for the Europa League"
    elif pos >= 18:
        return "Relegation"
    return "Not Applicable"

standings_df["Qualification or relegation"] = standings_df["Pos"].apply(assign_status)

# Reorder columns
standings_df = standings_df[["Season", "Pos", "Team", "Pld", "W", "D", "L", "GF", "GA", "GD", "Pts", "Qualification or relegation"]]

# Save to CSV
standings_df.to_csv("standings_predicted.csv", index=False)

# Display the final standings
# print(standings_df)
