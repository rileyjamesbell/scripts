#!/bin/sh

#Small script to write a progress bar to framebuffer
#Posix complient edition

if [ -z $1 ]
then
	echo "Usage: sh fbprog.sh [0-100]"
	exit 1
fi

xres=$(fbset -s|grep "^mode"|sed "s/^mode \"\(.*\)x[0-9]*\"/\1/")
xs=$(echo "scale=2;$xres*($1/100)"|bc|cut -d '.' -f 1)

perl -e 'print "\xff\x00\x00\x00"x'$xs',"\x00"x4x'$(expr $xres - $xs)''>/dev/fb0
