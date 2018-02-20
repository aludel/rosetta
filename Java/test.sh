#!/bin/sh

res=$(echo "2 3 - 6 3 + * 5 * 100 +" | java RPNparser.RPNparser)

[ "$res" -eq 55 ] && echo OK || echo KO
