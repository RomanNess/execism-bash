#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

function filter_factors {
    while read n; do
        if (( NUMBER % n == 0 )); then
            echo $n
        fi
    done
}

function factors_to_raindrops {
    while read n; do
        case $n in
            3) echo -n "Pling"
            ;;
            5) echo -n "Plang";
            ;;
            7) echo -n "Plong";
            ;;
        esac
    done
}

function use_largest_factor_if_no_raindrops {
    read raindrops || true
    echo -n "${raindrops:-$NUMBER}"
}

function main {

    # accept only a single integer
    if (( $# != 1 )) || [[ ! "$1" =~ ^[1-9][0-9]*$ ]]; then
        echo "Usage: $0 <integer>"; exit 1;
    fi

    NUMBER=$1
    seq 1 $NUMBER | filter_factors | factors_to_raindrops | use_largest_factor_if_no_raindrops
}

main "$@"