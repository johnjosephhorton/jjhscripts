#!/usr/bin/bash

# This takes a LaTeX file as an input, strips out LaTeX stuff
# and then uses ispell to find the spelling mistakes. 

sed 's/\\[a-zA-Z]*//g; s/{[^}]*}//g; s/\[[^}]*\]//g' $1 > /tmp/temp.txt
ispell -a < /tmp/temp.txt | grep ^\& | awk '{print $2}' | sort | uniq
