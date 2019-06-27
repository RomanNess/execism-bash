#!/usr/bin/env bash

set -o errexit
set -o nounset


function with_bc {
    echo "${1}" | bc
}

function validTriangleOrExit {
    if (( $(with_bc "$1 + $2 <= $3") || $(with_bc "$2 + $3 <= $1") || $(with_bc "$1 + $3 <= $2") )); then
        echo "false"
        exit 0
    fi
}

function equilateral {
    if (( $(with_bc "$1 == $2") && $(with_bc "$2 == $3") )); then
        echo "true"
    else
        echo "false"
    fi
}

function isosceles {
    if (( $(with_bc "$1 == $2") || $(with_bc "$2 == $3") || $(with_bc "$1 == $3") )); then
        echo "true"
    else
        echo "false"
    fi
}

function scalene {
    if [[ "$(isosceles $@)" = "false" ]]; then
        echo "true"
    else
        echo "false"
    fi
}

function printUsage {
    echo "Usage: triangle.sh <scalene|equilateral|isosceles> <triangle-side> <triangle-side> <triangle-side>"
    exit 1
}

function main {
    if (( $# != 4 )); then
        printUsage
    fi
    
    validTriangleOrExit ${@:2}
    
    case "$1" in
        "equilateral") equilateral ${@:2}
        ;;
        "isosceles") isosceles ${@:2}
        ;;
        "scalene") scalene ${@:2}
        ;;
        *) printUsage
    esac
}

main "$@"
