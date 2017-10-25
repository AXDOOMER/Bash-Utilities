#!/bin/bash

videofilename=out.mkv
inputvideo=/dev/video0
inputaudio=0,0

if [[ $# -eq 1 && $1 == "-h" ]]; then
	echo "Usage:    record.sh [OUTPUT FILE] [VIDEO INPUT] [AUDIO INPUT]"
	echo "Example:  record.sh out.mkv /dev/video1 1,0"
	exit 0
fi

if [ $# -ge 1 ]; then
	videofilename=$1
fi

if [ $# -ge 2 ]; then
	inputvideo=$2
fi

if [ $# -ge 3 ]; then
	inputaudio=$3
fi

if which v4l2-ctl; then
	v4l2-ctl --list-devices
fi

# Remove old file or else the video won't record
if [ -f $videofilename ]; then
	read -p "File $videofilename will be overwritten. Are you sure you want to continue? " -n 1 -r
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		rm $videofilename
	else
		exit 0
	fi
fi

ffmpeg -f v4l2 -s 640x480 -i $inputvideo -f alsa -ac 1 -i hw:$inputaudio -acodec mp2 -ab 192k -ar 44100 -async 1 -c copy -f nut pipe:1 | ffmpeg -i - $videofilename -c copy -f nut pipe:1 | ffplay -
