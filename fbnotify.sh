#!/bin/sh

n(){
	[ ! -d /tmp/fbnotify ] && mkdir /tmp/fbnotify

	l=$(ls /tmp/fbnotify|wc -l)

	convert -border 1x1x1x1 -size 300x100 \
		-background black -fill white -font Hack-Regular-Nerd-Font-Complete -pointsize 14 caption:"$@" /tmp/fbnotify/$l.jpg
	xr=$(fbset -s|grep "^\s*mode "|sed "s/^mode \"//"|cut -d 'x' -f 1)
	sh ~/scripts/w3miv.sh /tmp/fbnotify/$l.jpg $(expr $xr - 320) $(echo "20+(110*$l)"|bc)

	sleep 5
	[ -f /tmp/fbnotify/$l.jpg ] && rm /tmp/fbnotify/$l.jpg
}
n "$@" & #Detach
