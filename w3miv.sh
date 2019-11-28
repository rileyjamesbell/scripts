#!/bin/sh
exec 2>/dev/null

if [ -z $1 ]
then
	echo "Usage: sh w3miv.sh [FILE] [X] [Y] [Width] [Height]"
	return 1;
fi

x=$2
y=$3
w=$4
h=$5

xres=$(fbset -s|grep "^\s*geometry"|cut -d ' ' -f 6)
yres=$(fbset -s|grep "^\s*geometry"|cut -d ' ' -f 7)
iw=$(exiv2 -q $1|grep "^Image size"|cut -d ' ' -f 9)
ih=$(exiv2 -q $1|grep "^Image size"|cut -d ' ' -f 11)

printf '%b\n%s;%s\n' "0;1;$x;$y;$w;$h;;;;;$1" 3 4|/lib/w3m/w3mimgdisplay -bg black
