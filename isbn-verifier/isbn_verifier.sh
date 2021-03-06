#!/usr/bin/env bash

set -o errexit
set -o nounset

function returnWith {
    echo "$1"
    exit 0
}

function main {
    
    if (( $# != 1 )); then
        echo "Usage: $0 <isbn>"
        exit 1
    fi

    local isbn="${1//-}"
    [[ ! "${isbn}" =~ ^[0-9]{9}[0-9X]$ ]] && returnWith "false"

    local sum=0
    for (( i=0; i<10; i++ )); do
        local multiplier=$((10-i))
        local digit=${isbn:$i:1}

        if (( $i == 9 )) && [[ "${digit}" = "X" ]]; then
            local digit=10
        fi

        (( sum+=(digit*multiplier) ))
    done

    (( ($sum % 11) == 0 )) && returnWith "true" || returnWith "false"
}

main "$@"
