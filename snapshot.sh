#!/usr/bin/env bash

# Takes any file, gets the current time and moves it to a snapshot folder

ts=$(/bin/date "+%Y-%m-%d---%H-%M-%S")
newname=$(echo $1 | sed "s/\./\_$ts\./g") # note double quotes to get string interpolation 

mkdir -p $HOME/snapshots 
cp $1 $HOME/snapshots/$newname
