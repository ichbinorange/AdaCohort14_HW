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
ride_share_raw_data = Hash[drivers: Hash.new, riders: Hash.new]
rides_share.each do |ride|
  if ride_share_raw_data[:drivers].has_key? ride[:driver_id]
    ride_share_raw_data[:drivers][ride[:driver_id]] << Hash(date: ride[:date], cost: ride[:cost], rider_id: ride[:rider_id], rating: ride[:rating])
  else # add a new driver to ride_share_raw_data
    ride_share_raw_data[:drivers][ride[:driver_id]] = Array.new
    ride_share_raw_data[:drivers][ride[:driver_id]] << Hash(date: ride[:date], cost: ride[:cost], rider_id: ride[:rider_id], rating: ride[:rating])
  end

  if ride_share_raw_data[:riders].has_key? ride[:rider_id]
    ride_share_raw_data[:riders][ride[:rider_id]] << Hash(driver_id: ride[:driver_id], date: ride[:date], cost: ride[:cost], rating: ride[:rating])
  else # add a new driver to ride_share_raw_data
    ride_share_raw_data[:riders][ride[:rider_id]] = Array.new
    ride_share_raw_data[:riders][ride[:rider_id]] << Hash(driver_id: ride[:driver_id], date: ride[:date], cost: ride[:cost], rating: ride[:rating])
  end
end
pp ride_share_raw_data

puts "The number of rides each driver has given:"
ride_share_raw_data[:drivers].each do |driver, rides|
  if rides.count < 2
    puts "==> Driver \"#{ driver }\" has given #{ rides.count } ride."
  else
    puts "==> Driver \"#{ driver }\" has given #{ rides.count } rides."
  end
end

puts "\nThe total amount of money each driver has made:"
ride_share_raw_data[:drivers].each do |driver, rides| 
  total_amount = rides.sum { |ride_detail| ride_detail[:cost] }
  puts "==> Driver \"#{ driver }\" has earned $#{ total_amount.to_f }." 
end

puts "\nThe average rating for each driver:"
ride_share_raw_data[:drivers].each do |driver, rides| 
  total_rating = rides.sum { |ride_detail| ride_detail[:rating] }
  puts "==> Driver \"#{ driver }\" has got the average rating for #{ (total_rating / rides.count).to_f }." 
end

# Handle ranking questions, even with a tie
def drivers_ranking(data_for_riders, request_info)
  if request_info == "cost"
    money_ranking = Hash.new
    data_for_riders.each do |driver, rides|
      money_ranking[driver] = rides.sum { |info| info[:cost] }
    end
    ranking_for_drivers = money_ranking.select { |driver, value| value == (money_ranking.max_by { |driver,earning| earning })[1] }

  elsif request_info == "rating"
    ave_rating_ranking = Hash.new
    data_for_riders.each do |driver, rides|
      ave_rating_ranking[driver] = (rides.sum { |info| info[:rating] } / rides.count).to_f
    end
    ranking_for_drivers = ave_rating_ranking.find_all { |driver, value| value == (ave_rating_ranking.max_by { |driver, rating| rating })[1] }
  end
  return ranking_for_drivers
end

def is_tie?(ranking_data, request_info)
  if request_info == "cost"
    if ranking_data.count > 1
      puts "There are #{ ranking_data.count } drivers have the same most earnings!"
      result = ranking_data.map { |driver, earning| "==> Driver \"#{ driver }\" has earned the most money $#{ earning }" }
    else
      result = ranking_data.map { |driver, earning| "==> Driver \"#{ driver }\" has earned the most money $#{ earning }" }
    end

  elsif request_info == "rating"
    if ranking_data.count > 1
      puts "There are #{ ranking_data.count } drivers have the same highest ratings!"
      result = ranking_data.map { |driver, rating| "==> Driver \"#{ driver }\" has the highest rating #{ rating }" }
    else
      result = ranking_data.map { |driver, rating| "==> Driver \"#{ driver }\" has the highest rating #{ rating }" }
    end
  end
  return result 
end


puts "\nWhich driver made the most money?"
puts is_tie?(drivers_ranking(ride_share_raw_data[:drivers], "cost"), "cost")

puts "\nWhich driver has the highest average rating?"
puts is_tie?(drivers_ranking(ride_share_raw_data[:drivers], "rating"), "rating")

# # Optional, on which days did a driver make the most money
puts "\nFor each driver, on which day did they make the most money?"
ride_share_raw_data[:drivers].each do |driver, rides|
  each_day_earning = Hash.new
  rides.each do |ride|
    if each_day_earning.include? (ride[:date])
      each_day_earning[ride[:date]] += ride[:cost]
    else  # add a new date to each_day_earning
      each_day_earning[ride[:date]] = ride[:cost]
    end
  end
  earn_the_most = each_day_earning.max_by(each_day_earning.count) { |day, earning| earning }
  tie_date = Array.new
  earn_the_most.each do |day| 
    if day[1] == earn_the_most[0][1]
      tie_date.push(day[0])
    end
  end
  puts "==> Driver \"#{ driver }\" earned the most money $#{ earn_the_most[0][1].to_f } on #{ tie_date.join(", ") }."
end

