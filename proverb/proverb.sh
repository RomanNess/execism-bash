#!/usr/bin/env bash

set -o errexit
set -o nounset

if (( $# == 0 )); then
    exit 0
fi

declare -a argsArray=( "$@" )

for (( i=1; i<$#; i++ )); do
    echo "For want of a ${argsArray[i-1]} the ${argsArray[i]} was lost."
done

echo "And all for the want of a $1."
