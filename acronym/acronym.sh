#!/usr/bin/env bash

set -o errexit
set -o nounset

if (( $# != 1 )); then
    echo "Usage: $0 <string>"
    exit 1
fi

normalizedInput=${1/-/ }
for word in $normalizedInput; do
    echo -n ${word:0:1} | tr a-z A-Z
done