/**
 * 
 * simple Reverse Polish Notation parser (only positive integers and + - * : allowed)
 * 
 * inspired by http://lukaszwrobel.pl/blog/reverse-polish-notation-parser (in Ruby)
 *
 *
 */

#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>
#include "stack.h"


typedef enum {
        TKN_EMPTY,
        TKN_POSSIBLE_NUMBER,
        TKN_NUMBER,
        TKN_OPERATOR,
        TKN_INVALID
} State;

static const char ops[] = "+-*:/";

	
static int
do_op(int x, int y, char op)
{
        switch (op) {
                case '+':
                        return x + y;
                case '-':
                        return x - y;
                case '*':
                        return x * y;
                case ':':
                case '/':
                        return x / y;
                default:
                        assert(0);
        }
}

int
parse(char *s, int *result)
{
        State state = TKN_EMPTY;
        char *ch = NULL, *start_token = NULL;
        int x, y, intermediate;
        Stack *stack = stack_create();
		
        for (ch = s; *ch != '\0'; ) {
                switch (state) {
                        case TKN_EMPTY:
                                if (isspace(*ch) || *ch == '\n' || *ch == '\r') {
                                        ch++;
                                } else if (isdigit(*ch) || *ch == '-') {
                                        state = TKN_POSSIBLE_NUMBER;
                                        start_token = ch;
                                } else if (strchr(ops, *ch)) {
                                        state = TKN_OPERATOR;
                                } else {
                                        state = TKN_INVALID;
                                }
                                break;
                        case TKN_POSSIBLE_NUMBER:
                                if (!(isdigit(*ch) || *ch == '-') || *(ch+1) == '\0') {
                                        state = TKN_NUMBER;
                                } else {
                                        ch++;
                                }
                                break;
                        case TKN_NUMBER:
                                stack_push(stack, strtol(start_token, &ch, 10));
                                state = TKN_EMPTY;
                                break;
                        case TKN_OPERATOR:
                                if (stack_size(stack) < 2) {
                                        state = TKN_INVALID;
                                } else {
                                        stack_pop(stack, &x);
                                        stack_pop(stack, &y);
                                        intermediate = do_op(x, y, *ch);
                                        stack_push(stack, intermediate);
                                        ch++;
                                        state = TKN_EMPTY;
                                }
                                break;
                        case TKN_INVALID:
                                /* fall through */
                        default:
                                assert(0);
                                break;
			}
		}

        assert(stack_size(stack) == 1);
		
        stack_pop(stack, result);
        stack_destroy(stack);

        return 0;
}
