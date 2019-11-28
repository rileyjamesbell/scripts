#!/bin/zsh

#Extremely simple script for cycling through ttyunimaps
#Just press ctrl+c when you see one you like

prevdir=$(pwd)
cd /usr/share/kbd/unimaps
ttyfonts=$(ls *.uni)

while [[ $ttyfonts ]]
do
	ttyfont=$(echo $ttyfonts|head -n 1)
	echo $ttyfont
	sudo setfont -u $ttyfont
	ttyfonts=$(echo $ttyfonts|tail -n +2)
	read
done

cd $prevdir
