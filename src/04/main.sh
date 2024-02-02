#!/bin/bash

if [ $# != 0 ]; then
    echo "Не должно быть ни одного аргумента"
    exit 1
else
    for (( i=1; i<=5; i++ )); do
	RandNum=$(shuf -n1 -i 100-1000)
	seconds=$(shuf -i 10-60 -n1)
	date="$(date +%Y)-$(date +%m)-$(date +%d) 00:00:00 $(date +%z)"
        for (( j=0; j<RandNum; j++ )); do			
            echo -n "$(shuf -n1 -i 1-255).$(shuf -n1 -i 1-255).$(shuf -n1 -i 1-255).$(shuf -n1 -i 1-255) - - " >> Day_$i.log
			echo -n "[$(date -d "$date + $seconds seconds"  +'%d/%b/%Y:%H:%M:%S %z')] " >> Day_$i.log
			echo -n "\"$(shuf -n1 Gen/Methods) " >> Day_$i.log
			echo -n "$(shuf -n1 Gen/URLs) " >> Day_$i.log
            echo -n "$(shuf -n1 Gen/Protocols)\" " >> Day_$i.log
			echo -n "$(shuf -n1 Gen/Codes)" >> Day_$i.log
            echo -n " \"-\" " >> Day_$i.log
            echo \""$(shuf -n1 Gen/Agents)\"" >> Day_$i.log
            ((seconds+=$(shuf -i 10-60 -n1) ))
        done
        date="$(date +%Y)-$(date +%m)-$(date +%d) 00:00:00 $(date +%z)"
        date="$(date -d "$date - $((6-$i)) days" +'%Y-%m-%d')"
    done
fi


# 200 - OK
# 201 - CREATED
# 400 - BAD_REQUEST
# 401 - UNAUTHORIZED
# 403 - FORBIDDEN
# 404 - NOT_FOUND
# 500 - INTERNAL_SERVER_ERROR
# 501 - NOT_IMPLEMENTED
# 502 - BAD_GATEWAY
# 503 - SERVICE_UNAVAILABLE