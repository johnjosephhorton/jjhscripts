#!/usr/bin/sh

# Takes a CSV file as input and gives some statistics about each column.
# Depends on datamash

numrows=$(cat $1 | wc -l)
printf "Number of Rows: $numrows\n"

numdistinctrows=$(cat $1 | sort | uniq | wc -l)
printf "Number of Distinct Rows:$numdistinctrows\n"

numfields=$(awk -F "\"*,\"*" -v j=$i 'NR==1{print NF}' $1)

for i in $(seq 1 $numfields);
do
    printf "\n"
    printf "##########################################################\n"
    printf "Column Name:"
    awk -F "\"*,\"*" -v j=$i 'NR==1{print $j}' $1
    printf "Number of unique values:"
    awk -F "\"*,\"*" -v j=$i  'NR>1{print $j}' $1 | sort | uniq | wc -l
    numValues=$(awk -F "\"*,\"*" -v j=$i  'NR>1{print $j}' $1 | wc -l)
    numNonBlank=$(awk -F "\"*,\"*" -v j=$i  'NR>1{print $j}' $1 | sed '/^\s*$/d' | wc -l)
    numMissing=$(echo "$numValues - $numNonBlank" | bc -l)
    printf "Num Empty/Missing:" 
    printf $numMissing
    printf "\n"
    printf "Top 3 Values (sorted): " 
    awk -F "\"*,\"*" -v j=$i  'NR>1{print $j}' $1 | sort | head -n 3 | tr '\n' ' '
    printf "\n"
    printf "Bottom 3 Values (sorted): " 
    awk -F "\"*,\"*" -v j=$i  'NR>1{print $j}' $1 | sort | tail -n 3 | tr '\n' ' '
    printf "\n"
    printf "Most common values (top 5, if that many):\n"
    awk -F "\"*,\"*" -v j=$i  'NR>1{print $j}' $1 | sort | uniq -c | sort -n -k1 -r  | head -n 5
    printf "Lead common values (top 5, if that many):\n"
    awk -F "\"*,\"*" -v j=$i  'NR>1{print $j}' $1 | sort | uniq -c | sort -n -k1 -r  | tail -n 5
    printf "Summary Stats:\n"
    printf "N \t min \t med \t mean \t max \t stdev\n"
    (awk -F "\"*,\"*" -v j=$i  'NR>1{print $j}' $1 |
	 datamash -R 2 count 1 min 1 median 1 mean 1 max 1 sstdev 1 2> /dev/null || printf "Not a number\n")
    printf "Summary Stats (missing excluded):\n"
    printf "min \t med \t mean \t max \t stdev\n"
    (awk -F "\"*,\"*" -v j=$i  'NR>1{print $j}' $1 | sed '/^\s*$/d' |
	 datamash -R 2 --no-strict count 1 min 1 median 1 mean 1 max 1 sstdev 1 2> /dev/null || printf "Not a number\n")
    printf "##########################################################"
    printf "\n"
done

