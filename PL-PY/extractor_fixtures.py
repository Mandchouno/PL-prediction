
import pandas as pd
import pyodbc
from sqlalchemy import create_engine, text
import json

csvUrl = "https://github.com/yuliang419/football-predictor/blob/6d8b6b6ed2ad049012c8d3192146dde8e7a6de93/data/EPL_processed_results.csv?raw=true"

df = pd.read_csv(csvUrl)
if "Unnamed: 0" in df.columns:
    df.rename(columns={"Unnamed: 0": "fixture_id"}, inplace=True)
data = df.to_json(orient="records")

fixtures_list = json.loads(data)  # Convert JSON string to Python list

# Wrap inside a dictionary
wrapped_json = {"fixtures": fixtures_list}

# Convert back to JSON string
jsonData = json.dumps(wrapped_json, ensure_ascii=False)

# Save to file
# jsonData = json.dumps(wrapped_json, ensure_ascii=False, indent=4)

# json_filename = "fixtures.json"
# with open(json_filename, "w", encoding="utf-8") as json_file:
#     json_file.write(jsonData)

server = "master-vitam-aeternam.database.windows.net"
database = "PL-prediction-azure"
username = "CloudSA55a217df"
password = "1234Mama!"
driver = "ODBC Driver 17 for SQL Server"
conn_str = f"mssql+pyodbc://{username}:{password}@{server}/{database}?driver={driver}"
#conn_str = "Server=tcp:master-vitam-aeternam.database.windows.net,1433;Initial Catalog=PL-prediction-azure;Persist Security Info=False;User ID=CloudSA55a217df;Password=1234Mama!;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
engine = create_engine(conn_str)

# with engine.connect() as connection:
#     query = text("INSERT INTO src.src_fixtures ([fixtures], load_date) VALUES (:jsonData, SYSDATETIME())")
#     connection.execute(query, {"jsonData": jsonData})

try:
    with engine.begin() as connection:  # Use `begin()` to ensure commit
        query = text("INSERT INTO src.src_fixtures ([fixtures], load_date) VALUES (:jsonData, SYSDATETIME())")
        connection.execute(query, {"jsonData": jsonData})  # Pass JSON as parameter
    print("✅ JSON data inserted successfully!")
except Exception as e:
    print(f"❌ Error inserting data: {e}")