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
    echo "usage: concatenated embedded [copy]>"
    echo "embedded is the file to be embedded using concatenation into concatenated."
    echo "if copy is used, then concatenated won't be modified. copy will be used."
    echo "example: embed image.png archive.rar newimage.png"
fi
