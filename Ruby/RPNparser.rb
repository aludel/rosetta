class RPNParser
  def parse(input)
    stack = []

    input.lstrip!
    while input.length > 0
      case input
        when /\A-?\d+(\.\d+)?/
          stack.push($&.to_f)
        when /\S*/
          raise 'Syntax error' if stack.size < 2

          second_operand = stack.pop()
          first_operand = stack.pop()

          stack.push(first_operand.send($&, second_operand))
      end

      input = $'
      input.lstrip!
    end

    raise 'Syntax error' if stack.size != 1

    stack.pop()
  end
end
