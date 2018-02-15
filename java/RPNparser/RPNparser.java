package RPNparser;

import java.lang.String;
import java.util.Stack;
import java.text.ParseException;
import java.util.Scanner;

/**
 * 
 * simple Reverse Polish Notation parser (only positive integers and + - * : allowed)
 * 
 * inspired by http://lukaszwrobel.pl/blog/reverse-polish-notation-parser (in Ruby)
 *
 *
 */

public class RPNparser {
	private enum State {
		TKN_EMPTY,
		TKN_POSSIBLE_NUMBER,
		TKN_NUMBER,
		TKN_OPERATOR,
		TKN_INVALID
	};
	
	private String ops = "+-*:/";

	private Integer do_op(Integer x, Integer y, char op)
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
				return (Integer)(x / y);
			default:
				return null;
		}
	}
	
	public Integer eval(String s) throws ParseException
	{
		char ch;
		int i = 0;
		int start_token = 0;
		String token;

		Integer x, y, intermediate;
		
		State state = State.TKN_EMPTY;

		Stack<Integer> stack = new Stack<Integer>();
		
		while (i < s.length()) {
			ch = s.charAt(i);
			
			switch (state) {
				case TKN_EMPTY:
					if (Character.isWhitespace(ch) || ch == '\n' || ch == '\r') {
						i++;
					} else if (Character.isDigit(ch)) {
						state = State.TKN_POSSIBLE_NUMBER;
						start_token = i;
					} else if (ops.indexOf(ch) >= 0) {
						state = State.TKN_OPERATOR;
					} else {
						state = State.TKN_INVALID;
					}
					break;
				case TKN_POSSIBLE_NUMBER:
					if (!Character.isDigit(ch) || i+1 == s.length()) {
						state = State.TKN_NUMBER;
					} else {
						i++;
					}
					break;
				case TKN_NUMBER:
					try {
						token = s.substring(start_token, i);
						stack.push(Integer.parseInt(token));
						i++;
						state = State.TKN_EMPTY;
					} catch (NumberFormatException e) {
						state = State.TKN_INVALID;
					}
					break;
				case TKN_OPERATOR:
					if (stack.size() < 2) {
						state = State.TKN_INVALID;
					} else {
						y = stack.pop();
						x = stack.pop();
						intermediate = do_op(x, y, ch);
						if (intermediate != null) {
							stack.push(intermediate);
							i++;
							state = State.TKN_EMPTY;
						} else {
							state = State.TKN_INVALID;
						}
					}
					break;
				case TKN_INVALID:
					throw new ParseException(null, 0);
					// fall through
				default:
					assert false;
					break;
			}
		}

		if (stack.size() != 1) {
			throw new ParseException(null, 0);
		}
		
		return stack.pop();
	}

	public static void main(String[] args)
	{
		Scanner in = new Scanner(System.in);
		RPNparser parser = new RPNparser();

		while (in.hasNextLine()) {
			String s = in.nextLine();
			if (s.length() == 0) {
				continue;
			}
			
			try {
				System.out.println(parser.eval(s));
			} catch (ParseException e) {
				System.err.println("PARSE ERROR");
			}
		}
	}
}
