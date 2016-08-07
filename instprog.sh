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


