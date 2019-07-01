#!/usr/bin/env bash

set -o errexit
set -o nounset

function reportInvalidNumber {
    echo "Invalid number.  [1]NXX-NXX-XXXX N=2-9, X=0-9"
    exit 1
}

function trimCountryCodeIfPresent {
    local numericPhoneNumber="$1"
    if (( ${#numericPhoneNumber} == 11 )) && [[ "${numericPhoneNumber:0:1}" = "1" ]]; then
        phoneNumber="${numericPhoneNumber:1}"
    fi
}

function main {
    if (( $# != 1 )); then
        echo "Usage: $0 <phone-number>"
    fi

    local phoneNumber="${1//[!0-9]/}"
    trimCountryCodeIfPresent "${phoneNumber}"

    if [[ ! "${phoneNumber}" =~ ^([2-9][0-9]{2}){2}[0-9]{4}$ ]]; then
        reportInvalidNumber
    fi

    echo "${phoneNumber}"
}

main "$@"