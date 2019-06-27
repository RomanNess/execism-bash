#!/usr/bin/env bash

set -o errexit
set -o nounset

declare -A dnaToRna=([G]=C [C]=G [A]=U [T]=A)

function invalidNucleotide {
    echo "Invalid nucleotide detected."
    exit 1
}

function convertToRna {
    local dna=$1
    local rna=""
    for (( i=0; i<${#dna}; i++ )); do
        nucleotide="${dna:$i:1}"
        rna+="${dnaToRna[$nucleotide]}"
    done
    echo "${rna}"
}

# lazy solution that uses 'sed'
function convertToRnaWithSed {
    echo -n "$1" | sed 's/G/#/g; s/C/G/g; s/#/C/g; s/A/U/g; s/T/A/g'
}

function main {
    if (( $# != 1 )); then
        echo "Usage: $0 <dna-strand>"
        exit 1
    fi

    [[ ! "$1" =~ ^[ACGT]*$ ]] && invalidNucleotide

    convertToRna "$1"
}

main "$@"
