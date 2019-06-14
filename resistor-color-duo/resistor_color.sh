#!/usr/bin/env bash

set -o errexit
set -o nounset

declare -A resistor_colors=(
    ["black"]="0"
    ["brown"]="1"
    ["red"]="2"
    ["orange"]="3"
    ["yellow"]="4"
    ["green"]="5"
    ["blue"]="6"
    ["violet"]="7"
    ["grey"]="8"
    ["white"]="9"
)

function main {
    if (( $# < 1 )); then
        echo "Usage: $0 <resistor-color> [<resistor-color>...]"
        exit 1
    fi

    local resistance=""
    for color in "$@"; do

        if [[ ! ${resistor_colors[$color]+isSet} ]]; then
            echo "invalid color"
            exit 1
        fi

        resistance+="${resistor_colors[${color}]}"
    done

    echo "${resistance}"
}

main "$@"
