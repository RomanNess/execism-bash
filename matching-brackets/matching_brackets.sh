#!/usr/bin/env bash

set -o errexit
set -o nounset

bracket_stack=""

declare -A matching_brackets=(
    ["]"]="["
    [")"]="("
    ["}"]="{"
)


function main {
    if (( $# != 1 )); then
        echo "Usage: $0 <expression-with-brackets>"
        exit 1
    fi

    sequence="$1"
    for (( i=0; i<${#sequence}; i++ )); do
        char="${sequence:$i:1}"
        handleChar "${char}"
    done

    if [[ "${bracket_stack}" != "" ]]; then
        reportFalse
    fi

    echo "true"
}

function handleChar {
    char=$1

    case "${char}" in
        '[' | '(' | '{')
            pushStack "${char}"
        ;;
        ']' | ')' | '}')
            popStackAndValidate "${matching_brackets[${char}]}"
        ;;
    esac
}

function pushStack {
    char=$1
    bracket_stack="${char}${bracket_stack}"
}

function popStackAndValidate {
    char=$1

    if [[ "${bracket_stack}" == "" ]] || [[ "${bracket_stack}" != "${char}"* ]]; then
        reportFalse
    fi
    bracket_stack=${bracket_stack#?}
}

function reportFalse {
    echo "false"
    exit 0
}

main "$@"