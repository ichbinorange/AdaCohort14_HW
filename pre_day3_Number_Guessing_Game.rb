# generate a random number between 0 – 1000 (including 0, but not including 1000).
rand_num = rand(999)
# assign a variable "total_guess" to calculate the user's total number of guesses.
total_guess = 0

# Repeat a loop until the user make a right guess
while true do
  # collect a user's guess
  print "Guess a Number Between 0-999 ==>"
  guess = gets.chomp.to_i
  # add 1 to the total_guess everytime the user made one guess
  total_guess += 1
  # check the user's guess 
  if guess < rand_num
    puts "Higher"
  elsif guess > rand_num
    puts "Lower"
  else
    puts "\nYou nailed it!\nYour total number of guesses is #{ total_guess }" 
    break
  end
end