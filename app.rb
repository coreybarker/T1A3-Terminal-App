require 'rainbow'
# require 'tty-prompt'
require_relative './runsheet'

job_items = { mopping: "Incomplete", sweeping: "Incomplete" }
incomplete = RunSheet.new("Incomplete Jobs", job_items)
staged = RunSheet.new("Staged Jobs", job_items)
complete = RunSheet.new("Completed Jobs", job_items)

clear
puts HEADER
puts Rainbow("Welcome to the virtual Job Run Sheet!").orange.center(HEADER.length)
puts HEADER
print "Login require -- Type #{Rainbow('Login').green} to continue: "

login_attempts = 0
while login_attempts < 3
  get_login = gets.chomp.capitalize

  break if login_attempts == 'login'

  if get_login == ""
    login_attempts += 1
    if login_attempts == 3
      clear
      puts "Application ending, try again..."
    else
      puts "Incorrect login, please try again: "
    end
  else
    clear
    break
  end
end

puts HEADER
puts Rainbow("Choose a job list to view!").blue.center(HEADER.length)
puts HEADER
puts Rainbow("Incomplete Job List").red + "-- Type '1'".center(HEADER.length)
puts Rainbow("Staged     Job List").orange + "-- Type '2'".center(HEADER.length)
puts Rainbow("Completed  Job List").green + "-- Type '3'".center(HEADER.length)

loop do
  list_choice = gets.strip.downcase

  case list_choice
  when "logout"
    clear
    break
  when "1"
    clear
    incomplete.welcome_incomplete
    puts "Type job name to #{Rainbow('STAGE').orange} job"
    incomplete.print_list
    puts "\nTo EXIT application, type 'Logout'"
  when "2"
    clear
    staged.welcome_staged
    puts "Type job name to #{Rainbow('APPROVE').green} job"
    staged.print_list
    puts "\nTo EXIT application, type 'Logout'"
  when "3"
    clear
    complete.welcome_complete
    puts "Type job name to #{Rainbow('REMOVE').red} job"
    complete.print_list
    puts "\nTo EXIT application, type 'Logout'"
  else
    puts "Invalid input, try again.."
  end
end

puts "Thanks for using #{Rainbow('Virtual Job Run Sheet').orange}\n"
