#!/usr/bin/env bash

if [ $2 == '' ]
then
    maxage=1
else
    maxage=$2
fi
git blame -c --date=raw $1 | sed 's/%//g' | awk 'BEGIN {} 
{
    if (NF > 5) {
	age = (systime() - $4)/(24 * 3600);
	if (age < maxage){
	    printf age; 
	    for (i = 6; i <= NF; i++){
		printf FS$i
	    };
	    printf "\n"
	}
    }
}
END {}' maxage=$maxage 


