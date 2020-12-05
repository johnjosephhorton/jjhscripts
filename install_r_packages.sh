#!/usr/bin/bash

# Takes list of packages (from stdout) and see if they are installed - if not, installs them one by one.

[ $# -ge 1 -a -f "$1" ] && input="$1" || input="-"
  
cat $input | xargs -I {} Rscript -e 'if(("{}" %in% rownames(installed.packages())) == FALSE) {install.packages("{}")}'

