#!/usr/bin/env bats

source RPNparser.sh

@test "test +" {
  result="$(parser '1 1 +')"
  [ "$result" = "2" ]
}
@test "test -" {
  result="$(parser '1 1 -')"
  [ "$result" = "0" ]
}
@test "test *" {
  result="$(parser '1 1 *')"
  [ "$result" = "1" ]
}
@test "test /" {
  result="$(parser '1 1 /')"
  [ "$result" = "1" ]
}
@test "test a basic expression" {
  result="$(parser '2 3 - 6 3 + * 5 * 100 +')"
  [ "$result" = "55" ]
}
