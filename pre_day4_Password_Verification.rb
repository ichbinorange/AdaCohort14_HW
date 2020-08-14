# Many companies have password requirements 
# (must include a letter, a number and a symbol for example and 
# require a password of a specific length). 
# We're going to write a program that will read in a proposed password and only accept it, 
# if it meets all rules.

# Create a program that will:
# Prompt a user for input (for a new password)
# Read in the proposed Password to a variable
# If the password contains a number and a symbol (@, %, *, or !) and 
# contains 8 or more characters then accept the password and congratulate the user, 
# if not make them reenter the password until they enter an acceptable password

# [Optional] Make the user enter the password a second time to verify, 
# and if it's not the same as the original password, make them repeat the process
# [Optional] Make them include a capital and a lowercase letter
# [Optional] Let them know what they did wrong

puts "A password must contain 8 or more characters with at least a number, a symbol (@, %, *, !), a capital and a lowercase letter"
# Create an array with all pattern matching requirement
pw_requires = [/[@%*!]/, /[0-9]/, /[A-Z]/, /[a-z]/] 

# Run a loop to verify a password 
while true
  # Get a user's input 
  print "\nPlease enter your new password ==> "
  new_pw = gets.chomp 

  # Create a variable "require_check" to check pattern requirements
  require_check = 0
  # Verify pattern requirements 
  pw_requires.each do |requirement|
    if requirement =~ new_pw
      require_check += 1
    else
      puts "Your password must contain at least one #{ requirement.source }."
    end
  end
  
  # Verify password length 
  if new_pw.length < 8 
    puts "Your password must contain 8 or more characters."   
  else
    if require_check == 4
      # Get the re-enter password
      print "Please re-enter your password for verification ==> "
      verify_pw = gets.chomp
      # Verify the re-enter password
      break if new_pw == verify_pw 
      puts "Password and confirm password does not match."
    end  
  end
end

puts "\nYour new password has now been set." 
  
