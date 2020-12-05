#!/usr/bin/bash

## What R packages are we using?

find $1 -maxdepth 1  -name '*R' -type f -print0 |
    xargs -0 grep -h 'library*' |
    sed 's/library//g' |
    sed 's/#//g' |
    sed 's/ //g' |
    sort |
    uniq|
    sed 's/(//g' |
    sed 's/)//g' 
