#!/usr/bin/env bash

set -o errexit
set -o nounset

function main {
    if (( $# != 1 )); then
        echo "Usage: $0 <phone-number>"
    fi

    local phoneNumber="${1//[!0-9]/}"
    phoneNumber="${phoneNumber#1}"

    if [[ ! "${phoneNumber}" =~ ^([2-9][0-9]{2}){2}[0-9]{4}$ ]]; then
        echo "Invalid number.  [1]NXX-NXX-XXXX N=2-9, X=0-9"
        exit 1
    fi

    echo "${phoneNumber}"
}

main "$@"