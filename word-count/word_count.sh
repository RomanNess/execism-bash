#!/usr/bin/env bash

set -o errexit
set -o nounset

declare -A wordCounts=()

function addWordCountFor {
    local word="$1"

    local currentCount="0"
    if [[ ${wordCounts[$word]+_} ]]; then
        local currentCount="${wordCounts[$word]}"
    fi

    wordCounts[$word]=$(( currentCount + 1 ))
}

function printWordCounts {
    for word in "${!wordCounts[@]}"; do
        echo "$word: ${wordCounts[$word]}";
    done
}

function main {
    if (( $# != 1 )); then
        echo "Usage: $0 <sentence-as-single-parameter>"
    fi

    # handle comma separated words
    sentence="${1//,/ }"
    # to lower case
    sentence="${sentence,,}"
    # strip all unknown punctuation
    sentence="${sentence//[!a-zA-Z0-9\' ]/}"

    for word in $sentence; do
        # strip quotations
        [[ "$word" =~ ^\'.+\'$ ]] && word="${word:1:${#word}-2}"
        
        addWordCountFor "$word"
    done

    printWordCounts
}

main "$@"
