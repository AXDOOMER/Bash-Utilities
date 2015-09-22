#!/bin/bash

if [[ $# -gt 0 ]]; then
	FileName=$(basename $1)
	wget -O /tmp/$FileName $1
	sudo dpkg -i /tmp/$FileName
else
	echo "Download a .deb package from an address then install it."
	echo "How to use: dwnstald [address]"
fi