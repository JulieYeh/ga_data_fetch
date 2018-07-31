import os
import sys
is_local = os.path.split(os.getcwd())[-1] == 'bin'

if is_local:
    from context import ga_data_fetch

from ga_data_fetch import GA
from typing import List
import argparse
from datetime import datetime, timedelta
from configparser import ConfigParser


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
    if args.config:
        config = ConfigParser()
        config.read(args.config)
        config_now = config['DEFAULT']

        SQL_PATH = config_now['sql_path']
        PROJECTID = config_now['projectid']
        OUTPUT_PATH = config_now['output_path']
        PRIVATE_KEY = config_now['private_key']
    else:
        raise ValueError('Config file required.')
    
    start_date = args.start_date  # '20180101'
    end_date = args.end_date  # '20180101'
    
    # Run
    tic = datetime.now()
    ga = GA(projectid=PROJECTID, sql_path=SQL_PATH, private_key=PRIVATE_KEY)

    # print(ga._sql_list)
    ga.save_bq_csv('website', OUTPUT_PATH, start_date, end_date)

    print('-------------------------------------------'
          f'\nDone. (Time elapsed: {datetime.now() - tic})')
    
    return 0


if __name__ == '__main__':
    if is_local:
        sys.exit(main([__file__, '../config.ini', '-s', '20180314', '-e', '20180314']))
    else:
        sys.exit(main(sys.argv))
