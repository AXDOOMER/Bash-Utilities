#!/bin/bash

function checkfile() {
	if [ ! -f $1 ]; then
		echo "File not found!"
		exit 1
	fi
}

function checkprogram() {
	if ! command -v $1 >/dev/null 2>&1; then
		echo "$1 is not installed. Please install $1."
		exit 1
	fi
}

# Check if the progress monitor is installed
checkprogram pv

if [[ $# -eq 2 ]]; then
	checkfile $2

	echo "Opening socket for file $2 on port $1"
#	tar -zcf - $2 | pv | nc -l -p $1
	cat $2 | pv | nc -l -p $1

	# The connexion broke or the client disconnected
	#tar: -: Wrote only 4096 of 10240 bytes
	#tar: Error is not recoverable: exiting now

elif [[ $# -eq 3 ]]; then
	checkfile $3

	echo "Receiving file $3 from IP $1 and port $2"
#	nc $1 $2 | pv | tar -zOxf - > $3
#	nc $1 $2 | pv > $3
	nc $1 $2 | pv > $3

	# The port is blocked on the server or the command failed
	#gzip: stdin: unexpected end of file
	#tar: Child returned status 1
	#tar: Error is not recoverable: exiting now

else
	echo "===== Usage ====="
	echo "Send file:     $0 <port> <filename>"
	echo "Receive file:  $0 <ip> <port> <filename>"
fi
