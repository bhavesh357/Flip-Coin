#!/bin/bash -x
#Constants
declare -A singletCount
declare -A singletPercentage
declare -A doubletCount
declare -A doubletPercentage
declare -A tripletCount
declare -A tripletPercentage
function flipCoin() {
	if [ $(($RANDOM%2)) -eq 1 ]
	then 
		echo "H"
	else
		echo "T"
	fi
}
function getPercentage() {
	declare -n countArray=$1
	declare -n percentageArray=$2
	for result in "${!countArray[@]}"
	do
		percentageArray[$result]=$(($((${countArray[$result]}*100))/$3))
	done
	echo ${!countArray[@]}
	echo ${countArray[@]}
	echo ${!percentageArray[@]}
	echo ${percentageArray[@]}
}
function singletCombinations() {
	for((i=0;i<$1;i++))
	do
		result=$(flipCoin)
		singletCount[$result]=$((${singletCount[$result]}+1))
	done
	getPercentage singletCount singletPercentage $1
}
function doubletCombinations() {
	for ((i=0;i<$1;i++))
	do
		result=""
		for ((j=0;j<2;j++))
		do
			result=$result$(flipCoin)
			echo $result
		done
		echo $result
		doubletCount[$result]=$((${doubletCount[$result]}+1))
	done
	getPercentage doubletCount doubletPercentage $1
}
function tripletCombinations() {
	for ((i=0;i<$1;i++))
	do
		result=""
		for ((j=0;j<3;j++))
		do
			result=$result$(flipCoin)
			echo $result
		done
		echo $result
		tripletCount[$result]=$((${tripletCount[$result]}+1))
	done
	getPercentage tripletCount tripletPercentage $1
}
echo "Welcome to flip coin simulation"
flipCoin
singletCombinations 10
doubletCombinations 10
tripletCombinations 10