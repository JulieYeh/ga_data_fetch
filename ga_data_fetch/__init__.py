import pandas as pd
from pandas_gbq import read_gbq
import logging
from datetime import datetime, timedelta
import numpy as np
from typing import List
import argparse
from io import *

# Config
SQL_PATH = './sql/'
START_DATE = '20180710'
END_DATE = '20180710'

private_key = "../key/TS-Official-Website-d438f1c2b14d.json"


class GA:

    initiated = False
    configuration = {
        'query': {
            "useQueryCache": True
        }
    }

    def __init__(self, projectid, sql_path):
        self.projectid = projectid
        self._sql_path = sql_path

        if not _initiated:
            self.initiate(self.sql_path)

    def initiate(self, sql_path):
        self._sql_list = self._load_sql(_sql_path)

    def save_bq_csv(filename, sql, start_date, end_date, output_folder):
        
        output = Path(output_folder)
        if not output.is_dir():
            raise ValueError(f'`output` must be a folder path ({output})')
        
        res = {}
        for data_date in _dates_between(start_date, end_date):
            out_file = f'{filename}_{data_date}.csv'
            out_path = output / out_file
            print(f'Saving file: {str(out_path)}')
            res[out_file] = save_bq_csv_oneday(sql, data_date, output=str(out_path))
        
        return res

    def save_bq_csv_oneday(self, sql, data_date, output, dialect='standard'):

        try:
            df = read_gbq(
                sql.format(start_date=data_date, end_date=data_date),
                private_key=KEY,
                project_id=self.projectid,
                configuration=self.configuration,
                dialect=dialect
            )

            df.to_csv(output, index=False)
            return df.shape[0]
        except Exception as e:
            print(e)
            return np.NaN

    def _dates_between(self, start_date, end_date):
    
        def _date_range(date1, date2):
            for n in range(int((date2 - date1).days) + 1):
                yield date1 + timedelta(n)
        
        start_date = datetime.strptime(start_date, '%Y%m%d').date()
        end_date = datetime.strptime(end_date, '%Y%m%d').date()
        
        for dt in _date_range(start_date, end_date):
            yield dt.strftime("%Y%m%d")

