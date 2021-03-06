@students = []

require 'csv'

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Please choose a file you wish to load a student list from"
  puts "5. Read source code"
  puts "9. Exit"
end


def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end


def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      choose_file
    when "5"
      read_source_code
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
    end
end


def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  while !name.empty? do
  student_array_input(name)
    puts "Now we have #{@students.count} students"
    name = STDIN.gets.chomp
  end
end


def show_students
  print_header
  print_students_list
  print_footer
end


def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end


def print_students_list
  @students.each do |student|
    puts "#{student[:name] } (#{student[:cohort]} cohort)"
  end
end


def print_footer
  puts "Overall, we have #{@students.count} great students"
end


def save_students
  CSV.open("students.csv", "w") do |csv|
    @students.each do |student|
      csv << [student[:name], student[:cohort]]
    end
  end
  puts "Previously entered student names have been succesfully saved."
end


def load_students (filename = "students.csv")
  @students = [] if @students.any?
  CSV.foreach(filename) do |row|
    name, cohort = row
    student_array_input(name,cohort)
  end
  puts "Student names from students.csv have been succesfully loaded. Please proceed to option 2 if you wish to see the list."
end


def student_array_input(name, cohort = "november")
  @students << {name: name, cohort: cohort.to_sym}
end


def try_load_students(filename)
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry #{filename} doesn't exist"
  end
end


def choose_file
  puts "Please specify a list you wish to load information from"
  filename = STDIN.gets.chomp
  try_load_students(filename)
end


def read_source_code
  $><<IO.read($0)
end

interactive_menu
