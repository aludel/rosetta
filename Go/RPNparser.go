// inspired by http://www.rosettacode.org/wiki/Category:Go

package main
 
import (
    "fmt"
    "math"
    "strconv"
    "strings"
)
 
var input = "3 4 2 * 1 5 - 2 3 ^ ^ / +"
 
func parser(input string) float64 {
    var stack []float64
    for _, tok := range strings.Fields(input) {
        switch tok {
        case "+":
            stack[len(stack)-2] += stack[len(stack)-1]
            stack = stack[:len(stack)-1]
        case "-":
            stack[len(stack)-2] -= stack[len(stack)-1]
            stack = stack[:len(stack)-1]
        case "*":
            stack[len(stack)-2] *= stack[len(stack)-1]
            stack = stack[:len(stack)-1]
        case "/":
            stack[len(stack)-2] /= stack[len(stack)-1]
            stack = stack[:len(stack)-1]
        case "^":
            stack[len(stack)-2] =
                math.Pow(stack[len(stack)-2], stack[len(stack)-1])
            stack = stack[:len(stack)-1]
        default:
            f, _ := strconv.ParseFloat(tok, 64)
            stack = append(stack, f)
        }
    }
    return stack[0]
}

func main () {
    fmt.Println(parser(input))
}
