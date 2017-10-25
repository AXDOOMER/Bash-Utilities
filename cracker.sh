#!/bin/bash

chars=( a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9 )

max=${#chars[@]}
((max--))

function Generate
{
	if [ "$1" -eq 0 ]
	then
		echo $2
		return
	fi

	for i in $(seq 0 $max)
	do
		Generate $(($1-1)) $2${chars[$i]}
	done
}

function Crack()
{
	length=1;
	while [ "$length" -le "$1" ]
	do
		Generate $length $empty
		((length++))
	done
}


if [ $# -eq 1 ]
then
	Crack $1
else
	echo "cracker.sh [password length]"
fi
