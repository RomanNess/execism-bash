#!/usr/bin/env bash

set -o errexit
set -o nounset

function isQuestion {
    local lastChar="${1: -1}"
    [[ "${lastChar}" == "?" ]] && echo "1" || echo "0"
}

function isAllCaps {
    [[ "${1^^}" = "${1}" && "${1,,}" != "${1}" ]] && echo "1" || echo "0"
}

function answerWith {
    echo "$1"
    exit 0
}

function main {
    # strip all irrelevant chars 
    local sentence="${1:-}"
    local sentence=${sentence//[^A-Za-z0-9!?]}
    
    [[ -z "$sentence" ]] && answerWith "Fine. Be that way!"
    
    local question=$(isQuestion "${sentence}")
    local allCaps=$(isAllCaps "${sentence}")

    (( $question )) && (( $allCaps )) && answerWith "Calm down, I know what I'm doing!"
    (( $question )) && answerWith "Sure."
    (( $allCaps )) && answerWith "Whoa, chill out!"
    answerWith "Whatever."
}

main "$@"
