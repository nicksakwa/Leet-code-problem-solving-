import pandas as pd
def find_consecutive_numbers(logs: pd.Dataframe)->pd.Dataframe:
    logs['next_1'] = logs['num'].shift(-1)
    logs['next_2'] = logs['num'].shift(-2)
    mask=(logs['num'] == logs['next_1']) & (logs['num'] == logs['next_2'])
    unique_consecutive = logs.loc[mask, 'num'].unique()
    return pd.Dataframe({'consecutive_numbers': unique_consecutive})