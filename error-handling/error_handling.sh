#!/usr/bin/env bash

set -o errexit
set -o nounset

# names can contain numbers (e.g. r2d2, c3p0)
# multiple names only allowed when joined with 'and'
if [ $# = 0 ] || [[ ! "$@" =~ ^(|[[:alnum:]]+( and [[:alnum:]]+)*)$ ]]; then
    echo "Usage: $0 <greetee>"
    exit 1
fi

echo "Hello, $@"