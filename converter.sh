#!/bin/bash
case $1 in
"car")
WORK_DIR=$HOME/Music/Vid
FILE=list.txt

	cd $WORK_DIR
	pwd
	for a in $(cat $FILE);do youtube-dl $a;done
	#Now remove white spaces from the files
	for i in *.{avi,mkv,mp4,webm}; do mv "$i" `echo $i | tr ' ' '_'`; done
	echo "Starting conversion for $1"
	#for a in $(ls *.{mkv,mp4,avi});do ffmpeg -i $a -sn -acodec libmp3lame -ar 48000 -ab 128k -ac 2 -vcodec libxvid -crf 24 -vtag DIVX -vf scale=640:360 -aspect 16:9 -mbd rd -flags +mv4+aic -trellis 2 -cmp 2 -subcmp 2 -g 30 -vb 940k 1/$a.avi && mv $a done/;done
	for a in $(ls *.{mkv,mp4,avi,webm});do mencoder $a -oac mp3lame -ovc xvid -xvidencopts pass=1 -vf scale=640:360 -o 1/$a.avi && mv $a done/;done
	echo > $FILE
;;
	
"tv")
WORK_DIR=$HOME/Music/Vid
FILE=list.txt
	cd $WORK_DIR
	pwd
	for a in $(cat $FILE);do youtube-dl $a;done
	#Now remove white spaces from the files
	for i in *.{avi,mkv,mp4}; do mv "$i" `echo $i | tr ' ' '_'`; done
	echo "Starting conversion for $1"
	for a in $(ls *.{mkv,mp4,avi});do ffmpeg -i $a --vcodec mpeg4 -crf 25 -acodec libmp3lame -ar 48000 -ab 128k -vf scale=640:360 -aspect 16:9 -mbd rd -flags +mv4+aic -trellis 2 -cmp 2 -subcmp 2 -g 30 -vb 940k -threads 2 1/$a.avi && mv $a done/;done
	echo > $FILE
;;
"dj")
WORK_DIR=$HOME/Music/New_2016/DJ
FILE=dj.txt
	cd $WORK_DIR
	pwd
	echo "Starting conversion for $1"
	for a in $(cat $FILE);do youtube-dl -x --audio-format mp3 $a;done
	echo > $FILE
;;
"mp3")
WORK_DIR=$HOME/Music/New_2016
FILE=mp3.txt
	cd $WORK_DIR
	pwd
	echo "Starting conversion for $1"
	for a in $(cat $FILE);do youtube-dl -x --audio-format mp3 $a;done
	echo > $FILE
;;
*)
	echo "Please enter which output device car/tv/mp3/dj
		  Example: ./converter.sh mp3";;
esac
