require_relative 'RPNparser.rb'

parser = RPNParser.new

loop do
  begin
    input = gets
    break if input.nil?
    puts parser.parse(input).to_i
  rescue RuntimeError
    puts 'Error occurred: ' + $!.backtrace.join("\n")
  end
end
