#!/usr/bin/env bash

set -o errexit
set -o nounset

function isArmstrongNumber {
    local number="$1"
    local numberOfDigits="${#number}"
    local sum=0
    for (( i=0; i<${numberOfDigits}; i++)); do
        digit="${number:$i:1}"
        sum=$(( sum + (digit**numberOfDigits) ))
    done

    (( sum == number )) && echo "true" || echo "false"
}


if (( $# != 1 )); then
    echo "Usage: $0 <integer>"
    exit 1
fi

isArmstrongNumber "$1"

