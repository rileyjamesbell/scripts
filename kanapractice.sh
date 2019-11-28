#!/bin/bash
clear

pfnk=0 #Punish for not knowing

hiragana=" #
ん n
あ a aa
い i ii
う u
え e eh
お o oo oh

か ka
き ki
く ku
け ke
こ ko

さ sa
し si shi
す su
せ se
そ so

た ta
ち ti chi
つ tu tsu su
て te
と to

の no
ね ne
ぬ nu
に ni
な na

は ha
ひ hi
ふ hu fu
へ he
ほ ho

ま ma
み mi
む mu
め me
も mo

や ya
ゆ yu
よ yo

ら ra
り ri
る ru
れ re
ろ ro

わ wa
ゐ wi
ゑ we #I've literally never seen this one before
を wo
#Diacratics
が ga
ぎ gi
ぐ gu
げ ge
ご go
ざ za
じ zi zhi
ず zu
ぜ ze
ぞ zo
だ da
ぢ di
づ du
で de
ど do doe
ば ba
び bi bee
ぶ bu boo
べ be beh
ぼ bo boe
ぱ pa
ぴ pi
ぷ pu
ぺ pe
ぽ po
"

katakana=" #
ア a
イ i
ウ u
エ e
オ o

カ ka
キ ki
ク ku
ケ ke
コ ko
サ sa
シ si shi
ス su
セ se
ソ so
タ ta
チ ti chi
ツ tu su tsu
テ se
ト so
ナ na
ニ ni
ヌ nu
ネ ne
ノ no
ハ ha
ヒ hi
フ hu
ヘ he
ホ ho
マ ma
ミ mi
ム mu
メ me
モ mo
ヤ ya
ユ yu
ヨ yo
ラ ra
リ ri
ル ru
レ re
ロ ro
ワ wa
ヰ wi
ヱ we
ヲ wo
ン n
#Diacratics
ガ ga
ギ gi
グ gu
ゲ ge
ゴ go
ダ da
ヂ di
ヅ du
デ de
ド do
バ ba
ビ bi
ブ bu
ベ be
ボ bo
パ pa
ピ pi
プ pu
ペ pe
ポ po
"

i=0
c=0
r=0

[ -z "$@" ] && map=$hiragana$katakana$combin
for arg in $@
do
	case $arg in
		all)
			map=$hiragana$katakana
			break
			;;
		hi|hira|hiragana)
			map=$map$hiragana
			;;
		ka|kata|katakana)
			map=$map$katakana
			;;
	esac
done
map=$map

alias hr="perl -e 'print \"─\"x'$(tput cols)''"

inc(){
	echo -n "Incorrect\nThe romaji of "$ka" is "
	echo $q|cut -d ' ' -f 2
	i=$(expr $i + 1)
	hr
}

while true
do
	echo "
Correct answers: $c
Incorrect answers: $i
Total: $(expr $c + $i)
Ratio: $r%
"
	[ -f ~/scripts/fbprog.sh ] && sh ~/scripts/fbprog.sh $r
	q=$(echo -n "$map"|sed "s/\s*#.*//g;/^\s*$/d"|shuf -n 1)
	ka=$(echo $q|cut -d ' ' -f 1)

	echo $ka
	read -p "Romaji of this kana: " a
	clear

	if [ ! -z $a ]
	then
		[ $a = "q" ] || [ $a = "x" ] || [ $a = "exit" ] || [ $a = "quit" ] && exit

		for ro in $q
		do
			[ $a = $ro ] && correct=1
		done

		if [ "$correct" = "1" ]
		then
			c=$(expr $c + 1)
		else
			inc
		fi
		r=$(echo "scale=2;$c/($i+$c)"|bc|sed "s/\.//g")
	else
		if [ "$pfnk" = "1" ]
		then
			inc
		else
			echo "The romaji for "$ka" is "$(echo $q|cut -d ' ' -f 2)
			hr
		fi
	fi
	correct=0
done
