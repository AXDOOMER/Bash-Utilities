#!/bin/bash

progs=(Asunder Audacious Bless Brasero ClamTk Deluge FileZilla Handbrake Kazam LxTask Putty Terminator)

#// List the programs
echo "List of programs:"
for prog in ${progs[*]}
do
    printf "    %s\n" $prog
done

#// Ask to install
echo "Installing programs:"
for prog in ${progs[*]}
do
    echo "Install $prog?"
    read anwser
    if [[ $anwser =~ ^[Yy]$ ]]
    then
        sudo apt-get install $prog
    fi
done


