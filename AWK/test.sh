#!/bin/sh

#
# let's try it...
#

test_expr="2 3 - 6 3 + * 5 * 100 +" # ((2 - 3) * (6 + 3) * 5) + 100
result=$(echo "$test_expr" | awk -f RPNparser.awk)
[[ $result -eq 55 ]] && echo "OK" || echo "KO"
