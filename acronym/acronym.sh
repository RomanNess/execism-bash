#!/usr/bin/env bash

set -o errexit
set -o nounset

if (( $# != 1 )); then
    echo "Usage: $0 <string>"
    exit 1
fi

result=""
normalizedInput=${1/-/ }
for word in $normalizedInput; do
    firstLetter=${word:0:1}
    result+=${firstLetter}
done

echo ${result^^}