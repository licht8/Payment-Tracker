#!/bin/bash

check_sum() {
    local sum=$1

    # Check that the sum is not equal to 0
    if awk -v sum="$sum" 'BEGIN { exit (sum != 0) ? 1 : 0 }'; then
        echo -e "\rError: The sum cannot be equal to 0.\r" >&2
        exit 1
    fi
}
