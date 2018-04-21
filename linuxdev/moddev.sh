#!/bin/bash

# Copyright (c) Alexandre-Xavier Labonté-Lamoureux, 2018

# The following must be run inside the kernel's source directory before running make:
# 	make oldconfig && make prepare
# 	make scripts
# Run the script with '-init' and it will execute them.

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

kerdir="$HOME/Desktop/linux-4.9.94"    # Linux kernel source code directory
kerver=$(uname -r)                     # Version of the current kernel
pattern="em28xx*.ko"
module="drivers/media/usb/em28xx"

echo "Kernel version: $kerver"

cd $kerdir

if [ ! -z $(FindArg "-init" "$@") ]; then
	make oldconfig && make prepare
	make scripts
	echo -e "\nConfig and scripts prepared."
	exit
fi

make M=drivers/media/usb/em28xx

if [ ! $? -eq 0 ]; then
	echo -e "\nMake has failed. Script was stopped."
	exit
fi

echo "Current modules: "
ls /lib/modules/$kerver/kernel/$module/*.ko

echo "New modules: "
ls $kerdir/$module/*.ko

# Check to make sure if the user wants to continue at this point
if [ -z $(FindArg "-dontcare" "$@") ]; then
	echo
	read -p "Are you sure you want to continue at this point? " -n 1 -r
	echo
	if [[ ! $REPLY =~ ^[Yy]$ ]]; then
		echo -e "\nAborted."
		exit
	fi
fi

# Unload any modules
#sudo modprobe -r em28xx
#insmod em28xx.ko
#sudo modprobe em28xx

# Delete old modules and copy the new ones
sudo rm /lib/modules/$kerver/kernel/$module/$pattern
sudo cp -f $kerdir/$module/$pattern /lib/modules/$kerver/kernel/$module/

echo "Done!"
