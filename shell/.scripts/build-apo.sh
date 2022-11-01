#!/bin/sh

APODIR=~/work/tfs/apo
pushd $APODIR > /dev/null
./build.sh apo 0.0.1
popd > /dev/null
