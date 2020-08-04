# Your instructor, Ada, is running a short-term rental property and 
# wants to keep track of their guests. 
# Each guest has a name, id number, check-in date and check-out date (strings). 
# Ada has two rental properties a condo and a townhouse.

# How would you organize the data below in Ruby:

require 'date'

rental_track = [
  { property: "Condo",
    name: "Marie D'Ancanto",
    check_in: DateTime.new(2014,8,14),
    check_out: DateTime.new(2014,8,16) },
  { property: "Townhouse",
    name: "Barbara Wilson",
    check_in: DateTime.new(2014,9,20),
    check_out: DateTime.new(2014,9,21) },
  { property: "Condo",
    name: "Kitty Pryde",
    check_in: DateTime.new(2015,12,14),
    check_out: DateTime.new(2015,12,27) },
  { property: "Condo",
    name: "Patience Phillips",
    check_in: DateTime.new(2016,1,2),
    check_out: DateTime.new(2016,1,3) },
  { property: "Townhouse",
    name: "Wanda Maximoff",
    check_in: DateTime.new(2016,1,6),
    check_out: DateTime.new(2016,1,14) }]

total_amount = 0    
puts "ID\t Property\t Guest Name\t\t Check-in\t Check-out"
rental_track.each do |detail|
  total_amount += 1
  print "#{ total_amount }\t", "#{ detail[:property].ljust(9) }\t", "#{ detail[:name].ljust(18)   }\t", "#{ detail[:check_in].strftime("%F") }\t", "#{ detail[:check_out].strftime("%F") }\n"
end


    