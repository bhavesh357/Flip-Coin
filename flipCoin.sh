#!/bin/bash -x
#variables
declare -A commonCount
declare -a commonSortedCount
declare -A commonPercentage

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

function getCombinations() {
	numberOfTimes=$1
	sizeOfCombination=$2
	for ((i=0;i<$numberOfTimes;i++))
	do
		result=""
		for ((j=0;j<$sizeOfCombination;j++))
		do
			result=$result$(flipCoin)
		done
		commonCount[$result]=$((${commonCount[$result]}+1))
	done
	getPercentage commonCount commonPercentage $numberOfTimes
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
getCombinations 10 3
getSortedValues commonCount commonSortedCount
getWinningCombinations commonCount commonSortedCount
