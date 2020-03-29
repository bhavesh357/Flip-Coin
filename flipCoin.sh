#!/bin/bash -x
#Constants
declare -A singletCount
declare -A singletPercentage
function flipCoin() {
	if [ $(($RANDOM%2)) -eq 1 ]
	then 
		echo "H"
	else
		echo "T"
	fi
}
function singletCombinations() {
	singletCount["H"]=0
	singletCount["T"]=0
	for((i=0;i<$1;i++))
	do
		result=$(flipCoin)
		singletCount[$result]=$((${singletCount[$result]}+1))
	done
	echo ${!singletCount[@]}
	echo ${singletCount[@]}
}
echo "Welcome to flip coin simulation"
flipCoin
singletCombinations 10