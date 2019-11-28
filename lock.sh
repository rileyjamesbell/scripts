#!/bin/sh

scrot /tmp/screen.png
convert /tmp/screen.png -blur 0x6 /tmp/screen.png
i3lock -i /tmp/screen.png -p win
[ -f /tmp/screen.png ] && rm /tmp/screen.png
