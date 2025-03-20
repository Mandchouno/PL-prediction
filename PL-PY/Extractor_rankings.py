
import pandas as pd
import pyodbc
from sqlalchemy import create_engine, text
import json

csvUrl = "https://raw.githubusercontent.com/yuliang419/football-predictor/6d8b6b6ed2ad049012c8d3192146dde8e7a6de93/data/EPL_Standings.csv?raw=true"

df = pd.read_csv(csvUrl)

data = df.to_json(orient="records")

rankings_list = json.loads(data)  # Convert JSON string to Python list

# Wrap inside a dictionary
wrapped_json = {"rankings": rankings_list}

# Convert back to JSON string
jsonData = json.dumps(wrapped_json, ensure_ascii=False)

# server = "master-vitam-aeternam.database.windows.net"
# database = "PL-prediction-azure"
# username = "CloudSA55a217df"
# password = "1234Mama!"
server = "."
database = "PL-prediction-db"
username = "lilian"
password = "12345678"
driver = "ODBC Driver 17 for SQL Server"
conn_str = f"mssql+pyodbc://{username}:{password}@{server}/{database}?driver={driver}"

engine = create_engine(conn_str)

try:
    with engine.begin() as connection:
        query = text("INSERT INTO src.src_team_rankings ([rankings], load_date) VALUES (:jsonData, SYSDATETIME())")
        connection.execute(query, {"jsonData": jsonData})  # Pass JSON as parameter
    print("✅ JSON data inserted successfully!")
except Exception as e:
    print(f"❌ Error inserting data: {e}")