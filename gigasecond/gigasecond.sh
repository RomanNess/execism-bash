#!/usr/bin/env bash

set -o errexit
set -o nounset


if (( $# != 1 )); then
    echo "Usage: $0 <iso-8601-timestamp>"
    exit 1
fi

# custom date format since 'date' on Ubuntu 16.04 adds an extra space between month and day
date --utc --date="$1 + 1000000000 seconds" +"%a %b %-e %T %Z %Y"