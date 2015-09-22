#!/bin/bash

# Delete files older than # days in a directory
path=$1
days=$2

if [[ $# -ge 2 ]]
then
	if [[ $1 == "trash" || $1 == "Trash" ]]
	then
		path="$HOME/.local/share/Trash"
	elif [[ $1 == "downloads" || $1 == "Downloads" ]]
	then
		path="$HOME/Downloads"
	elif [[ $1 == "tmp" || $1 == "temp" || $1 == "Temp" ]]
	then
		path="/tmp"
	fi

	# Delete files in a directory when they are old enough
	find $path -type f -mtime +$2 -exec rm {} \;
else
	echo "This script deletes files older than a certain number of days."
	echo "How to use: deletold [path] [days]"
fi
