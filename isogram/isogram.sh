#!/usr/bin/env bash

set -o errexit
set -o nounset

function main {

    if (( $# != 1 )); then
        echo "Usage: $0 <string>"
        exit 1
    fi

    local -A found

    local toLower="${1,,}"
    local lowerAlphabetOnly="${toLower//[^a-z]/}"
    for (( i=0; i<${#lowerAlphabetOnly}; i++ )); do

        local char="${lowerAlphabetOnly:$i:1}"
        if [[ ${found[$char]+_} ]]; then
            echo "false"
            exit 0
        else
            found[$char]="1"
        fi
    done

    echo "true"
}

main "$@"