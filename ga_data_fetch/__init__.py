__version__ = '0.0.1'

from .resources import resourceid
from datetime import datetime, timedelta
from pandas_gbq import read_gbq
from pathlib import Path
import logging
import numpy as np
import os
import pandas as pd
import sys

log_console = logging.StreamHandler(sys.stderr)
log_formatter = logging.Formatter('[%(asctime)s] [%(levelname)s] %(message)s')
log_console.setFormatter(log_formatter)
default_logger = logging.getLogger(__name__)
default_logger.setLevel(logging.DEBUG)
default_logger.addHandler(log_console)


class GA:

    _initiated = False

    def __init__(self, projectid, sql_path, private_key, ga_config=None):
        self.projectid = projectid
        self._sql_path = os.path.abspath(sql_path)
        self.private_key = os.path.abspath(private_key)
        if ga_config is None:
            self.configuration = {
                'query': {
                    "useQueryCache": True
                }
            }

        if not self._initiated:
            self.initiate(self._sql_path)

    def initiate(self, sql_path):
        default_logger.info('Initiale GA...')
        default_logger.info(f"Load SQL from '{sql_path}'")
        self._sql_list = self._load_sql(sql_path)
        self._initiated = True

    def save_bq_csv(self, output_path, start_date, end_date, resource_name='all'):
        """[summary]
        
        [description]
        
        Arguments:
            resource_name {str} -- {'all', 'website', 'cardaily', 'mobilebank', 'loanrwd', 'mkp'}
            output_path {str} -- [description]
            start_date {str} -- [description]
            end_date {str} -- [description]
        
        Raises:
            ValueError -- [description]
        """

        if resource_name not in ('all', 'website', 'cardaily', 'mobilebank', 'loanrwd', 'mkp'):
            raise ValueError(f"'{resource_name}' is not valid for resource_name")

        if resource_name == 'all':
            resource_name_list = ['website', 'cardaily', 'mobilebank', 'loanrwd', 'mkp']
        else:
            resource_name_list = [resource_name]

        output = Path(output_path).absolute()

        if not output.is_dir():
            raise ValueError(f'`output` must be a folder path ({output})')

        default_logger.info("Get data for following settings:")
        default_logger.info(f'Resources: {resource_name_list}')
        default_logger.info(f'Dates: {list(self._dates_between(start_date, end_date))}')

        res = {}
        for data_date in self._dates_between(start_date, end_date):
            for resource in resource_name_list:
                for table, sql in self._sql_list.items():
                    out_file = f'{data_date}-{resource}-{table}.csv'
                    out_path = output / out_file

                    default_logger.info(f"Saving file: '{str(out_path)}'")
                    
                    res[out_file] = self.save_bq_csv_oneday(
                        sql, resource, data_date, output=str(out_path))

        res = pd.DataFrame.from_dict(
            {'key': list(res.keys()), 'val': list(res.values())})
        default_logger.info(res)

    def save_bq_csv_oneday(self, sql_template, resource_name, data_date, output, dialect='standard'):

        sql = sql_template.format(start_date=data_date, end_date=data_date,
                                  resourceid=resourceid[resource_name])
        try:
            df = read_gbq(
                sql,
                private_key=self.private_key,
                project_id=self.projectid,
                configuration=self.configuration,
                dialect=dialect
            )

            if df.shape[0] == 0:
                default_logger.warning(f'No record (project_id: {self.projectid}, resource: {resourceid[resource_name]})'
                                       f'{sql}') 
            else:
                df.to_csv(output, index=False)
            
            return df.shape[0]
        except Exception as e:
            default_logger.info(e)
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
