#!/bin/bash

if [[ $# -eq 3 || $# -eq 4 ]]; then
	# cvt width height refreshrate (-v will give warnings)
	cvt -v $2 $3 $4

	# Get the output from 'cvt' without warnings
	modeline=$(cvt $2 $3 $4)
	# Get the line that start with 'Modeline'
	modeline=$(echo $modeline | sed 's/^.*\(Modeline*\)/\1/g')
	# Remove 'Modeline'
	modeline=$(echo $modeline | cut -d ' ' -f2-)
	# Get the description of the mode that looks like this: 1680x1050_60.00
	mode=$(echo $modeline | awk -F '"' '{print $2}')

	# Tell XRANDR about this new mode
	sudo xrandr --newmode $modeline

	# Ask XRANDR to add this new mode
	sudo xrandr --addmode $1 $mode

	echo "If it all went fine, your new display mode should have been added."
	echo "You may check using 'xrandr -q'. You may need to restart your computer."
	echo "You can use 'xrandr -s width×height' to change your resolution."
	echo "If you type 'xrandr -s 0', your resolution will go back to normal."
else
	echo "Syntax: add-res [display] [width] [height] [refresh rate]"
	echo "For [display], you must give the name of the current display output."
	echo "Something like VGA-0, VGA1, VBOX0, Virtual1, HDMI-0, LVDS or something else..."
	echo
	xrandr -q
fi