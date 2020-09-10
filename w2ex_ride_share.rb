=begin
Iterate through the data structure to display, by printing in terminal, the following info:
    The number of rides each driver has given
    The total amount of money each driver has made
    The average rating for each driver
    Which driver made the most money?
    Which driver has the highest average rating?

Optionally, print in the terminal:
    For each driver, on which day did they make the most money?
=end

### Read the file thru open method
# rides_csv = File.open("../Ruby/w2/ride_share/rides.csv")
# raw_data = []
# rides_csv.readlines.map { |ride| raw_data.push(ride.split(",")) }
# pp raw_data

# Generate a nested structure based on each ride
rides_share = [
  {
    driver_id: "DR0004",
    date: "3rd Feb 2016",
    cost: 5,
    rider_id: "RD0022",
    rating: 5
  },
  {
    driver_id: "DR0001",
    date: "3rd Feb 2016",
    cost: 10,
    rider_id: "RD0003",
    rating: 3
  },
  {
    driver_id: "DR0002",
    date: "3rd Feb 2016",
    cost: 25,
    rider_id: "RD0073",
    rating: 5
  },
  {
    driver_id: "DR0001",
    date: "3rd Feb 2016",
    cost: 30,
    rider_id: "RD0015",
    rating: 4
  },
  {
    driver_id: "DR0003",
    date: "4th Feb 2016",
    cost: 5,
    rider_id: "RD0066",
    rating: 5
  },
  {
    driver_id: "DR0004",
    date: "4th Feb 2016",
    cost: 10,
    rider_id: "RD0022",
    rating: 4
  },
  {
    driver_id: "DR0002",
    date: "4th Feb 2016",
    cost: 15,
    rider_id: "RD0013",
    rating: 1
  },
  {
    driver_id: "DR0003",
    date: "5th Feb 2016",
    cost: 50,
    rider_id: "RD0003",
    rating: 2
  },
  {
    driver_id: "DR0002",
    date: "5th Feb 2016",
    cost: 35,
    rider_id: "RD0066",
    rating: 3
  },
  {
    driver_id: "DR0004",
    date: "5th Feb 2016",
    cost: 20,
    rider_id: "RD0073",
    rating: 5
  },
  {
    driver_id: "DR0001",
    date: "5th Feb 2016",
    cost: 45,
    rider_id: "RD0003",
    rating: 2
  }
]

# Restructure the data based on each driver
riders_data = Hash.new
rides_share.each do |ride|
  if riders_data.has_key? ride[:driver_id]
    riders_data[ride[:driver_id]][:date] << ride[:date]
    riders_data[ride[:driver_id]][:cost] << ride[:cost]
    riders_data[ride[:driver_id]][:rider_id] << ride[:rider_id]
    riders_data[ride[:driver_id]][:rating] << ride[:rating]

  else
    riders_data[ride[:driver_id]] = Hash.new
    riders_data[ride[:driver_id]][:date] = Array(ride[:date])
    riders_data[ride[:driver_id]][:cost] = Array(ride[:cost])
    riders_data[ride[:driver_id]][:rider_id] = Array(ride[:rider_id])
    riders_data[ride[:driver_id]][:rating] = Array(ride[:rating])
  end
end

puts "The number of rides each driver has given:"
riders_data.each do |key, value|
  if value[:date].count <= 1
    puts "Driver \"#{ key }\" has given #{ value[:date].count } ride."
  else
    puts "Driver \"#{ key }\" has given #{ value[:date].count } rides."
  end
end

puts "\nThe total amount of money each driver has made:"
riders_data.each do |key, value|
  puts "Driver \"#{ key }\" has earned $#{ value[:cost].sum.to_f }."
end

puts "\nThe average rating for each driver:"
riders_data.each do |key, value|
  puts "Driver \"#{ key }\" got the average rating for #{ (value[:rating].sum / value[:rating].count).to_f }."
end

# Handle ranking questions
driver_earn_the_most = { :driver=> nil, :earning=> 0 }
highest_ave_rating = { :driver=> nil, :rating=> 0 }
riders_data.each do |key, value|
  if value[:cost].sum > driver_earn_the_most[:earning]
    driver_earn_the_most[:driver] = key
    driver_earn_the_most[:earning] = value[:cost].sum
  end
  if (value[:rating].sum / value[:rating].count).to_f > highest_ave_rating[:rating]
    highest_ave_rating[:driver] = key
    highest_ave_rating[:rating] = (value[:rating].sum / value[:rating].count).to_f
  end
end
puts "\nWhich driver made the most money?"
puts "==> Driver \"#{ driver_earn_the_most[:driver] }\" has earned the most money $#{ driver_earn_the_most[:earning].to_f }"

puts "\nWhich driver has the highest average rating?"
puts "==> Driver \"#{ highest_ave_rating[:driver] }\" got the highest average rating for #{ highest_ave_rating[:rating].to_f }"

puts "\nFor each driver, on which day did they make the most money?"
riders_data.each do |key, value|
  puts "Driver \"#{ key }\" earned the most money on #{ value[:date][value[:cost].index(value[:cost].max)] }"
end