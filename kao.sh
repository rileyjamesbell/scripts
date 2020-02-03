#!/bin/sh

menu="rofi -dmenu"
kaofile=$(dirname $0)/kao.txt

kao=$(cat $kaofile|$menu)
[ "$kao" != "" ] || exit
echo $kao|xclip -selection clipboard
echo $kao|xclip -selection primary
echo $kao|xclip -selection secondary
echo $kao|xclip -selection buffer-cut
notify-send "'$(xclip -o)' copied to clipboard."
