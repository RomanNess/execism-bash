#!/usr/bin/env bash

set -o errexit
set -o nounset

function printUsage {
    echo "Usage: $0 <square_of_sum|sum_of_squares|difference> <integer>"
    exit 1
}

function square_of_sum {
    local n="$1"
    local sum=0
    for (( i=1; i<=$n; i++ )); do
        sum=$((sum+i))
    done
    echo $((sum*sum))
}

function sum_of_squares {
    local n="$1"
    local sum=0
    for (( i=1; i<=$n; i++)); do
        sum=$((sum + (i*i) ))
    done
    echo $sum
}

function difference {
    local n="$1"
    local squareOfSum=$(square_of_sum $n)
    local sumOfSquares=$(sum_of_squares $n)
    echo $((squareOfSum - sumOfSquares))
}


if (( $# != 2 )); then
    printUsage
fi

case "$1" in
    square_of_sum)
        square_of_sum $2
    ;;
    sum_of_squares)
        sum_of_squares $2
    ;;
    difference)
        difference $2
    ;;
    *)
        printUsage
esac