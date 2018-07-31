#!/usr/bin/env bash

pipenv install
cd ./bin
pipenv run python -u run.py ../config.ini

