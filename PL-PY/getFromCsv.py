import json
import pandas as pd

Urls = ["https://github.com/yuliang419/football-predictor/blob/6d8b6b6ed2ad049012c8d3192146dde8e7a6de93/data/EPL_processed_results.csv?raw=true", 
        "https://raw.githubusercontent.com/yuliang419/football-predictor/6d8b6b6ed2ad049012c8d3192146dde8e7a6de93/data/EPL_Standings.csv?raw=true"]

def getCsv(csvUrl):
    df = pd.read_csv(csvUrl)

    if "results" in csvUrl :
        if "Unnamed: 0" in df.columns:
            df.rename(columns={"Unnamed: 0": "fixture_id"}, inplace=True)
        data = df.to_json(orient="records")
        # Convert JSON string to Python list
        fixtures_list = json.loads(data)
        # Wrap inside a dictionary
        wrapped_json = {"fixtures": fixtures_list}
        # Convert back to JSON string
        jsonData = json.dumps(wrapped_json, ensure_ascii=False)

    elif "Standings" in csvUrl:
        data = df.to_json(orient="records")
        rankings_list = json.loads(data) 
        wrapped_json = {"rankings": rankings_list}
        jsonData = json.dumps(wrapped_json, ensure_ascii=False)

    return jsonData

results = getCsv(Urls[0])
standings = getCsv(Urls[1])
