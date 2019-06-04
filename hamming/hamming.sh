#!/usr/bin/env bash

set -o errexit
set -o nounset

if (( $# != 2 )); then
    echo "Usage: $0 <string1> <string2>"
    exit 1
fi

aSeq=$1
bSeq=$2
if (( ${#aSeq} != ${#bSeq} )); then
    echo "left and right strands must be of equal length";
    exit 1
fi

output=0
for (( i=0; i<${#aSeq}; i++ )); do
    aChar="${aSeq:$i:1}"
    bChar="${bSeq:$i:1}"

    if [[ "${aChar}" != "${bChar}" ]]; then
        output=$((output+1))
    fi
done

echo "${output}"