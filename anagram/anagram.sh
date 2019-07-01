#!/usr/bin/env bash

set -o errexit
set -o nounset

declare -A charMap=()

function sortCharsInString {
    echo "$1" | grep -o . | sort | tr -d "\n"
}

function main {
    if (( $# != 2 )); then
        echo "Usage: $0 <word> <string-of-anagrams>"
        exit 1
    fi

    lowerCaseWord="${1,,}"
    sortedlowerCaseWord=$(sortCharsInString ${lowerCaseWord})

    matchedAnagrams=""
    for candidate in $2; do
        lowerCaseCandidate="${candidate,,}"
        sortedLowerCaseCandidate=$(sortCharsInString $lowerCaseCandidate)
        if [[ "${sortedlowerCaseWord}" = "${sortedLowerCaseCandidate}" && "${lowerCaseCandidate}" != "${lowerCaseWord}" ]]; then
            matchedAnagrams+="${candidate} "
        fi
    done

    # xargs trims argument
    echo "${matchedAnagrams}" | xargs
}

main "$@"
