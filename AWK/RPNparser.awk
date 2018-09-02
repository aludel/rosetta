#!/usr/bin/awk -f

#
# simple Reverse Polish Notation parser (only positive integers and + - * : allowed)
#
# inspired by http://lukaszwrobel.pl/blog/reverse-polish-notation-parser (in Ruby)
#


function error(str) {
    print str > "/dev/stderr"
}

function stack_push(val) {
    stack[stack_pos++] = val
}

function stack_pop() {
    return (stack_size() > 0) ? stack[--stack_pos] : error("STACK ERROR")
}

function stack_size() {
    return stack_pos
}

function parser() {

	if (NF == 0) {
		error("EMPTY EXPRESSION")
		return 1
	} else if (NF == 1) {
		if ($1 ~ /[0-9]+/) {
			print $1
            return
		} else {
			error("SYNTAX ERROR")
			return 2
		}
	}

	for (i = 1; i <= NF; i++) {
		if ($i ~ /[0-9]+/) {
            stack_push($i)
		} else if ($i ~ /(\+|-|\*|:)/) {

			if (stack_size() < 2) {
				error("SYNTAX ERROR 2")
				return 2
			}

			y = stack_pop()
			x = stack_pop()

			if ($i ~ /\+/) {
				res = x + y
			} else if ($i ~ /-/) {
				res = x - y
			} else if ($i ~ /\*/) {
				res = x * y
			} else if ($i ~ /:/) {
				res = x / y
			}

			stack_push(res)
		} else {
			error("SYNTAX ERROR 3")
			return 2
		}
	}

	if (stack_size() != 1) {
		error("SYNTAX ERROR 4")
		return 2
	}

	print stack_pop()
}

parser()

# ex: ts=4 sw=4 et filetype=awk
