#!/bin/sh
exec 2>>/tmp/statuserr.log

#Or just use bumblebee status

#Config
i3=true #Using i3wm?
del=" │ " #Deliminator

#
outcat(){
	out=$out$@
}
alias del="outcat '$del'"

vol(){
	v=$(amixer get $1|grep "^\s*Front ")
	l=$(echo $v|grep "Left:" |cut -d ' ' -f 5)
	r=$(echo $v|grep "Right:"|cut -d ' ' -f 5)

	if [ $l = $r ]
	then
		echo "("$1": "$l")"
	else
		echo "("$1": L"$l" R"$r")"
	fi
}

gen(){
	#Clock
	del
	outcat $(date)

	#Battery
	if [ -d /sys/class/power_supply/BAT* ]
	then
		del
		outcat "BAT:"
		for x in /sys/class/power_supply/BAT*/
		do
			outcat $(cat $x"capacity")"% ("$(cat $x"status")')'
		done
	fi

	#Music
	if [ -x "$(which mpc)" ] && [ ! -z "$(mpc current)" ]
	then
		del
		outcat $(mpc status|grep "([0-9]*%)$"|cut -d ' ' -f 1) $(mpc current)
		[ -f ~/scripts/fbprog.sh ] && [ -e /dev/fb0 ] &&
			sh ~/scripts/fbprog.sh $(mpc status|grep "([0-9]*%)$"|sed "s/^.*(\([0-9]*\)%)$/\1/")
	fi

	#Volume
	del
	outcat "VOL: "
	outcat $(vol Master)' '
	outcat $(vol PCM)' '
}

#Network
n=$(nmcli|grep "^.*: connect"|tr -d "\n")
if [ ! -z "$n" ]
then
	del
	outcat $n
fi

#
if [ $i3 = "true" ]
then
	while true
	do
		sleep 1
		gen
		printf "\n"
		printf "$out"|tr -d "\n"|sed "s/$del/\n$del/ig"|sed "s/^$del\$//"|tr -d "\n"
		out=""
	done
else
	gen
	echo "$out"|tr -d "\n"|sed "s/$del/\n$del/ig"|sed "s/^$del\$//"|tr -d "\n"
fi
