#!/usr/bin/env bash

set -o errexit
set -o nounset

function getIndexInAlphabet {
    ascii=$(printf "%d" "'$1")
    local indexInAlphabet=$(( ascii - 65 ))
    echo "${indexInAlphabet}"
}

function getLetterForRow {
    local alphabet="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local index="$1"

    if (( $index >= $indexInAlphabet )); then
        local index=$(( (indexInAlphabet*2) - index ))
    fi
    echo "${alphabet:$index:1}"
}

function main {
    if (( $# != 1 )) || [[ ! "$1" =~ [A-Z] ]]; then
        echo "Usage: $0 <upper-case-letter>"
        exit 1
    fi

    local char="$1"
    local indexInAlphabet=$(getIndexInAlphabet $1)
    local numberOfRows=$(( ((indexInAlphabet+1) * 2) - 1 ))

    local diamond=""
    for (( row=0; row<numberOfRows; row++ )); do

        local letterForRow=$(getLetterForRow "${row}")

        for (( col=0; col<numberOfRows; col++ )); do

            # print letter if any of these conditions is true
            local reverseRow=$(( (indexInAlphabet*2) - row ))
            if     [[ $((indexInAlphabet - row))         -eq "$col" ]] || [[ $((indexInAlphabet + row))         -eq "$col" ]] \
                || [[ $((indexInAlphabet - reverseRow )) -eq "$col" ]] || [[ $((indexInAlphabet + reverseRow )) -eq "$col" ]]; then
                diamond+="$letterForRow"
            else
                diamond+=" "
            fi
        done
        diamond+=$'\n'
    done
    # omit last newline from output
    echo "${diamond::-1}"
}

main "$@"
