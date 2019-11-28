#!/bin/bash

# fbterm-bi: a wrapper script to enable background image with fbterm
usage="usage: fbterm-bi /path/to/image fbterm-options"
if [ -z "$1" ]
then
	echo "$usage"
	return 0
fi

echo -ne "\e[?25l" # hide cursor
clear

sh ~/scripts/w3miv.sh $1
#cp ~/wallpaper.dat /dev/fb0 #An idea I once had to directly write a capture of the framebuffer
export FBTERM_BACKGROUND_IMAGE=1
shift
exec fbterm --cursor-shape=1 "$@"
clear
