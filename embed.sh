#!/bin/bash

echo "Embedded file creator" 

if [ $# -eq 2 ]; then
    echo "Embeding $2 to $1..."
    cat $2 >> $1
elif [ $# -eq 3 ]; then
    echo "Copying $1 to $3, then embeding $2 to $3..."
    cat $1 > $3
    cat $2 >> $3
else
    echo "usage: [file used for concatenation] [file to embed] <new file>"
fi
