#!/bin/bash

check_iteration() {
    local it=$1

    # Check that the iteration is not negative
    if awk -v it="$it" 'BEGIN { exit (it >= 0) ? 1 : 0 }'; then
        it=$(echo "$it" | sed 's/^-/0/')
        echo -e "\n The loan of amount $2 will be fully repaid with a balance of +$it.\n It will take $num_iterations months to repay.\n With a monthly payment of $commission\n" >&2
        exit 1
    fi
}
