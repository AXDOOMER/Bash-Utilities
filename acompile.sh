#!/bin/bash

list=""

if [[ $# -eq 1 ]]; then
	# Found the required parameter
	for file in *
	do
		if [[ $file == *.c || $file == *.cpp ]]; then
			# Add a small space between every concatenated file name
			list="$list$(basename "$file") "
		fi
	done

	# Display how the compiler is invoqued
	echo "AutoCompiling files as '$1'..."
	echo "$list"
	g++ -o $1 $list
else
	echo "Finds every .c and .cpp files in the current directory and compiles them."
	echo "g++ must be installed for it to work. How to use: compile [program name]"
fi
