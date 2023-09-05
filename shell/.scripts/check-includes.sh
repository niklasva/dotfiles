#!/bin/sh

PREWD=$PWD
cd src

INCLUDES=$(ggrep -r "#include.*/.*" .\
               | sed -e 's/.*#include //g' \
                     -e 's/"//g' \
                     -e 's/<//g' \
                     -e 's/>//g' \
                     -e 's/^\.\..*//g' \
                     -e 's/^libraries.*//g' \
                     -e 's/^mbed.*//g' \
                     -e 's/^platform.*//g' \
                     -e 's/^gmock.*//g' \
                     -e 's/^gtest.*//g' \
                     -e 's/^drivers.*//g' \
               | sort -u)

FILES=$(find . -type f -name "*" | sort -u | sed 's/^\.\///g')


while read line
do
    if [[ $FILES == *"$line"* ]]; then
        :
    else
        echo "nej --> $line"
    fi
done <<< "$INCLUDES"
