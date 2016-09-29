#!/bin/bash
#Script created by Rohan Bhagat <me (at) rohanbhagat.com>
#Version 1.7.0
#Replace with sandbox or production depending on environment
#Define variables below
ADMN_MAIL=root@localhost.localdomain
SYSTEM=sandbox
LOGFILE=/var/log/io_mon.log
VLU=97
CNT=0
#Set exec command
if [ $SYSTEM = "sandbox" ]; then
echo "Running under sandbox"
CMND=`iostat -x -p sda|grep sda1|rev|cut -d ' ' -f 1|rev`
elif [ $SYSTEM = "production" ]; then
echo "Running under production"
CMND=`iostat -x dm-0|grep dm-0|rev|cut -d ' ' -f 1|rev`
fi

echo $CMND >> $LOGFILE
for a in $(tail -3 $LOGFILE)
do
CMPR=`echo "$a > $VLU"|bc`
if [ $CMPR -eq 0 ]; then
echo -e "$a < $VLU"

else
echo -e "$a >= $VLU"
let CNT=CNT+1
fi
done
if [ "$CNT" -gt 5 ]; then
echo "IO usage is high for longer period. Please check the server."|mail -s "IO Mon alert" $ADMN_MAIL
fi
