#!/usr/bin/env bash

pipenv install
pipenv run python -um bin.run config.ini -s 20180609 -e 20180630

