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
    echo "Usage: destionation source [target]"
    echo "The source is the file to be embedded using concatenation into the destination."
    echo "A target can be specified so the destination is not modified. It is optional."
    echo "Example: embed image.png archive.rar newimage.png"
fi
