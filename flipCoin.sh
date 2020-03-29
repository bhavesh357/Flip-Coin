#!/bin/bash -x
function flipCoin() {
	if [ $(($RANDOM%2)) -eq 1 ]
	then 
		echo "H"
	else
		echo "T"
	fi
}

echo "Welcome to flip coin simulation"
flipCoin