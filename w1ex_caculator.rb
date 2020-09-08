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
    # Prompt user input till they enter a valid operator
    until ((1..working_operators.size).any? { |num| num.to_s == user_input}) || (working_operators.any? {|sub_array| sub_array.any? user_input})
      print "\nInvalid operator, please try again ==> "
      user_input = gets.chomp.strip.downcase
    end

    # Convert user input if they enter numbers
    if user_input =~ /\d/
      user_input = working_operators[user_input.to_i - 1][0]
    else
      user_input = user_input
    end
    return user_input
  end

  def num_or_parenthesis_verify(num)
    # Prompt user input till they enter a valid number or a valid (equation)
    num = num.gsub(/\s+/, "")
    parenthesis_format = %r{\A\(
      ([-+]?\d*\.?\d*)
      ([\+\-\/\%]|[\*]+)
      ([-+]?\d*\.?\d*)
      \)
    \Z}x
    num_format = /^[-+]?\d*\.?\d*$/  # /^\-?(\d+\.?\d*|\d*\.?\d+)$/ works too
    until !((num.empty?) || (num == "-") || (num == "+") || (num == ".")) && ((num.match? (parenthesis_format)) || (num.match? (num_format)))
      print "That's an invalid input in this calculator, please try again ==> "
      num = gets.gsub(/\s+/, "")
    end

    # Double check the format in parenthesis
    num = reconfirm_parenthesis_format(num)
    return num
  end
  
  def reconfirm_parenthesis_format(num)
    # Translate user input if it's an array
    parenthesis_format = %r{\A\(
      ([-+]?\d*\.?\d*)
      ([\+\-\/\%]|[\*]+)
      ([-+]?\d*\.?\d*)
      \)
    \Z}x
    num_format = /^[-+]?\d*\.?\d*$/  
    if num.match? (parenthesis_format)
      p_num1, p_operator, p_num2 = parenthesis_format.match(num).captures
      num = [p_num1, p_operator, p_num2] # num is an array
      if (num.any? ("")) || (num.any? (".")) || (num.any? ("+")) || (num.any? ("-")) 
        print "That's an invalid input in this calculator, please try again ==> "
        num = gets.chomp.strip
        num = num_or_parenthesis_verify(num)
      end
    elsif num.match? (num_format)
      num = num # num is a string
    end
    return num
  end

  def parenthesis_denominator_not_zero(array_num)
    # Divide/modulo by 0 is undefined inside the parenthesis,
    # prompt user input till the denominator in the parenthesis is not zero
    while ((array_num[1] == "divide" || array_num[1] == "/") || (array_num[1] == "modulo" || array_num[1] == "%")) && (array_num[2].to_f == 0.0)
      print "#{ array_num[0] } divided by #{ array_num[2] } is undefined, please re-enter the number ==> "
      array_num = gets.chomp.strip
      array_num = num_or_parenthesis_verify(array_num)
      if array_num.class == String
        break
      end
    end
    return array_num
  end

  def calculate_data_in_parenthesis(num)
    # Calculate the result inside the parenthesis
    if num.class == Array
      num = result_calculate(num[1], num[0], num[2])
    else
      num = num
    end
    return num
  end

  def result_calculate(user_operator, num1, num2)
    # Calculate the result
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
    return result
  end

  def power_exp(num1, num2)
    # Format the power exponent
    result_express = num2.to_f
    if (result_express > 0) && (result_express <= 10) && ((result_express % 1).zero?) # result_express is a positive integer
      print "#{ num1 }" + " * #{ num1 }" * (result_express-1)
    elsif (result_express > 0) && (result_express > 10) && ((result_express % 1).zero?) 
      print "#{ num1 } ^ #{ num2 }"
    else
      print "#{ num1 } ^ #{ num2 }"
    end
  end

  def non_power_eq(num)
    # Format the non_power equations
    if num.class == Array
      num = "(#{ num.join(" ") })"
    else
      num = num
    end
    return num
  end
end

# Create a variable for usable operators
operators = [["add", "+"], ["substract", "-"], ["multiply", "*"], ["divide", "/"], ["power", "**"], ["modulo", "%"]]

my_calculator = Calculator.new

# Print the usable operators and prompt user input
puts %Q{
Welcome to my Calculator program!
This calculator doesn't like imaginary numbers,
but it supports (a+b) format, ex (5/5) + 10 or 6 - (18.6 % 7), try to play with it!
\nNow, which operator would you like to use?
}
operators.each_with_index { |value, index| puts "#{ index+1 }. #{ value[0] }(#{ value[1] })" }
print "==> "
# Handle all cases (uppercase, capitals)
user_operator = gets.chomp.strip.downcase
# Verify the operator from user input
user_operator = my_calculator.operator_verify(user_operator, operators)

# Prompt user inputs and verify number1
number1_accept = false
until number1_accept
  print "\nFirst number is ==> "
  number1 = gets.chomp
  number1 = my_calculator.num_or_parenthesis_verify(number1)
  # Verify num1's denominator inside the parenthesis to not be zero for divide & modulo eq
  if number1.class == Array
    number1 = my_calculator.parenthesis_denominator_not_zero(number1)
  end
  num1_eq = number1
  number1 = my_calculator.calculate_data_in_parenthesis(number1)

  # # Check if num1 is an imaginary number
  if Complex(number1).imaginary == 0
    number1_accept = true
  else
    puts "This calculator doesn't like imaginary numbers, please try again."
  end
end
puts

# Prompt user inputs and verify number2
number2_accept = false
until number2_accept
  print "Second number is ==> "
  number2 = gets.chomp
  number2 = my_calculator.num_or_parenthesis_verify(number2)
  # verify num2's denominator inside the parenthesis to not be zero for divide & modulo eq
  if number2.class == Array
    number2 = my_calculator.parenthesis_denominator_not_zero(number2)
  end
  num2_eq = number2
  number2 = my_calculator.calculate_data_in_parenthesis(number2)

  # Check if num2 is an imaginary number
  if Complex(number2).imaginary == 0
    # verify num2's denominator to not be zero for divide & modulo eq
    if (number2.to_f == 0.0) && ((user_operator == "divide" || user_operator == "/") || (user_operator == "modulo" || user_operator == "%"))
      puts "#{ number1 } divided by #{ number2 } is undefined, please try again."
    else
      number2_accept = true
    end
  else
    puts "This calculator doesn't like imaginary numbers, please try again."
  end
end

# Calculate the result
operators.each do |operator|
  if operator.include? (user_operator)
    result = my_calculator.result_calculate(user_operator, number1, number2)
    # Check if the result is an imaginary number
    if Complex(result).imaginary == 0
      # Print out input numbers and the result in a line,
      # present computing exponents (power/**), and
      # verify the result to present with integer or float
      if ((result % 1).zero?) && (user_operator == "power" || user_operator == "**")
        puts "\n#{ my_calculator.power_exp(number1, number2) } = #{ result.to_i }"
      elsif ((result % 1).zero?) && !(user_operator == "power" || user_operator == "**")
        puts "\n#{ my_calculator.non_power_eq(num1_eq) } #{ operator[1] } #{ my_calculator.non_power_eq(num2_eq) } = #{ result.to_i }"
      elsif !((result % 1).zero?) && (user_operator == "power" || user_operator == "**")
        puts "\n#{ my_calculator.power_exp(number1, number2) } = #{ result }}"
      else
        puts "\n#{ my_calculator.non_power_eq(num1_eq) } #{ operator[1] } #{ my_calculator.non_power_eq(num2_eq) } = #{ result }"
      end
    else
      puts "\nCalculation error."
      puts "Oops, this calculator doesn't like imaginary numbers."
    end
  end
end


