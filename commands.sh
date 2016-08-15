#!/bin/bash

# Copyright (C) 2016  Alexandre-Xavier Labonté-Lamoureux
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

choice="NOTEMPTY"

while [ -n "$choice" ]
do
	choice=$(zenity --list --title="Select a command" --height=300 --column="Commands" "List USB devices" "List account information" "Ressources usage" "Disk usage" "Temperature" "Say Hi!")

	if [ "$choice" == "List USB devices" ]
	then
		lsusb | zenity --text-info --width 700 --height=400 --title "USB devices"
	elif [ "$choice" == "List account information" ]
	then
		chage -l $USER | zenity --text-info --width 530 --height=400 --title "Information for $USER"
	elif [ "$choice" == "Ressources usage" ]
	then
		top -n 1 -b | head -5 | zenity --text-info --width 560 --height=400 --title "System information"
	elif [ "$choice" == "Temperature" ]
	then
		sensors | zenity --text-info --width 530 --height=440 --title "Sensors"
	elif [ "$choice" == "Disk usage" ]
	then
	elif [ "$choice" == "Say Hi!" ]
	then
		notify-send -t 5000 -u low -i gtk-dialog-info  "Hi!"
	else
		if [ -n "$choice" ]
		then
			zenity --error --text="Invalid command: $choice"
		fi
	fi
done

