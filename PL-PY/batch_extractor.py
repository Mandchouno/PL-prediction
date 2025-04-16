import json
import requests
from bs4 import BeautifulSoup

import pandas as pd
from sqlalchemy import create_engine, text


GITHUB_URL = "https://github.com/woongbinchoi/English-Premier-League-Prediction/tree/master/data/train_data/results"
RAW_URL_BASE = "https://raw.githubusercontent.com/woongbinchoi/English-Premier-League-Prediction/master/data/train_data/results/"

def get_file_links():
    response = requests.get(GITHUB_URL)
    soup = BeautifulSoup(response.text, 'html.parser')
    file_links = []
    
    for link in soup.find_all('a', href=True):
        href = link['href']
        if href.endswith('.csv'):
            file_name = href.split('/')[-1]
            # we will consider all files
            # if file_name ==  '2011-2012.csv': break
            if file_name not in file_links : file_links.append(file_name)
    
    return file_links

def download_and_process_files(file_links):
    jsonData = []
    fixture_id = 0
    
    for file_name in file_links:
        file_url = RAW_URL_BASE + file_name
        df = pd.read_csv(file_url)
        df = df.where(pd.notna(df), 0)
        season = file_name[:4] + '-' + file_name[7:9]  # Convert filename format to 'YYYY-YY'
        df['season'] = season
        df['fixture_id'] = range(fixture_id, fixture_id + len(df))  # Assign fixture_id
        fixture_id += len(df)
        jsonData.extend(df.to_dict(orient='records'))

    return jsonData

jsonData = download_and_process_files(get_file_links())

# we leave out other data
# csvUrl = "https://github.com/yuliang419/football-predictor/blob/6d8b6b6ed2ad049012c8d3192146dde8e7a6de93/data/EPL_processed_results.csv?raw=true"
# df = pd.read_csv(csvUrl)
# if "Unnamed: 0" in df.columns:
#     # delete column
#     df = df.drop('Unnamed: 0', axis=1)
#     # df.rename(columns={"Unnamed: 0": "fixture_id"}, inplace=True)
# fixture_id = jsonData[-1]['fixture_id']+1
# df['fixture_id'] = range(fixture_id, fixture_id + len(df))
# data = df.to_json(orient="records")
# jsonData.extend(json.loads(data))

jsonData = json.dumps({"fixtures": jsonData}, ensure_ascii=False)

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
    with engine.begin() as connection:  # Use `begin()` to ensure commit
        query = text("INSERT INTO src.src_fixtures ([fixtures], load_date) VALUES (:jsonData, SYSDATETIME())")
        connection.execute(query, {"jsonData": jsonData})  # Pass JSON as parameter
    print("✅ JSON data inserted successfully!")
except Exception as e:
    print(f"❌ Error inserting data: {e}")