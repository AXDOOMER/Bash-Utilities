#!/bin/bash

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



