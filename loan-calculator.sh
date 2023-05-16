#!/bin/bash

# Source the file with the function
source ~/func/123.sh

# Call the function
check_and_install_bc

sum=$2
commission=$3
end=$1
mash=0
num_iterations=0
it=1
echo
echo -e "| Month | Percentage of the input amount: | Remaining amount: | Monthly payment amount: | Amount remaining to be paid: "
echo -e "------------------------------------------------------------------------------------------------"
while true; do
    mash=$(($mash + 1))

    # Check that the sum is not equal to 0
    if awk -v sum="$sum" 'BEGIN { exit (sum != 0) ? 1 : 0 }'; then
        echo -e "\rError: The sum cannot be equal to 0.\r" >&2
        exit 1
    fi
    
    # Check that the iteration is not negative
    if awk -v it="$it" 'BEGIN { exit (it >= 0) ? 1 : 0 }'; then
        it=$(echo "$it" | sed 's/^-/0/')
        echo -e "\n The loan of amount $2 will be fully repaid with a balance of +$it.\n It will take $num_iterations months to repay.\n With a monthly payment of $commission\n" >&2
        exit 1
    fi

    # Calculate the percentage with 4 decimal places
    percentage=$(echo "scale=4; $commission / $sum * 100" | bc -l) 2>/dev/null

    num_iterations=$(($num_iterations + 1))
    sleep 0.01

    if [ $num_iterations -gt $end ]; then
        break
    fi

    it=$(echo "scale=4; $sum - $commission" | bc -l) 2>/dev/null

    # Output the result
    echo -e "|  $num_iterations          $percentage%               $sum                $commission                 $it" 

    sum=$(echo "scale=4; $sum - $commission" | bc -l) 2>/dev/null
done

exit 0

