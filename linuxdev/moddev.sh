#!/bin/bash

# Copyright (c) Alexandre-Xavier Labonté-Lamoureux, 2018

# The following must be run inside the kernel's source directory before running make:
# 	make oldconfig && make prepare
# 	make scripts

function FindArg()
{
	# The first arg is the one to find
	param=$1
	shift

	for i in "$@"; do
		if [[ "$param" == "$i" ]]; then
			echo "$i"
			return
		fi
	done
}

kerdir="$HOME/Desktop/linux-4.9.94/"    # work directory, where the source code of the kernel is
kerver=$(uname -r)                      # version of the current kernel

echo "Kernel version: $kerver"

cd $kerdir
make M=drivers/media/usb/em28xx

if [ ! $? -eq 0 ]; then
	echo "Make has failed. Script was stopped."
	exit
fi

echo "Current modules: "
ls /lib/modules/$kerver/kernel/drivers/media/usb/em28xx/*.ko

echo "New modules: "
ls $kerdir/drivers/media/usb/em28xx/*.ko

# Check to make sure if the user wants to continue at this point
if [ -z $(FindArg "-dontcare" "$@") ]; then
	read -p "Are you sure you want to continue at this point? " -n 1 -r
	echo
	if [[ ! $REPLY =~ ^[Yy]$ ]]; then
		echo "Aborted."
		exit
	fi
fi

echo "Done!"

#sudo rm /lib/modules/$kerver/kernel/drivers/media/usb/em28xx/em28xx*

#sudo cp -f "~/Desktop/linux-4.9.94/drivers/media/usb/em28xx/em28xx*.ko" "/lib/modules/$kerver/kernel/drivers/media/usb/em28xx/"

