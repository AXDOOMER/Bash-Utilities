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

choice=" "
progs=(Asunder Audacious Bless Brasero ClamTk Deluge FileZilla Handbrake Kazam LxTask Putty Terminator)

while [ -n "$choice" ]
do
	choice=$(zenity --list --title="Select to install" --height=300 --column="Software packages" "${progs[@]}")
	if [ -n "$choice" ]
	then
		OUTPUT="$(gksudo apt-get install $choice | tee >(zenity --progress --pulsate --auto-close --text="Installing package $choice. Please wait..."))"
		echo "$OUTPUT" | zenity --text-info --width 700 --height=400 --title "APT output"
		#zenity --info --title "APT output" --text="$OUTPUT"
	fi
done



