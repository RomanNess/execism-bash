#!/usr/bin/env bash

set -o errexit
set -o nounset

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
        '[')
            pushStack "${char}"
        ;;
        ']')
            popStackAndValidate "["
        ;;
        '{')
            pushStack "${char}"
        ;;
        '}')
            popStackAndValidate "{"
        ;;
        '(')
            pushStack "${char}"
        ;;
        ')')
            popStackAndValidate "("
        ;;
    esac
}

function pushStack {
    char=$1
    bracket_stack="${char}${bracket_stack}"
}

function popStackAndValidate {
    if [[ "${bracket_stack}" == "" ]]; then
        reportFalse
    fi

    char=$1
    charOnStack="${bracket_stack:0:1}"

    if [[ "${char}" != "${charOnStack}" ]]; then
        reportFalse
    fi

    bracket_stack=${bracket_stack#?}
}

function reportFalse {
    echo "false"
    exit 0
}

bracket_stack=""
main "$@"