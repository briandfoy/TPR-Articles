#!/bin/bash

# Name:          uptime.sh
# Purpose:       get the uptime of the machine I am running on

# You're required to have a plan
plan=3
echo "1..$plan"

LOG=/home/jeremiah/uptime.log
if [ -e $LOG ]; then 
 echo "ok 1 - file exists"
else
echo "not ok 1 - file does not exist"
fi
 
LOAD=$( uptime )
if [ $? == 0 ]; then
 echo "ok 2 - uptime worked"
fi  
	 
echo ${LOAD##*average:} >> $LOG
if [ $? == 0 ]; then 
 echo "ok 3 - completed script"
else
 echo "not ok 3 - script failed" # TODO Define failure
fi