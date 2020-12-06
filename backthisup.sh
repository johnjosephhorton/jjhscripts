#!/usr/bin/sh

ts=$(/bin/date "+%Y-%m-%d---%H-%M-%S")

#pwd

newname="dir$(pwd | sed 's/\//\_/g')_$ts"
echo $newname

#newname=$(echo $1 | sed "s/\./\_$ts\./g") # note double quotes to get string interpolation 

mkdir -p $HOME/backups

tar --exclude='backups' --exclude='analysis/py3env' --exclude='surveys/code/ve3.5' --exclude='.git'  -zcvf $HOME/backups/$newname.tar.gz .


#cp $1 $HOME/snapshots/$newname




