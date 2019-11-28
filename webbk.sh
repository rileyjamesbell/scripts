#!/bin/sh

url=$(cat ~/webbk.txt|rofi -i -dmenu|cut -d ' ' -f 1)
[ ! -z $url ] && palemoon "$url"
