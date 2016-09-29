#!/bin/bash
###### Version 1.4
###### Author: Rohan Bhagat
###### email: me (at) rohanbhagat.com
###### Script is used to remove log/dump files older than 5 days. You can adjust DAYS parameter as per your need.

###### Change log ######
#Created initial script 
#Updated script to capture stdout and stderr in log file
#Log output formatting
########################

#Define variables here
DAYS="5"
TYPE="*.log"
LOCATION="/var/log"
LOG_FILE=/var/log/cleanup_`date +%Y_%m_%d`.log
########################

#Setup cron job to purge sql file dumps older than 5 days
#creating log file if not exist
if [ ! -f $LOG_FILE ];then
touch $LOG_FILE
fi
########################

echo "Cleanup started at `date`" >>$LOG_FILE 2>>$LOG_FILE
echo "--------------------------" >>$LOG_FILE 2>>$LOG_FILE
echo "Below is the list of files to be purged" >>$LOG_FILE 2>>$LOG_FILE
echo "--------------------------" >>$LOG_FILE 2>>$LOG_FILE

#find the files older than $DAYS and caputre in log
find $LOCATION -iname $TYPE -mtime +$DAYS  -ls >>$LOG_FILE 2>>$LOG_FILE

#generating md5sum
echo "MD5SUM" >>$LOG_FILE 2>>$LOG_FILE
echo "--------------------------" >>$LOG_FILE 2>>$LOG_FILE
find $LOCATION -iname $TYPE -mtime +$DAYS  -ls -exec md5sum {} \; >>$LOG_FILE 2>>$LOG_FILE

#purge the files
echo "Purging the files" >>$LOG_FILE 2>>$LOG_FILE
echo "--------------------------" >>$LOG_FILE 2>>$LOG_FILE
find $LOCATION -iname $TYPE -mtime +$DAYS  -ls -exec rm -f {} \; >>$LOG_FILE 2>>$LOG_FILE
echo "Purge completed at `date`" >>$LOG_FILE 2>>$LOG_FILE
echo "--------------------------" >>$LOG_FILE 2>>$LOG_FILE
echo "-----------END------------" >>$LOG_FILE 2>>$LOG_FILE
echo "--------------------------" >>$LOG_FILE 2>>$LOG_FILE
