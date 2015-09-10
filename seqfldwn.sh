#!/bin/bash

number=$2
length=${#2}
diff=0
error=0

if [[ $# -lt 3 ]]; then
	echo
	echo "SEQUENTIAL FILE DOWNLOADER by AXLL - HELP ON HOW TO USE"
	echo "You must use command line arguments to interact with the program:"
	echo "seqfldwn [first part of the URL] [formatted number to start from] [end of URL]"
	echo
	echo "The script will download each files using 'wget', so it must be installed."
	echo "The script starts from the given number and will follow its format."
	echo "Example: seqfldwn https://www.website.com/pic 057 -small.png"
	echo "It will download every files starting from 'pic057-small.png' until"
	echo "it can't find the next file to download."
	echo
	echo
else
	while [[ $error -eq 0 ]]; do

		if [[ $number == *[!0-9]* ]]; then
			echo "The second argument ($number) must be a number"
			exit 1;
		fi

		# Number smaller than the lenght of its string
		if [[ ${#number} -lt $length ]]; then
			diff=$(($length - ${#number}))

			string=$number

			while [[ ${#string} -lt $length ]]; do
				# Add zeros at the start to follow the format
				string=0$string
			done

			string=$1$string$3
			wget -nv $string
			error=$?
		else
			# No need to add zeros, so just concatenate. 
			string=$1$number$3
			wget -nv $string
			error=$?			
		fi

		# Increment to the next number
		((number++))
	done
fi




