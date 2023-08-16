#!/bin/bash 

mkdir convert
for file in *.jpg; do
    [ -f "$file" ] || continue
    echo "cropping $file"
    newfile="convert/$file"
    convert $file -fuzz "55%" -trim +repage $newfile && echo 
done

