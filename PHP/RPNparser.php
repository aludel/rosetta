#!/usr/bin/env php
<?php

#
# simple Reverse Polish Notation parser (only positive integers and + - * : allowed)
#
# inspired by http://lukaszwrobel.pl/blog/reverse-polish-notation-parser (in Ruby)
#

$PARSER_STRICT = true;


class Stack {
    private $_stack = array();

    public function size() {
        return count($this->_stack);
    }

    public function top() {
        return end($this->_stack);
    }

    public function push($value = NULL) {
        array_push($this->_stack, $value);
    }

    public function pop() {
        return array_pop($this->_stack);
    }

    public function isEmpty() {
        return empty($this->_stack);
    }
}


function parser($s)
{
    $tokens = preg_split('/\s+/', $s, -1, PREG_SPLIT_NO_EMPTY);
    $tokens_len = count($tokens);

	if ($tokens_len == 0) {
        return null;
    }
    else if ($tokens_len == 1) {
		if (preg_match('/[0-9]+/', $tokens[0])) {
            return $tokens[0];
        }
        else {
            if ($GLOBALS['PARSER_STRICT']) {
                fwrite(STDERR, "SYNTAX ERROR\n");
            }
            return null;
        }
    }

    $stack = new Stack();

	foreach ($tokens as $token)
    {
		if (preg_match('/[0-9]+/', $token)) {
			$stack->push($token);
        } 
        else if (preg_match('/(\+|-|\*|:)/', $token)) {
            if ($stack->size() < 2) {
                if ($GLOBALS['PARSER_STRICT']) {
                    fwrite(STDERR, "SYNTAX ERROR\n");
                    unset($stack);
                    return null;
                }
                else {
                    break;
                }
            }

            $y = $stack->pop();
            $x = $stack->pop();

            switch ($token) {
                case '+':
                    $res = $x + $y;
                    break;
                case '-':
                    $res = $x - $y;
                    break;
                case '*':
                    $res = $x * $y;
                    break;
                case '/':
                    $res = $x / $y;
                    break;
                default:
                    if ($GLOBALS['PARSER_STRICT']) {
                        fwrite(STDERR, "SYNTAX ERROR\n");
                        unset($stack);
                        return null;
                    }
                    else {
                        break;
                    }
                    break;
            }

            $stack->push($res);
        }
		else {
            if ($GLOBALS['PARSER_STRICT']) {
                fwrite(STDERR, "SYNTAX ERROR\n");
                unset($stack);
                return null;
            }
	    }
    }

    $result = $stack->pop();
    $size = $stack->size();
    unset($stack);

    if ($size != 0) {
        fwrite(STDERR, "SYNTAX ERROR\n");
        return null;
    }

    return $result;
}

# ex: ts=4 sw=4 et filetype=php:
?>
