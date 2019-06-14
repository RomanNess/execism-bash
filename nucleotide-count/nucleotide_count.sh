#!/usr/bin/env bash

set -o errexit
set -o nounset

declare -A nucleotides=(
    ["A"]=0
    ["C"]=0
    ["G"]=0
    ["T"]=0
)

function countNucleotides {
    dna=$1
    for (( i=0; i<${#dna}; i++ )) {
        n=${dna:$i:1}
        nucleotides[$n]=$((${nucleotides[$n]}+1))
    }
}

function printResults {
    for key in "${!nucleotides[@]}"; do
        echo "${key}: ${nucleotides[$key]}"
    done
}

function main {
    if (( $# != 1 )); then
        echo "Usage: $0 <dna-string>"
        exit 1
    fi

    dna=$1
    if [[ ! "${dna}" =~ ^[ACGT]*$ ]]; then
        echo "Invalid nucleotide in strand"
        exit 1
    fi

    countNucleotides "${dna}"
    printResults
}

main "$@"
