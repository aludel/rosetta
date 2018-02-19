#!/bin/bash

#
# simple Reverse Polish Notation parser (only positive integers and + - * : allowed)
#
# inspired by http://lukaszwrobel.pl/blog/reverse-polish-notation-parser (in Ruby)
#

source ./stack.sh

function parser
{
    local size token result

    # split input into array
    IFS=' ' read -r -a array <<< "$@"
    # initialize stack
	stack_new stack

	if [[ ${#array[@]} -eq 0 ]]
    then
		echo "EMPTY EXPRESSION"
		return 1
	elif [[ ${#array[@]} -eq 1 ]]
    then
		if [[ ${array[0]} =~ \d+ ]]
        then
			result=${array[0]}
		else
			echo "SYNTAX ERROR"
			return 2
		fi
    fi

	for token in "${array[@]}"
    do
		if [[ $token =~ [0-9]+ ]]
        then
			stack_push stack $token
        elif [[ $token =~ (\+|-|\*|:) ]]
        then
            local x y res

            stack_size stack size
			if [[ $size -lt 2 ]]
            then
				echo "SYNTAX ERROR"
                return 2
            fi

            stack_pop stack y
            stack_pop stack x

            case $token in
                '+')
                    res=$((x+y)) ;;
                '-')
                    res=$((x-y)) ;;
                '*')
                    res=$((x*y)) ;;
                '/')
                    res=$((x/y)) ;;
                *)
                    echo "SYNTAX ERROR"
                    return 2
                    ;;
            esac

			stack_push stack $res
		else
			echo "SYNTAX ERROR"
			return 2
	    fi
    done

    stack_size stack size
    if [[ $size -ne 1 ]]
    then
        echo "SYNTAX ERROR"
        return 2
    fi

    stack_pop stack result

    echo $result
    return 0
}

# ex: ts=4 sw=4 et filetype=sh
