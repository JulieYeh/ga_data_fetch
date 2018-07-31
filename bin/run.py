import os
import sys
is_local = os.path.split(os.getcwd())[-1] == 'bin'

if is_local:
    print('!!!! local execution !!!!')
    from context import ga_data_fetch

from configparser import ConfigParser
from datetime import datetime, timedelta
from ga_data_fetch import GA
from ga_data_fetch import log_formatter
from typing import List
import argparse
import logging
from logging.handlers import TimedRotatingFileHandler
from pathlib import Path


def parse_args(argv: List[str]) -> argparse.Namespace:
    
    YESTERDAY = (datetime.today().date() + timedelta(-1)).strftime('%Y%m%d')
    
    parser = argparse.ArgumentParser('ga_data_fetch')
    parser.add_argument('config', help='config file')
    parser.add_argument('-s', '--start-date', dest='start_date', default=YESTERDAY)
    parser.add_argument('-e', '--end-date', dest='end_date', default=YESTERDAY)

    args = parser.parse_args(argv[1:])
    return args


def main(argv: List[str]) -> int:
    
    # Arg parser
    args = parse_args(argv)

    # Config
    if args.config:
        config = ConfigParser()
        config.read(args.config)
        config_now = config['DEFAULT']

        SQL_PATH = config_now['sql_path']
        PROJECTID = config_now['projectid']
        OUTPUT_PATH = config_now['output_path']
        PRIVATE_KEY = config_now['private_key']
        LOG_FILE = config_now['log_file']
    elif not Path(args.config).is_file():
        raise ValueError(f'{args.config} not found for config file.')
    else:
        raise ValueError('Config file required.')
    
    START_DATE = args.start_date  # '20180101'
    END_DATE = args.end_date  # '20180101'
    
    # Logging
    log_file = TimedRotatingFileHandler(
        LOG_FILE, when='D', interval=1, backupCount=30)
    log_file.setFormatter(log_formatter)
    logging.getLogger('ga_data_fetch').addHandler(log_file)

    # Run
    tic = datetime.now()
    ga = GA(projectid=PROJECTID, sql_path=SQL_PATH, private_key=PRIVATE_KEY)

    # print(ga._sql_list)
    ga.save_bq_csv(OUTPUT_PATH, START_DATE, END_DATE, 'all')

    print('-------------------------------------------'
          f'\nDone. (Time elapsed: {datetime.now() - tic})')
    
    return 0


if __name__ == '__main__':
    if is_local:
        sys.exit(main([__file__, '../config.ini', '-s', '20180730', '-e', '20180730']))
    else:
        sys.exit(main(sys.argv))
