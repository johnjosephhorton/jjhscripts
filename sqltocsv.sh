#!/usr/bin/env bash

cat $1 | tr "\n" " " | tr ";" " " | xargs -I {} psql -c '\copy ({}) TO STDOUT WITH CSV HEADER'
