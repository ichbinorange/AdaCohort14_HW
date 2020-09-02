=begin
Requirements:
    Reinforce creating, using, and manipulating strings
    Reinforce setting and accessing variables
    Reinforce creating arrays
    Reinforce accessing element(s) from an array
=end

=begin
Optional Enhancements:
    Expand your solution to ensure that no descriptive term in a menu item is ever repeated.
       So if the first menu item is hot pan-fried dumplings, the the phrases hot,
       pan-friend and dumpling cannot individually be used in any other menu items
    Expand your solution to allow the user to determine how many items they'd like to see via user input
        Note: You will need to ensure that this user-chosen number of items
        is not larger than the number of items you have in your arrays.
    Instead of using hardcoded or predefined arrays, make your program accept user input.
        This user input will be utilized to generate the menu items.
        You'll need to prompt for and store a varying number of entries for each food-type array
=end

# create a random menu generator to pull one item each from different arrays you make to create a combined "menu item".

puts "--- Random Menu Generator ---"

# Created 3 arrays for foods descriptors, foods cooking methods, and foods.
descriptors = %w(tart smoky bitter sweet rancid creamy gooey spicy crunchy mushy)
cooking_methods = %w(stir-fried steamed stewed boiled roasted poached baked sauteed grilled dehydrated)
foods = %w(pizza sushi ramen tacos paella cheeseburger cupcake risotto doughnut pad-thai)

# Created 10 menu items randomly, each item pulls one word from each array, then print them out
(1..10).each { |i| puts "#{ i }. #{ descriptors.sample } #{ cooking_methods.sample } #{ foods.sample }" }

=begin
I can either use .sample or (.shuffle + .take) to access a random menu with specific number of items.
=end

# Ensure the last word in the arrays are used.

puts "\n--- Optional Enhancements: User input version ---"

# Generated a def method to verify the user input
def input_to_array(question, target_array)
  puts "\nIf you want to stop adding item to this list, please enter \"quit\"."
  print question
  user_ans = gets.chomp.downcase
  puts "Oh no...it would be fun!" if user_ans == "quit"
  while user_ans != "quit"
    if target_array.include? user_ans
      puts "Amazing, we have the same taste!"
    elsif user_ans.strip.empty?
      puts "It can't be blank, try again."
    else
      puts "I don't know this one, let me add it to the menu."
      target_array.push(user_ans)
    end
    print "\n#{ question }"
    user_ans = gets.chomp.downcase
  end
  return target_array
end

# Prompt a user input for each array by using a def method
puts "I'm going to make my menu wild, please help me do this!"
q_descriptors = "What's your favorite Words to Describe Food: "
ans_descriptors = input_to_array(q_descriptors, descriptors)
q_cooking_methods = "What's your favorite Food Preparation Method: "
ans_cooking_methods = input_to_array(q_cooking_methods, cooking_methods)
q_foods = "What's your favorite Food: "
ans_foods = input_to_array(q_foods, foods)

# Verify the max items to show
max_items_to_show = [descriptors.length, cooking_methods.length, foods.length].min

# Prompt a user input for how many dishes s/he wants to see
puts %Q{
We have #{ max_items_to_show } creative dishes on the menu to show to you.
How many dishes do you want to see?
}

# Verify user input to be an integer from 0 to max
user_input = gets.chomp
until user_input.to_i.to_s == user_input && user_input.to_i <= max_items_to_show && user_input.to_i >= 0
  if user_input.to_i.to_s != user_input
    print "Please enter an integer => "
  elsif user_input.to_i > max_items_to_show || user_input.to_i < 0
    print "Please enter an integer from 0 to #{ max_items_to_show } => "
  end
  user_input = gets.chomp
end

puts "\nI can’t believe you don't want to see my inspiring menu. :(" if user_input.to_i == 0

# Created the menu items randomly without repeating any descriptive term in it
random_descriptors = descriptors.sample(user_input.to_i)
random_methods = cooking_methods.sample(user_input.to_i)
random_foods = foods.sample(user_input.to_i)

# Print the menu
user_input.to_i.times { |i| puts "#{ i+1 }. #{ random_descriptors[i] } #{ random_methods[i] } #{ random_foods[i] }" }

