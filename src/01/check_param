#!/bin/bash

Path=$(pwd)
time=$(date +%s.%N)
if [ $# -eq 3 ]; then
flag=0

    length1=$(echo -n "$1" | wc -m)
    if (( "$1" )); then
        echo "Cписок букв в названии папок указан не правильно"; flag=1;
    elif [ $length1 -gt 7 ]; then
        echo "Список букв в названии папок более 7ми знаков"; flag=1;
    fi
    arg="$2"
    IFS='.' read -ra array <<< "$arg"
    var=0
    for i in "${array[@]}"; do
        length=$(echo -n "$i" | wc -m)
        var=$((var+1))
        if [ $var -eq 1 ]; then
            FilePartFirst=$(echo -n "$i")
            if [ $length -gt 7 ]; then
                echo "Более 7 знаков для имени"; flag=1;
            fi
        elif [ $var -eq 2 ]; then
            FilePartSecond=$(echo -n "$i")
            if [ $length -gt 3 ]; then
                echo "Более 3 знаков для расширения"; flag=1;
            fi
        fi
    done
    arg="$3"
    IFS='Mb' read -ra array <<< "$arg"
    var=0
    for i in "${array[@]}"; do
        if [ $var -eq 0 ]; then
            range=$i
            if  ! (( "$i" )); then
                echo "Размер файлов указан не правильно"; flag=1;
            elif [[ "$i" -gt 100 ]]; then
                echo "Размер файлов больше сотки"; flag=1; fi
        var=$((var+1)); fi
    done
else
echo "Неправильное кол-во аргументов (main.sh az az.az 3Mb)"
flag=1
exit
fi


date=$(date +'%d%m%y')

FoldName=$1
FileName=$FilePartFirstCopy

if [ $flag -eq 0 ]; then

function FileNameGen () {
    FilePartFirstCopy=$FilePartFirstCopy${FilePartFirstCopy: -1}
    NameFile=$FilePartFirstCopy.$FilePartSecond
    sudo fallocate -l $3 $NameFile
    echo "$Path"/Trash/"$FoldName"_"$date"/"$FilePartFirstCopy.$FilePartSecond" "$range"Mb"" >> $Path/script.log
}


if [ $length1 -lt 5 ]; then
echo "Время начала работы скрипта: $(echo $(date | awk '{print $5}'))" >> $Path/script.log

    count=5-$length1
        for (( i=0; i<$count; i++ )); do
            FoldName=$FoldName${1: -1}
        done
    fi
if [ $length -lt 5 ]; then
    count=4-$length
        for (( i=0; i<$count; i++ )); do
            FilePartFirst=$FilePartFirst${FilePartFirst: -1}
        done
    fi
    FilePartFirstCopy=$FilePartFirst

    sudo mkdir -p "Trash"
    cd Trash

    for (( i=0; i<100; i++ )); do
        sudo mkdir -p "$FoldName"_"$date"
        cd "$FoldName"_"$date"
            for (( j=0; j<230 ; j++)); do
                space=$(df -h | grep /dev/sda2 | awk '{print $4 * 10}')
                if [ $space -le 11 ]; then
                    diff=$(echo "$(date +%s.%N) - $time" | bc)
                    echo "Время работы скрипта: $(echo "$(date +%s.%N) - $time" | bc)" >> $Path/script.log
                    echo "Время конца работы скрипта: $(echo $(date | awk '{print $5}'))" >> $Path/script.log
                    echo "Места меньше 1ГБ"
                    exit
                else
                    FileNameGen $1 $FilePartFirstCopy $3 $FoldName $range $Path $FilePartSecond $date
                fi
            done
        cd ..
        FoldName=$FoldName${1: -1}
        FilePartFirstCopy=$FilePartFirst
    done
else
exit
fi