# We are going to write a program that generates some student information. 
# This exercise will practice our skills with strings, random numbers, arrays and iterators.

# Requirements
# You will start by creating three arrays:
# An array that will contain student names
# An array that will store student ID numbers
# An array that will contain student email addresses

# Note Make sure to name your variables appropriately so that 
# it is easy to deduce the information stored in each array and that this information is not singular. 
# e.g. flowers = ["lily", "rose", "gardenia", "daisy"] vs. flower = "tulip"

# Write a times loop that asks the user to enter in 5 student names (first and last name) and 
# store those values in the first array in all uppercase even if the information is not entered 
# by the user in uppercase.

# Write a times loop to generate random student ID numbers from 111111 to 999999 and 
# put these values to the student ID number array.
# Example output:
# Write a times loop to generate student email addresses in the format: 
# (first inital)+(last name)+(last 3 digits of student ID number)@adadevelopersacademy.org 

# Write the code which will print out all the student names, ID numbers, and email addresses in parallel.

# Optional Enhancements

# make sure none of the IDs are duplicates
# account for ID numbers whose last 3 digits are less than 100 (e.g. 111008) 
# because these ID numbers will generate an email address with less than 3 digits at the end 
# without special cases.
# on email generation, account for first names with a space in them
# e.g. if the first name is "Mary Jane", then the first initial should be "MJ" rather than just "M"

# create three arrays
student_names = []
student_ids = []
student_emails = []

# Ask a user to enter 5 times thru times loop
time_loop = 5
puts "Please enter #{ time_loop } student name(s) (First and last name)."
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

  # Store names in uppercase 
  student_names.push("#{ first_name.upcase } #{ last_name.upcase }")
  # Generate random student ID numbers from 111111 to 999999 without duplicates
  id_number = rand(111_111..999_999)
  while student_ids.include? id_number
    id_number = rand(111_111..999_999)
  end
  student_ids.push(id_number)
  # Generate student email with handling first names with a space and last 3 digits of ID# less than 100 
  if first_name.match(" ")
    student_emails.push("#{ first_name[0].upcase }#{ first_name[first_name.index(" ") + 1].upcase }#{ last_name.upcase }#{ id_number.to_s[3, 5] }@adadevelopersacademy.org")
  else
    student_emails.push("#{ first_name[0].upcase }#{ last_name.upcase }#{ id_number.to_s[3, 5] }@adadevelopersacademy.org")
  end
end

def format_output(input_array)
  print "\n| Value |"
  input_array.each { |value| print " \"#{ value }\" |" }
  print "\n| :---- |"
  input_array.each { |value| print " :","-" * (value.to_s.length + 1)," |" }
  print "\n| Index |"
  input_array.each_with_index { |value, index| print " [#{ index }]"," " * (value.to_s.length - 1)," |" }
  puts "\n"
end
# Print out the information in each array as Example output
format_output(student_names)
format_output(student_ids)
format_output(student_emails)

# Print out information in parallel
print "\nName\t\t\t\t", " ID\t", " Email\n"
student_names.each_with_index { |value, index| puts "#{ value.ljust(25) }\t #{ student_ids[index] }\t #{ student_emails[index] }" } 


# Haven't done yet
# read in the student names from a file instead of the user and make the array size according 
# to the number of names