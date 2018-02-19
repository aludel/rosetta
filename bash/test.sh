#!/bin/bash

source ./RPNparser.sh

res=$(parser "2 3 - 6 3 + * 5 * 100 +")

[ "$res" -eq 55 ] && echo OK || echo KO
