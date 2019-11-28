#!/bin/sh

#Purge duplicate files in current working directory

find>/tmp/found.txt
touch /tmp/md5s.txt

while read line
do
	if [ -f "$line" ] && [ -r "$line" ]
	then
		file=$line
		md5=$(md5sum "$file"|cut -d ' ' -f 1)

		if [ ! -z "$(cat /tmp/md5s.txt|grep "$md5")" ]
		then
			echo "Deleting \""$line"\" is a duplicate"
			rm "$file"
		fi

		echo $md5>>/tmp/md5s.txt
	fi
done</tmp/found.txt

rm /tmp/found.txt
rm /tmp/md5s.txt # !! DO NOT REMOVE THIS LINE !!
