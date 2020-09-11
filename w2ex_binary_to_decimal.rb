=begin
Calculate the decimal value for this binary number using the algorithm you devised in class. Return the decimal value.
    Note: Do not use Ruby functions. You may use .length method on the array
    and retrieve values at a particular index in the array.
    Author using the algorithm you devised in class. You may however write your own versions of these methods

Optional
    Add a decimal_to_binary method which converts a decimal number received as a parameter
    into an array of binary digits. Then write 3 tests for the method.
=end

class Decimal_binary_converter
  def is_8bits_binary(user_input)
    binary = false
    until binary
      if (user_input.each_char.to_a.select { |i| i == "0" || i == "1" }).length == 8
        eight_bits = user_input.each_char.to_a
        binary = true
      else
        print "Please enter 8 characters filled with only 0’s and 1’s ==> "
        user_input = gets.chomp
      end
    end
    return eight_bits
  end

  def binary_to_decimal(user_input)
    num = 0
    user_input.each_with_index do |value, index|
      num += value.to_i * 2 ** (7 - index)
    end
    return num
  end

  def is_numeric(user_input)
    numeric = false
    until numeric
      if (user_input.to_i.to_s == user_input) && (user_input.to_i >=0)
        num = user_input
        numeric = true
      else
        print "It's not a whole number, please try again =>"
        user_input = gets.chomp
      end
    end
    return num.to_i
  end

  def decimal_to_binary(user_input)
    quotient_i = user_input.divmod(2)[0]
    modulus_i = Array(user_input.divmod(2)[1])
    until quotient_i == 0
      modulus_i.unshift(quotient_i.divmod(2)[1])
      quotient_i = quotient_i.divmod(2)[0]
    end
    bi_num = modulus_i.join

    return bi_num
  end
end

decimal_binary_converter = Decimal_binary_converter.new

puts %q{
Welcome to my Binary to Decimal Converter!
To convert a binary number to a decimal number,
Please enter 8 characters filled with 0’s and 1’s, e.g. 10001000.
}
print "==> "
user_number = gets.chomp
user_number = decimal_binary_converter.is_8bits_binary(user_number) # return an array
puts decimal_binary_converter.binary_to_decimal(user_number)

# Optional
puts %Q{
     \nTo convert a decimal number to a binary number,
Please enter a whole number.}
print "==> "
user_number = gets.chomp
user_number = decimal_binary_converter.is_numeric(user_number) # return a integer
puts decimal_binary_converter.decimal_to_binary(user_number)
