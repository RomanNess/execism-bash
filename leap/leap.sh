#!/usr/bin/env bash

set -o errexit
set -o nounset

show_usage_and_exit() {
    echo "Usage: $0 <year>"
    exit 1
}

main() {
    
    if [ $# != 1 ]; then
        show_usage_and_exit
    fi

    year=$1
    if [[ ! "$year" =~ ^[0-9]+$ ]]; then
        show_usage_and_exit
    fi

    if [[ $(($year % 400)) == 0 ]]; then
        echo true; exit 0
    fi

    if [[ $(($year % 100)) == 0 ]]; then
        echo false; exit 0
    fi

    if [[ $(($year % 4)) == 0 ]]; then
        echo true; exit 0
    fi

    echo false
}

main "$@"