#!/bin/sh

IMG=`ls ~/Pictures/Flickr | shuf -n 1`
AUTOBDIR=~/github/auto-base16-theme
schemer2 -format img::colors -in ~/Pictures/Flickr/$IMG -out colors.txt > /dev/null && \
    python3 $AUTOBDIR/AutoBase16Theme.py $AUTOBDIR/templates/base16-template.yaml /tmp/tmp.yml > /dev/null &&\
    base16-builder -s /tmp/tmp.yml -t shell -b dark > /tmp/tmp.sh && \
    chmod +x /tmp/tmp.sh && \
    /tmp/tmp.sh
