#!/usr/bin/env bash

set -o errexit
set -o nounset

function binarySearch {
    n=$1
    startIndex=$2
    endIndex=$3

    if (( ${startIndex} == ${endIndex} )); then
        # slice is empty
        notFound
    fi

    midIndex=$(( (startIndex + endIndex) / 2 ))
    [[ $DEBUG_LOGS == "true" ]] && echo "start=${startIndex}, end=${endIndex}, mid=${midIndex}"

    valAtMidIndex="${list[${midIndex}]}"
    if (( $n == ${valAtMidIndex} )); then
        echo "${midIndex}"
        exit 0
    fi

    if (( ${midIndex} == ${startIndex} )) || (( ${midIndex} == ${startIndex} )); then
        # midIndex has converged
        notFound
    fi

    if (( $n < ${valAtMidIndex} )); then
        binarySearch $n $startIndex $midIndex
    else
        binarySearch $n $midIndex $endIndex
    fi
}

function notFound {
    echo "-1"
    exit 0
}

declare -a list=("${@:2}")

binarySearch $1 0 ${#list[@]}