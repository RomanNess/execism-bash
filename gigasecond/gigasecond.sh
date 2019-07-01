#!/usr/bin/env bash

set -o errexit
set -o nounset


if (( $# != 1 )); then
    echo "Usage: $0 <iso-8601-timestamp>"
    exit 1
fi

dateString=$(date --utc --date="$1 + 1000000000 seconds")
# my version of 'date' prints two spaces between month and day for single digit days
echo "${dateString/  / }"