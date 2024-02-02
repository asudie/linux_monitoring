#!bin/bash

if [ $# -eq 1 ]; then
	flag=0
	if ! (( "$1" )); then
		echo "Параметр указан не правильно"
		exit
	elif [ $1 -le 0 ]; then
		echo "Параметр меньше 1го"
		exit
	elif [ $1 -gt 4 ]; then
		echo "Параметр больше 4х"
		exit
	fi
else
	echo "Один параметр от 1го до 4х"
	exit
fi

case "$1" in

1)
	cd ../04
	for ((i=1; i<=5; i++)); do
	echo "Log "$i" ----------------------------------------------------------------------------------------" >> ../05/Sort1.log
		for var in 200 201 400 401 403 404 500 501 502 503; do
			we=$(cat Day_"$i".log| awk '{if ($9 == '$var') print $0;}')
			echo "$we" >> ../05/Sort1.log
		done
	done
	;;
2)
	cd ../04
    for (( i=1; i<=5; i++ )); do
	echo "Log "$i" ----------------------------------------------------------------------------------------" >> ../05/Sort2.log
    awk '{print $1}' Day_$i.log | uniq > ../05/Sort2.log
    done
	;;
3)
	cd ../04
	for ((i=1; i<=5; i++)); do
	echo "Log "$i" ----------------------------------------------------------------------------------------" >> ../05/Sort3.log
		for var in 500 501 502 503; do
			we=$(cat Day_"$i".log| awk '{if ($9 == '$var') print $0;}')
			echo "$we" >> ../05/Sort3.log
		done
	done
	;;
4)
	cd ../04
	for ((i=1; i<=5; i++)); do
	echo "Log "$i" ----------------------------------------------------------------------------------------" >> ../05/Sort4.log
		for var in 500 501 502 503; do
			we=$(cat Day_"$i".log| awk '{if ($9 == '$var' && $1 uniq) print $1;}')
			echo "$we" >> ../05/Sort4.log
		done
	done
	;;
esac