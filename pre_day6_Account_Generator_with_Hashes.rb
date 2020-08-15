# Now that we know about hashes, we will refactor your original account generator code 
# to utilize arrays with hashes. Since each student has three pieces of data, 
# we will utilize a hash to store these three pieces of data, related to one another.

# This is a better solution because this will keep each student record together instead of 
# having three separate arrays with the student data. When a new student record is created, 
# one hash needs to be added to the array rather than three pieces of data to individual arrays. 
# This also scales much better as we add more pieces of information on each student. 
# If we had 20 pieces of data on each student that would be a lot of arrays!

# Complete the following refactor steps:
# Utilize a single array variable to store all student information, instead of three individual arrays. 
# This array will contain many hashes.
# Utilize a single loop to drive the hash population (you may have nested loops inside this loop 
# for other functionality):
# accept user input for the student's name
# generate random student ID
# generate student email address from previous pieces of data
# Update the printing functionality to utilize this new hash variable to print out student roster

# Create an array to store all student info
student_information = []
# Create an array to deal with id# duplicates
id_duplicate = []

time_loop = 5
puts "Please enter #{ time_loop } student name(s) (First and last name)."
# A single loop to drive the hash population
time_loop.times do |num|
  # Get a student name and remove leading and trailing whitespaces
  print "First name of student ##{ num + 1 } ==> "
  first_name = gets.chomp.strip
  while first_name.empty?
    print "First name of student ##{ num + 1 } can't be empty, please enter again ==> "
    first_name = gets.chomp.strip
  end
  print "Last name of student ##{ num + 1 } ==> "
  last_name = gets.chomp.strip
  while last_name.empty?
    print "Last name of student ##{ num + 1 } can't be empty, please enter again ==> "
    last_name = gets.chomp.strip
  end

  # Generate a hash to store all info on a student
  student_information[num] = Hash.new
  student_information[num][:name] = "#{ first_name.upcase } #{ last_name.upcase }" 
  # Generate random student ID without duplicates
  id_number = rand(111_111..999_999)
  while id_duplicate.include? id_number
    id_number = rand(111_111..999_999)
  end
  id_duplicate.push(id_number)
  student_information[num][:id] = id_number
  # Generate student email with handling first names with a space and last 3 digits of ID# less than 100 
  if first_name.match(" ")
    student_information[num][:email] = "#{ first_name[0].upcase }#{ first_name[first_name.index(" ") + 1].upcase }#{ last_name.upcase }#{ id_number.to_s[3, 5] }@adadevelopersacademy.org"
  else
    student_information[num][:email] = "#{ first_name[0].upcase }#{ last_name.upcase }#{ id_number.to_s[3, 5] }@adadevelopersacademy.org"
  end
end

# Print out student info
print "Name\t\t\t\t", " ID\t", " Email\n"
student_information.each { |student| puts "#{ student[:name].ljust(25) }\t #{ student[:id] }\t #{ student[:email] }" } 
