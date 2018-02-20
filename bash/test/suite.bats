#!/usr/bin/env bats

source RPNparser.sh

@test "test a basic expression" {
  result="$(parser '2 3 - 6 3 + * 5 * 100 +')"
  [ "$result" = "55" ]
}
