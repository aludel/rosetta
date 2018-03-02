source "RPNparser.tcl"

#
# let's try it...
#

# ((2 - 3) * (6 + 3) * 5) + 100
set test {2 3 - 6 3 + * 5 * 100 +}

puts [expr { [parse $test] == 55 ? "OK" : "KO" }]
