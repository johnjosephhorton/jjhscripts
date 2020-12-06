#!/usr/bin/env bash

# Takes a CSV file as input and gives some statistics about each column.
# Depends on datamash and csvtool being installed. 

numrows=$(cat $1 | wc -l)
printf "Number of Rows: $numrows\n"

numdistinctrows=$(cat $1 | sort | uniq | wc -l)
printf "Number of Distinct Rows:$numdistinctrows\n"

headers=$(awk -F "\"*,\"*" -v j=$i 'NR==1{print $j}' $1)
echo $headers | wc -l

numfields=$(awk -F "\"*,\"*" -v j=$i 'NR==1{print NF}' $1)

for i in $(seq 1 $numfields);
do
    printf "\n"
    printf "##########################################################\n"
    printf "Column Name:" &&  awk -v FPAT='[^,]*|"[^"]+"' -v j=$i 'NR==1{print $j}' $1    
    numValues=$(csvtool col $i $1 | tail -n +2 | wc -l)
    printf "Number of rows:" && printf $numValues && printf "\n"
    numNonBlank=$(csvtool col $i $1 | sed '/^\s*$/d' | tail -n +2 | wc -l)
    numMissing=$(echo "$numValues - $numNonBlank" | bc -l)
    printf "Num Empty or Missing:"
    echo $numMissing
    printf "\n"
    printf "Top 3 Values (sorted): " 
    csvtool col $i $1 | tail -n +2 | sort | head -n 3 | tr '\n' ' '
    printf "\n"
    printf "Bottom 3 Values (sorted): " 
    csvtool col $i $1 | tail -n +2 | sort | tail -n 3 | tr '\n' ' '
    printf "\n"
    printf "Most common values (top 5, if that many):\n"
    csvtool col $i $1 | tail -n +2 | sort | uniq -c | sort -n -k1 -r  | head -n 5
    printf "Least common values (top 5, if that many):\n"
    csvtool col $i $1 | tail -n +2 | sort | uniq -c | sort -n -k1 -r  | tail -n 5
    printf "Summary Stats:\n"
    printf "N \t min \t med \t mean \t max \t stdev\n"
    (csvtool col $i $1 | tail -n +2 | datamash -R 2 count 1 min 1 median 1 mean 1 max 1 sstdev 1 2> /dev/null || printf "Not a number\n")
    printf "Summary Stats (missing excluded):\n"
    printf "N \t min \t med \t mean \t max \t stdev\n"
    (csvtool col $i $1 | tail -n +2 | sed '/^\s*$/d' | datamash -R 2 --no-strict count 1 min 1 median 1 mean 1 max 1 sstdev 1 2> /dev/null || printf "Not a number\n")
    printf "##########################################################"
    printf "\n"
done

