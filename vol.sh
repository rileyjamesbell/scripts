v=$(amixer get $1|grep "^\s*Front ")
l=$(echo $v|grep "Left:" |cut -d ' ' -f 5)
r=$(echo $v|grep "Right:"|cut -d ' ' -f 5)

if [ $l = $r ]
then
	echo "("$1": "$l")"
else
	echo "("$1": L"$l" R"$r")"
fi

