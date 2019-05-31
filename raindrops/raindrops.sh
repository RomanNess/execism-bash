#!/usr/bin/env bash

set -o errexit
set -o nounset

function main {
    
    # accept only a single integer
    if (( $# != 1 )) || [[ ! "$1" =~ ^[1-9][0-9]*$ ]]; then
        echo "Usage: $0 <integer>"; exit 1;
    fi
    
    number=$1
    result=""
    if (( number % 3 == 0  )); then
        result+="Pling"
    fi
    if (( number % 5 == 0  )); then
        result+="Plang"
    fi
    if (( number % 7 == 0  )); then
        result+="Plong"
    fi
    
    echo ${result:-$number}
}

main "$@"