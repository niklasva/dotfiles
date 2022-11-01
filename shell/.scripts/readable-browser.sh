#!/bin/sh
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit 1;
fi

if [ $1 == "-f" ]
then
    cat $2 | readable -q | w3m -T text/html -dump | nl -w4 -b'n' | less -C -R
else
    curl -s $1 | readable -q | w3m -T text/html -dump | nl -w4 -b'n' | less -C -R
fi
