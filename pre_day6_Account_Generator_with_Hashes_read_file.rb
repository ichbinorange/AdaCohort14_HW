### Open a csv file

# Create an array to store all student info
student_information = []
# Create an array to deal with id# duplicates
id_duplicate = []

# Open a file thru argument
# filename = ARGV.first
# Or, open a file thru user prompt
print "Please type the filename: "
filename = $stdin.gets.chomp
student_name_csv = open(filename)

puts "\nHere's your file \"#{filename}\":"
student_name_csv.readlines.map(&:chomp).each_with_index do |individual, index| 
  # Skip line 1 in csv file while it is header
  if index != 0
    # Handle the name data from csv file
    student_information[index] = Hash.new
    student_information[index][:name] = individual.split(",")
    # Get a student's first and last name as well as remove leading and trailing whitespaces
    first_name = student_information[index][:name][0].strip
    last_name = student_information[index][:name][1].strip
    
    # Generate random student ID without duplicates
    id_number = rand(111_111..999_999)
    while id_duplicate.include? id_number
      id_number = rand(111_111..999_999)
    end
    id_duplicate.push(id_number)
    student_information[index][:id] = id_number
    
    # Generate student email with handling first names w/ space, last name w/ space, and the last 3 digits of ID# 
    first_name_for_email = String.new
    first_name.split(" ").each do |name_element|
      first_name_for_email << name_element[0]
    end

    last_name_for_email = String.new
    last_name_for_email = last_name if last_name.split.count == 1
    if last_name.split.count > 1
      (last_name.split.count - 1).times do |index|
        last_name_for_email << last_name.split[index][0]
      end
      last_name_for_email << last_name.split[-1]
    end
    student_information[index][:email] = "#{ first_name_for_email.upcase }#{ last_name_for_email.upcase }#{ id_number.to_s[3, 5] }@adadevelopersacademy.org"
  end
end

# Remove nil and blank string in an array, i.e. index 0
student_information.compact!.delete_if{|arrVal| arrVal.class == String and arrVal.empty?}

# Print out student info
print "%-30s %-10s" % ["\nName", " ID"], " Email\n"
student_information.each { |student| print "%-30s %-10s" % ["#{ student[:name][0].strip + " " + student[:name][1].strip}", "#{ student[:id] }"],"#{ student[:email] }\n" } 

student_name_csv.close
puts "\n\"#{ filename }\" is closed? #{ student_name_csv.closed? }"