#!/usr/bin/env bash

set -o errexit
set -o nounset

DEBUG_LOGS=${DEBUG_LOGS:-false}

function binarySearch {
    local n=$1
    local startIndex=$2
    local endIndex=$3

    if (( ${startIndex} > ${endIndex} )); then
        echo "-1"
        exit 0
    fi

    local midIndex=$(( (startIndex + endIndex) / 2 ))
    [[ ${DEBUG_LOGS} == "true" ]] && echo "start=${startIndex}, end=${endIndex}, mid=${midIndex}"

    local valAtMidIndex="${list[${midIndex}]}"
    if (( $n < ${valAtMidIndex} )); then
        binarySearch $n $startIndex $(($midIndex - 1))
    elif (( $n > ${valAtMidIndex} )); then
        binarySearch $n $(($midIndex + 1)) $endIndex
    fi

    echo "${midIndex}"
    exit 0
}

function printUsage {
    echo "Usage: $0 <toFind> [<num>...]"
    exit 1
}

(( $# == 0 )) && printUsage

declare -a list=("${@:2}")

binarySearch $1 0 $((${#list[@]} - 1))
