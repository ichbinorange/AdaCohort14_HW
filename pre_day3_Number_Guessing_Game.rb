# generate a random number between 0 – 1000 (including 0, but not including 1000).
rand_num = rand(1000)
# Prompt a user's guess
print "Guess a Number Between 0-999 ==> "
guess = gets.chomp

# assign a variable "total_guess" to calculate the user's total number of guesses.
total_guess = 1
# A loop runs until the user make a right guess
until guess.to_i.to_s == guess && guess.to_i == rand_num
  # Verify a guess ensuring it is a number
  if guess.to_i.to_s != guess
    puts "Please enter a number."
  else
    # check the user's guess 
    if guess.to_i < rand_num
      puts "Higher"
    elsif guess.to_i > rand_num
      puts "Lower"
    end
  end
  print "\nGuess a Number Between 0-999 ==> "
  guess = gets.chomp
  # add 1 to the total_guess everytime the user made one guess
  total_guess += 1
end

# Print the total number of guesses
puts "\nYou nailed it!\nYour total number of guesses is #{ total_guess }" 