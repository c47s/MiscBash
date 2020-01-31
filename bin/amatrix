#!/bin/bash
while :; do
	c=0
	printf "\n"
	while [ $c -lt $COLUMNS ]; do
		if [ $((RANDOM % 10)) -lt 7 ]; then
			printf " "
		elif [ $((RANDOM % 2)) -eq 0 ]; then
			printf "0";
		else
			printf 1;
		fi;
		let c=$c+1;
	done;
	sleep 0.1;
done
