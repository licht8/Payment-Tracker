#!/bin/bash

# Source the file with the function
. ~/Load_Calculator/functions/check_and_install_bc.sh
. ~/Load_Calculator/functions/run_as_root.sh
. ~/Load_Calculator/functions/check_sum.sh
. ~/Load_Calculator/functions/check_iteration.sh

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

    # Проверяем, что сумма не равна 0
    if awk -v sum="$sum" 'BEGIN { exit (sum != 0) ? 1 : 0 }'; then

        echo -e "\rОшибка: сумма sum не может быть равна 0.\r" >&2
        exit 1
    fi
    
    # Проверяем, что сумма не равна 0
    if awk -v it="$it" 'BEGIN { exit (it >= 0) ? 1 : 0 }'; then
        it=$(echo "$it" | sed 's/^-/0/')
        echo -e "\n Кредит на сумму  $2  будет польностью  выплачен с балансом +$it.\n Вам потребуется $num_iterations месяцев\n При погашении кредита на сумму $commission в месяц\n" >&2
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
    echo -e "|  $num_iterations                   $percentage%                      $sum                     $commission                     $it" 

    sum=$(echo "scale=4; $sum - $commission" | bc -l) 2>/dev/null
done

exit 0

