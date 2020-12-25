#!/usr/bin/env bash

# This finds all the numbers in a passed tex file

grep -E '[0-9]{1,4}' $1
