# Create an array to store 5000 decimal numbers. 
# Randomly generate numbers from between 0 – 1 (including 0, but not including 1) to fill the array. 
# Calculate and print the mean of all the elements in the array.

list = Array.new(5000) { |num| rand() }
puts "The mean of all elements in the array ==> #{ list.sum / list.length}"

# Optional Ungraded Exercises
# Create an array to store the following words: firetruck, fire drill, fire hydrant, 
# firefighter, fireproof, fire station, fire hose. 
# Then write code that uses the array to print out truck, drill, hydrant, 
# fighter, proof, station, hose without modifying the original array.

fire_words = ["firetruck", "fire drill", "fire hydrant", "firefighter", "fireproof", "fire station", "fire hose"]
puts "\nPrint out Fire-removed words ==>"
fire_words.each { |word| puts word[4, word.size].strip }

# Create an array to store the amount of money spent on 4 people during the Holidays. 
# Have the user enter in the amount spent on each person. Print the total spent on all the people. 
# Total money spent should be displayed with a dollar sign, decimal point, 
# and only 2 digits after the decimal.

# short way
group_ppl = 4
puts "\nPlease enter #{ group_ppl } people spending for the holidays ==> "
holiday_expenses = Array.new(group_ppl) { |person| gets.chomp.to_f }
puts "Total spent is $#{ "%.2f" % holiday_expenses.sum }"

''' With iterator
puts "\nPlease enter your spending for the holidays."
group_ppl = 4
holiday_expenses = []
group_ppl.times do | person |
  print "How much did person##{ person + 1} spend ==> "
  expense = gets.chomp.to_f
  holiday_expenses.push(expense)
end
puts "Total spent is $#{ "%.2f" % holiday_expenses.sum }"
'''

# Create an array to store 5 random numbers (between 1 and 10, including both 1 and 10) 
# generated by the computer. Print out the square of each of the elements in the array.

rand_num = Array.new(5) { |i| rand(1..10) }
puts "\nAn array is #{ rand_num }",
"Print out the square of each element in the array ==> "
rand_num.each { |num| puts num ** 2 }

