#!/usr/bin/env bash

# set -o errexit # isQuestion/isAllCaps exit with non-zero exit status
set -o nounset

function isQuestion {
  [[ "${1: -1}" = "?" ]]
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
    local sentence="${sentence//[^A-Za-z0-9?]}"

    [[ -z "$sentence" ]] && answerWith "Fine. Be that way!"

    isQuestion "${sentence}"; local question=$?
    isAllCaps "${sentence}"; local allCaps=$?

   (( $question == 0 && $allCaps == 0 )) && answerWith "Calm down, I know what I'm doing!"
   (( $question == 0 )) && answerWith "Sure."
   (( $allCaps == 0 )) && answerWith "Whoa, chill out!"
    answerWith "Whatever."
}

main "$@"
