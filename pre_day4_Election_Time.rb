# Assignment: Election Time
# You are going to create an electronic election program that tracks votes, total votes, and determines a winner.

# Primary Requirements
# Create an election program that accepts input from the user and outputs the winner of the election
# Input: Poll 10 people for their election vote
# Output: Print the total votes cast as well as the winner of the election

# Optional Enhancements
# Handle ties for a winner appropriately
# Handle grammar of vote summary saying vote or votes appropriately
# Handle write in votes
# Consider how to handle more than 10 votes
# Consider how to handle more than 3 candidates
# Refactor your code so that your code is DRY (Don't Repeat Yourself)

def candidate_list(data)
  print "\nWe have #{ data.length } election candidates: "
  print data[0].upcase
  (1...data.length).each do | num |
    print ", #{ (data[ num ]).upcase }"
  end
end

default_candidates = ["donald duck", "minnie mouse", "goofy"]
puts "Welcome to my election voting program."
# Print the election candidates
candidate_list(default_candidates)
# Get a user input to handle different number of candidates
while default_candidates do
  print "\nDo you want to add more candidates (Yes/No)? ==> "
  reply_add_candidate = gets.chomp
  break if reply_add_candidate.downcase == "no"
  if reply_add_candidate.downcase == "yes"
    print "Add candidate ==> "
    add_candidate = gets.chomp.downcase
    default_candidates << add_candidate
  end
end
# Re-print the election candidates
candidate_list(default_candidates)
# Generate an array to track votes for each candidate
track_vote = Array.new(default_candidates.length, 0)

# Get a user input to handle different number of votes
num_of_vote = 1
puts "\n\nPlease enter a vote information or \"stop\" to leave."
while num_of_vote do
  # Get the user input for each vote
  print "Vote ##{ num_of_vote }: "
  vote_for = gets.chomp
  # Verify the validity of a vote
  break if vote_for.downcase == "stop"
  if vote_for.empty?
    puts "This is a blank vote."
    num_of_vote += 1
  elsif default_candidates.include? vote_for.downcase
    which_candidate = default_candidates.index(vote_for.downcase)
    track_vote[which_candidate] += 1
    num_of_vote += 1
  else
    # Verify a write-in vote
    print "No candidate named #{ vote_for.upcase }, do you want to re-enter (R) or add a write-in candidate (A)? ==> "
    reenter_or_add = gets.chomp.downcase
    puts "Please re-enter." if reenter_or_add == "r"
    if reenter_or_add == "a"
      default_candidates << vote_for.downcase
      track_vote << 1
      num_of_vote += 1
    end
  end
end

puts "\nELECTION RESULTS...."
# Re-print the final election candidates
candidate_list(default_candidates)
puts "\n\nVote Summary:"
# Print total votes for each candidate
(0...default_candidates.length).each do | num |
  puts "#{ (default_candidates[num]).upcase } - #{ track_vote[num] } vote(s)"
end

# Verify a winner or a tie
case track_vote.count(track_vote.max) 
when 1 then puts "\nWINNER is #{ default_candidates[track_vote.index(track_vote.max)].upcase }!"
else 
  puts "\nThere is a tie in the election, we haven't had a winner yet."
end
