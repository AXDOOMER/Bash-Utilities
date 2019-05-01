#!/bin/bash

username=""
server=""

if [ -z "$server"]; then
	echo "You forgot to set the server in the script!"
	exit
fi

if [ ! -z "$username" ]; then
	sudo openconnect $server --user=$username
else
	sudo openconnect $server
fi
