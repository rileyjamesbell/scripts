#!/bin/sh
exec 2>/dev/null

clear
d=$1
[ -z "$d" ] && d=$(pwd)
find $d>/tmp/civl.txt

x=10
y=10
while read line
do
	case $(echo $line|cut -d '.' -f 2) in
		png|jpg|jpeg|bmp|wbmp|xbmp|gif|giff|jfif|ico|icon)
			iw=$(exiv2 -q "$line"|grep "^Image size"|cut -d ' ' -f 9)
			ih=$(exiv2 -q "$line"|grep "^Image size"|cut -d ' ' -f 11)
			w=$(echo "scale=2;200*($iw/$ih)"|bc|cut -d '.' -f 1)
			sh ~/scripts/w3miv.sh "$line" $x $y $w 200
			x=$(expr $(expr $w + $x) + 10)
			if [ $(expr $x + $w) -gt $(fbset -s|grep "^\s*geometry"|cut -d ' ' -f 6) ]
			then
				y=$(expr $y + 210)
				x=10
			fi
			;;
		*)
			;;
	esac
done</tmp/civl.txt
