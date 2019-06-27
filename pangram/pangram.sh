#!/usr/bin/env bash

set -o errexit
set -o nounset

if (( $# != 1 )); then
    echo "Usage: $0 <sentence>"
    exit 1
fi

sentenceLowercase="${1,,}"
for letter in {a..z}; do
    if [[ "${sentenceLowercase}" != *"${letter}"* ]]; then
        echo "false"
        exit 0
    fi
done

echo "true"