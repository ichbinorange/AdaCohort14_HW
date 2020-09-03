=begin
Requirements:
    Write Ruby code with statements that practice conditional logic, using if, elsif, and else when appropriate
    Write Ruby code with statements that practice loops, like while and until when appropriate
    Write Ruby code that takes in user input using gets.chomp
    Practice creating, storing, and modifying variables
    Practice creating and using methods
=end

=begin
Optional Enhancements:
    Gracefully handle unexpected/erroneous user input with the following method:
        output a message to the command line that informs the user that the input was invalid
        asks the user to re-enter the input for the same prompt
        does this until the input is valid
        uses the newer, valid input
    Print out the formula in addition to the result, i.e. 2 + 2 = 4
    Add support for computing exponents (2^4 = 2 * 2 * 2 * 2 = 16)
    Add support for the modulo operator (10 % 3 = 1).
    Make your program know when it needs to return an integer versus a float.
    (x)Add support for parentheticals, i.e. 10 / (5 + 5) = 1.
    Add support for handling all cases (uppercase, capitals) for the operations,
        so that ADD and add and Add (and other combinations) are handled in the same way
=end

=begin
To do list:
- Complex: imaginary number
- BigMath: precise number
=end

# Define a Class to do math calculation
class Calculator
  def operator_verify(user_input, working_operators)
    until ((1..working_operators.size).any? { |num| num.to_s == user_input}) || (working_operators.any? {|sub_array| sub_array.any? user_input})
      print "\nInvalid operator, please try again ==> "
      user_input = gets.chomp.strip.downcase
    end
    if user_input =~ /\d/
      user_input = working_operators[user_input.to_i - 1][0]
      return user_input
    else
      return user_input
    end
  end

  def value_verify(num)
    until num =~ /^[-+]?(\d+[.])?\d+$/ || num =~ /^[-+]?([.]+\d)?\d+$/
      print "\nYou must enter a number, try again ==> "
      num = gets.chomp
    end
    return num # num is a string
  end

  def result_calculate(user_operator, num1, num2)
    num1 = num1.to_f
    num2 = num2.to_f
    case user_operator
    when "add", "+"
      result = num1 + num2
    when "substract", "-"
      result = num1 - num2
    when "multiply", "*"
      result = num1 * num2
    when "divide", "/"
      result = num1 / num2
    when "power", "**"
      result = num1 ** num2
    when "modulo", "%"
      result = num1 % num2
    end
  end

  def power_exp(num1, num2)
    result_calculate2 = num2.to_f
    if result_calculate2 > 0 && ((result_calculate2 % 1).zero?)
      print "#{ num1 }" + " * #{ num1 }" * (result_calculate2-1)
    else
      print "#{ num1 } ^ #{ num2 }"
    end
  end
end

# Create a variable for usable operators
operators = [["add", "+"], ["substract", "-"], ["multiply", "*"], ["divide", "/"], ["power", "**"], ["modulo", "%"]]

initial_calculator = Calculator.new

# Print the usable operators and prompt user input
puts "Welcome to the two-number Calculator program! Which operator would you like to use?"
operators.each_with_index { |value, index| puts "#{ index+1 }. #{ value[0] }(#{ value[1] })" }
print "==> "
# Handle all cases (uppercase, capitals) for the operations
user_operator = gets.chomp.strip.downcase
# Verify the user input for operator
user_operator = initial_calculator.operator_verify(user_operator, operators)

# Prompt user inputs and verify the numbers
print "First number is ==> "
number1 = gets.chomp
number1 = initial_calculator.value_verify(number1)

print "Second number is ==> "
number2 = gets.chomp
number2 = initial_calculator.value_verify(number2)
# Divide/modulo by 0 is undefined, prompt user input for number2 till it's not zero
while ((user_operator == "divide" || user_operator == "/") || (user_operator == "modulo" || user_operator == "%")) && (number2.to_f == 0)
  print "#{ number1 } can't be divided by #{ number2 }, please re-enter the second number ==> "
  number2 = gets.chomp
  number2 = initial_calculator.value_verify(number2)
end

# Calculate a result and verify the result an integer or a float
operators.each do |operator|
  if operator.include? (user_operator)
    result = initial_calculator.result_calculate(user_operator, number1, number2)
    if ((result % 1).zero?) && (user_operator == "power" || user_operator == "**")
      puts "#{ initial_calculator.power_exp(number1, number2) } = #{ result.to_i }"
    elsif (result % 1).zero?
      puts "#{ number1 } #{ operator[1] } #{ number2 } = #{ result.to_i }"
    elsif !((result % 1).zero?) && (user_operator == "power" || user_operator == "**")
      puts "#{ initial_calculator.power_exp(number1, number2) } = #{ '%.2f' % result }}"
    else
      puts "#{ number1 } #{ operator[1] } #{ number2 } = #{ '%.2f' % result }"
    end
  end
end


