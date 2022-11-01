#!/bin/sh
unread_file=~/.script/.rss.unread
unread=`newsboat -x print-unread | cut -d ' ' -f1`
[ $unread != "Error:" ] && echo $unread > $unread_file
unread=`cat $unread_file`
#[ $unread != 0 ] && echo " ﬉ $unread "
[ $unread != 0 ] && echo " ﬉ "
