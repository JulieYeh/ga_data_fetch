import pandas as pd
from pandas_gbq import read_gbq
# import logging
from datetime import datetime, timedelta
import numpy as np
from pathlib import Path
import os
from .resources import resourceid


class GA:

    _initiated = False
    configuration = {
        'query': {
            "useQueryCache": True
        }
    }

    def __init__(self, projectid, sql_path, private_key):
        self.projectid = projectid
        self._sql_path = os.path.abspath(sql_path)
        self.private_key = os.path.abspath(private_key)

        if not self._initiated:
            self.initiate(self._sql_path)

    def initiate(self, sql_path):
        print('Initiale GA...')
        print(f'Load SQL from "{sql_path}"')
        self._sql_list = self._load_sql(sql_path)
        self._initiated = True

    def save_bq_csv(self, resource_name, output_path, start_date, end_date):

        output = Path(output_path)
        if not output.is_dir():
            raise ValueError(f'`output` must be a folder path ({output})')

        res = {}

        for table, sql in self._sql_list.items():
            for data_date in self._dates_between(start_date, end_date):
                out_file = f'{data_date}-{resource_name}-{table}.csv'
                out_path = output / out_file
                print(f'Saving file: {str(out_path)}')
                res[out_file] = self.save_bq_csv_oneday(
                    sql, resourceid[resource_name], data_date, output=str(out_path))

        res = pd.DataFrame.from_dict(
            {'key': list(res.keys()), 'val': list(res.values())})
        print(res)

    def save_bq_csv_oneday(self, sql, resourceid, data_date, output, dialect='standard'):

        try:
            df = read_gbq(
                sql.format(start_date=data_date, end_date=data_date,
                           resourceid=resourceid),
                private_key=self.private_key,
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

    def _load_sql(self, sql_path):
        '''Read sql to dict'''
        sql_files = Path(sql_path).resolve().glob('*.sql')

        sqls = {}
        for _, file_path in enumerate(sql_files):
            with open(file_path, 'r', encoding='utf8') as file:
                try:
                    sql_str = file.read()
                    sqls[file_path.stem] = sql_str
                except Exception as e:
                    print(e)

        return sqls
