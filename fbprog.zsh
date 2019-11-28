#!/bin/zsh

#Small script to write a progress bar to framebuffer

[ -f /tmp/fbbar ] && rm /tmp/fbbar
touch /tmp/fbbar
if [ -z $1 ]
then
	echo "Usage: zsh fbprog.zsh [0-100]"
	exit 1
fi

xres=$(fbset -s|grep "^mode"|sed "s/^mode \"\(.*\)x[0-9]*\"/\1/")
xs=$(echo "scale=2;$xres*($1/100)"|bc|cut -d '.' -f 1)

printf "\x00\x00\x00\x00%.0s" {1..$xres}>/dev/fb0
printf "\xff\x00\x00\x00%.0s" {1..$xs}>/dev/fb0
