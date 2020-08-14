puts "Hello! We are going to total some numbers!" 
puts "We'll ask you to enter a number twice, and you can enter a negative number to quit."
# assign a variable "total" to calculate the sum
total = 0
# ask a user to enter a number twice and collect the data
print "\nPlease enter a number ==> "
input_once = gets.chomp.to_i
print "Please enter the number again ==> "
input_twice = gets.chomp.to_i

# Repeat a loop until the user enter a repeated negative number to quit
until input_once == input_twice && input_twice < 0
  # check the user enter the same number twice
  if input_once != input_twice 
    puts "Entries do not match." 
  else
    total += input_once
  end
  print "\nPlease enter a number ==> "
  input_once = gets.chomp.to_i
  print "Please enter the number again ==> "
  input_twice = gets.chomp.to_i
end

puts "Result: #{total}"