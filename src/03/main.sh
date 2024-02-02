#!/bin/bash

if [ $# -eq 1 ]; then
flag=0
	if ! (( "$1" )); then
		echo "Нужен параметр со значениями 1-3"; flag=1;
		exit
	elif [ $1 -eq 2 ]; then
		echo "Введи времена начала и конца (HOUR:MIN)"
		echo "Начало: "
		read begin
		IFS=':' read -ra array <<< "$begin"
		var=0
			for i in "${array[@]}"; do
				var=$((var+1))
				if [ $var -eq 1 ]; then
					if [ "$i" -ge "24" ]; then
					echo "Время начала неправильное"; flag=1;
					exit;
					else
					TimeStart=$i; fi
				elif [ $var -eq 2 ]; then
					if [ "$i" -ge "60" ]; then
					echo "Время начала неправильное"; flag=1;
					exit;
					else
					TimeStart=$TimeStart$i; fi
				fi
			done
		echo "Конец: "
		read end
		IFS=':' read -ra array <<< "$end"
		var=0
		for i in "${array[@]}"; do
        var=$((var+1))
			if [ $var -eq 1 ]; then
				if [ "$i" -ge "24" ]; then
				echo "Время конца неправильное"; flag=1;
				exit; 
				else
				TimeEnd=$i; fi
			elif [ $var -eq 2 ]; then
				if [ "$i" -ge "60" ]; then
				echo "Время конца неправильное"; flag=1;
				exit; 
				else
				TimeEnd=$TimeEnd$i; fi
			fi
		done
		elif [ $1 -eq 3 ]; then
		echo "Введи маску (например a*zz.*, a*.*) : "
		read mask
	fi
else
echo "Неправильное кол-во аргументов (main.sh 1-3)"
flag=1
exit
fi


if [ $flag -eq 0 ]; then

	if [ $1 -eq 1 ]; then
	
	while IFS= read -r line
	do
		log=$(echo $line | awk '{print $1}')
		if [[ "${log:0:1}" == / ]]; then
			sudo rm -rf "$log"
		fi
	done < ../02/script.log



	elif [ $1 -eq 2 ]; then
	cd ../02/Trash
	Path=$(pwd)
	CountDir=$(ls -l | wc | awk '{print $1}')
	m=2
	for (( j=2; j<=$CountDir; j++ )); do
		time=$(ls -l | sed -n ''$m'p'| awk '{print $8}')
		Name=$(ls -l | sed -n ''$m'p'| awk '{print $9}')
		Name=$Path/$Name
		IFS=':' read -ra array <<< "$time"
		var=0
		for i in "${array[@]}"; do
        	var=$((var+1))
			if [ $var -eq 1 ]; then
			TimeNeed=$i
			else
			TimeNeed=$TimeNeed$i; fi
		done

		if [ "$TimeNeed" -ge "$TimeStart" ]; then
			if [ "$TimeNeed" -le "$TimeEnd" ]; then
				sudo rm -rf "$Name"			
			fi
		else
		let "m+=1"
		fi
	done
	
	elif [ $1 -eq 3 ]; then
	cd ../02/Trash
	rm -rf $(find . -name ''$mask'')
	
	else
	echo "Неверное число"
	fi
else
exit
fi