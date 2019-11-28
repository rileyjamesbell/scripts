#!/bin/sh

#Set wallpaper for fbterm

if [ ! -z "$(echo $1|grep \"^https?://\")" ]
then
	[ -d /tmp/wall ] && rm -rf /tmp/wall/*
	[ ! -d /tmp/wall ] && mkdir /tmp/wall

	wget $1 -P /tmp/wall
	im="$(ls /tmp/wall)"
else
	im="$1"
fi
[ -z "$1" ] && im=cat /dev/stdin

convert -verbose "$i" -resize $(fbset -s|grep "^mode "|sed -e "s/^mode \"\(.*\)\"/\1/")\! -brightness-contrast -80 ~/wallpaper.jpg
echo "Wallpaper will be set on next login"
