#!/bin/bash

# pastebin commandline paste script written by rage

# file
if [ -z $1 ] ; then
echo "enter file to paste"
exit
fi

if [ -z $2 ] ; then
PASTENAME="newpaste"
else
PASTENAME="$2"
fi

# lets go
echo " *** pasteit by rage ***"
echo " ***********************"

# get file data
echo "storing file data from file: $1"
USERDATA=`cat $1`

# set cookie and get post_key
POSTKEY=`curl -A "Mozilla/5.0 (Windows; U; Windows NT 6.1; rv:2.2) Gecko/20110201" http://www.pastebin.com --location --referer http://www.pastebin.com --cookie-jar ./nom --cookie ./nom | grep post_key | awk '/value=/' | awk -F"value=" '{print $2}' | awk -F\" '{print $2}'`

# use cookie and post_key
URL=`curl -A "Mozilla/5.0 (Windows; U; Windows NT 6.1; rv:2.2) Gecko/20110201" http://www.pastebin.com/post.php --referer http://www.pastebin.com --cookie-jar ./nom --cookie ./nom --data "post_key=$POSTKEY&submit_hidden=submit_hidden&paste_code=$USERDATA&paste_format=1&paste_expire_date=N&paste_private=1&paste_name=$PASTENAME" -i | grep location | awk -F/ ' { print $2} '`

echo "http://pastebin.com/$URL"

# cleanup
rm ./nom 
