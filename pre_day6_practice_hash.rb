# Optional Practice Exercises
# 1
# We want to be able to quickly determine the state abbreviation for the states in the United States.
# Determine whether it is best to use an array or a hash, 
# and create it storing at least 4 states and their abbreviations.
# Then write code to print out only the states, then only the abbreviations, 
# and finally nicely formatted output displaying both the states and their abbreviations 
# (e.g., The abbreviation for Nebraska is NE)

us_states = { wa: "Washington", or: "Oregon", ca: "California", ut: "Utah", tx: "Taxes", az: "Arizona"}
us_states.each_key {|key| puts "#{ key.upcase }" }
us_states.each_value {|value| puts "#{ value }" } 
us_states.each {|key, value| puts "The abbreviation for #{ key.upcase } is #{ value }" }

# 2
# We want to be able to quickly determine the amount of different types of food items 
# you have in your house.
# Determine whether it is best to use an array or a hash, 
# and create it storing at least 4 food items and their quantities.
# Then write code to print out all the items and their quantities using nicely formatted output.

food_items = { veggies: 4, friuts: 3, meats: 2, milk: 1, coffee: 2}
food_items.each {|key, value| puts "#{ value } #{ key }" }
