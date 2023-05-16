#!/bin/bash

# Source the file with the function
. ~/Loan_Calculator/functions/check_and_install_bc.sh
. ~/Loan_Calculator/functions/run_as_root.sh
. ~/Loan_Calculator/functions/check_sum.sh
. ~/Loan_Calculator/functions/check_iteration.sh

# Call the function
run_as_root
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
check_sum "$sum"
    
    # Check that the iteration is not negative
check_iteration "$it"


    # Calculate the percentage with 4 decimal places
    percentage=$(echo "scale=4; $commission / $sum * 100" | bc -l) 2>/dev/null

    num_iterations=$(($num_iterations + 1))
    sleep 0.01

    if [ $num_iterations -gt $end ]; then
        break
    fi

    it=$(echo "scale=4; $sum - $commission" | bc -l) 2>/dev/null

    # Output the result
    echo -e "|  $num_iterations                   $percentage%                      $sum                     $commission                     $it" 

    sum=$(echo "scale=4; $sum - $commission" | bc -l) 2>/dev/null
done

exit 0

