#!/bin/bash -x
#variables
declare -A singletCount
declare -a singletSortedCount
declare -A singletPercentage
declare -A doubletCount
declare -a doubletSortedCount
declare -A doubletPercentage
declare -A tripletCount
declare -a tripletSortedCount
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
		done
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
		done
		tripletCount[$result]=$((${tripletCount[$result]}+1))
	done
	getPercentage tripletCount tripletPercentage $1
}

function sortArray() {
	declare -n tempArray=$1
	count=${#tempArray[@]}
	for ((i=0;i<$count;i++))
	do
		indexOfLargest=$i
		largest=${tempArray[indexOfLargest]}
		for ((j=i;j<$count;j++))
		do
			if [ ${tempArray[j]} -gt $largest ]
			then
				largest=${tempArray[j]}
				indexOfLargest=$j
			fi
		done
		temp=${tempArray[i]}
		tempArray[i]=${tempArray[indexOfLargest]}
		tempArray[indexOfLargest]=$temp
	done
}

function getSortedValues() {
	declare -n combinationsCount=$1
	count=0
	declare -n newArray=$2 
	for key in "${!combinationsCount[@]}"
	do

		newArray[count]=${combinationsCount[$key]}
		((count++))
	done
	sortArray newArray
}

function getWinningCombinations() {
	declare -n combinationsDict=$1
	declare -n sortedArray=$2
	max=${sortedArray[0]}
	winner=""
	for key in "${!combinationsDict[@]}"
	do
		value=${combinationsDict[$key]}
		if [ $value -eq $max ]
		then
			winner=$key" "$winner
		fi
	done
	echo $winner is winning combination
}

echo "Welcome to flip coin simulation"
flipCoin
singletCombinations 10
getSortedValues singletCount singletSortedCount
getWinningCombinations singletCount singletSortedCount
doubletCombinations 10
getSortedValues doubletCount doubletSortedCount
getWinningCombinations doubletCount doubletSortedCount
tripletCombinations 10
getSortedValues tripletCount tripletSortedCount
getWinningCombinations tripletCount tripletSortedCount