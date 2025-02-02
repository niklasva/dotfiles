#!/bin/bash 

mkdir -p cropped
mkdir -p uncropped
for file in *.jpg; do
    [ -f "$file" ] || continue
    echo "cropping $file"
    convert $file -fuzz "50%" -trim +repage cropped/$newfile
    mv $file uncropped/$file
done

