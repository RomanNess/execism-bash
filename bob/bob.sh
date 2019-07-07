#!/usr/bin/env bash

set -o errexit
set -o nounset

function isQuestion {
  [[ ${1: -1} = "?" ]]
}

function isAllCaps {
    [[ "${1^^}" = "${1}" && "${1,,}" != "${1}" ]]
}

function answerWith {
    echo "$1"
    exit 0
}

function main {
    # strip all irrelevant chars
    local sentence="${1:-}"
    local sentence=${sentence//[^A-Za-z0-9?]}

    [[ -z "$sentence" ]] && answerWith "Fine. Be that way!"

    isQuestion "${sentence}" && isAllCaps "${sentence}" && answerWith "Calm down, I know what I'm doing!"
    isQuestion "${sentence}" && answerWith "Sure."
    isAllCaps "${sentence}" && answerWith "Whoa, chill out!"
    answerWith "Whatever."
}

main "$@"
