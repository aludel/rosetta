#!/bin/bash

#
# simple Reverse Polish Notation parser (only positive integers and + - * : allowed)
#
# inspired by http://lukaszwrobel.pl/blog/reverse-polish-notation-parser (in Ruby)
#

source ./stack.sh

PARSER_STRICT=${PARSER_STRICT:-true}


function parser
{
    local size token result

    # split input into array
    IFS=' ' read -r -a array <<< "$@"

	if [[ ${#array[@]} -eq 0 ]]
    then
        return 0
	elif [[ ${#array[@]} -eq 1 ]]
    then
		if [[ ${array[0]} =~ [0-9]+ ]]
        then
			result=${array[0]}
            echo $result
            return 0
		else
            [[ $PARSER_STRICT == true ]] || return 0
            >&2 echo SYNTAX ERROR
			return 1
		fi
    fi

    # initialize stack
	stack_new stack

	for token in "${array[@]}"
    do
		if [[ $token =~ [0-9]+ ]]
        then
			stack_push stack $token
        elif [[ $token =~ ([-\+\*:/]) ]] # the minus sign must be at the beginning or at the end
        then
            local x y res

            stack_size stack size
			if [[ $size -lt 2 ]]
            then
                [[ $PARSER_STRICT == true ]] || break
                stack_destroy stack
                >&2 echo SYNTAX ERROR
                return 1
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
                '/'|':')
                    res=$((x/y)) ;;
                *)
                    [[ $PARSER_STRICT == true ]] || break
                    stack_destroy stack
                    >&2 echo SYNTAX ERROR
                    return 1
                    ;;
            esac

			stack_push stack $res
		else
            echo $token
            [[ $PARSER_STRICT == true ]] || break
            stack_destroy stack
            >&2 echo SYNTAX ERROR
            return 1
	    fi
    done

    stack_pop stack result
    stack_size stack size
    stack_destroy stack

    if [[ $size -ne 0 ]]
    then
        >&2 echo SYNTAX ERROR
        return 1
    fi

    echo $result
    return 0
}

# ex: ts=4 sw=4 et filetype=sh
