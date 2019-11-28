#!/bin/sh

#Shows you packages you've supposedly "manually" installed but forgot to put in packages.txt or to remove
# or if the package is outdated
#PacKaGe ANALyzer for people who are Riley

sed "s/\s*#.*//g;/^\s*$/d" ~/packages.txt>/tmp/pkgformat.txt

for x in $(cat /tmp/pkgformat.txt)
do
	xbps-query -S $x|
	grep "^pkgver"|sed "s/^pkgver: //">>/tmp/pkgformat2.txt
done

sort -d /tmp/pkgformat2.txt>/tmp/pkgformat3.txt
echo "\n">>/tmp/pkgformat2.txt

if [ -x $(which bat) ]
then
	xbps-query -m|sort -d|diff /tmp/pkgformat3.txt -|bat
else
	xbps-query -m|sort -d|diff /tmp/pkgformat3.txt -
fi

[ -f /tmp/pkgformat.txt ] && rm /tmp/pkgformat.txt
[ -f /tmp/pkgformat2.txt ] && rm /tmp/pkgformat2.txt
[ -f /tmp/pkgformat3.txt ] && rm /tmp/pkgformat3.txt
