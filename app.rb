require 'rainbow'
require_relative './job_list'

JOBS_FILE_PATH = 'jobs.json'.freeze

# Page styling and headings
HEADER = "--------------------------------------------------------------".freeze
EXIT_INFO = "To EXIT application, type '#{Rainbow('Exit').white}'".freeze

# Method to clear terminal screen
def clear
  puts "\e[2J\e[f"
end

def print_job(job_info)
  job_str = "Name: #{job_info[:name]} | Status: #{job_info[:status]}\n"

  case job_info[:status]
  when "incomplete"
    puts Rainbow(job_str).red
  when "staged"
    puts Rainbow(job_str).yellow
  when "complete"
    puts Rainbow(job_str).green
  else
    puts job_str
  end
end

def print_header_title(title, color)
  case color
  when "red"
    puts Rainbow(title).red.center(HEADER.length)
  when "orange"
    puts Rainbow(title).orange.center(HEADER.length)
  when "blue"
    puts Rainbow(title).blue.center(HEADER.length)
  when "pink"
    puts Rainbow(title).pink.center(HEADER.length)
  else # Green will be the default
    puts Rainbow(title).green.center(HEADER.length)
  end
end

def print_header(title, color: "green", show_exit_info: true)
  puts "#{HEADER}\n"
  print_header_title(title, color)
  puts "#{HEADER}\n"
  puts "#{EXIT_INFO}\n\n" if show_exit_info
end

# Method to view help instructions
def print_helper
  clear
  print_header("HELP INSTRUCTIONS BELOW", color: "pink", show_exit_info: false)
  puts Rainbow("\n Welcome to the help menu").white.center(HEADER.length)
  puts "\nTyping any key upon starting, enters you into the application."
  puts "If no key is enter, after 3 attempts, the application will exit."
  puts Rainbow("\nLIST OF COMMANDS BELOW").white
  puts "\n'#{Rainbow('h').white}'  -- Takes you to the Helper page (You are viewing now)"
  puts "'#{Rainbow('1').white}'  -- Takes you to the View All Jobs List page"
  puts "'#{Rainbow('2').white}'  -- Takes you to the Incomplete Jobs List page"
  puts "'#{Rainbow('3').white}'  -- Takes you to the Staged Jobs List page"
  puts "'#{Rainbow('4').white}'  -- Takes you to the Complete Jobs List page"
  puts "'#{Rainbow('5').white}'  -- Takes you to the Add New Job page"
  puts "'#{Rainbow('6').white}'  -- Takes you to the Remove Job page"
  puts "\n'#{Rainbow('Exit').white}' -- Exits you out of the application"
end

# used to filter a given list by status
def filter_jobs_by_status(jobs, status)
  jobs.filter { |job| job[:status] == status }
end

# Begin terminal output...

clear
print_header("Welcome to the Virtual Job Organiser!", color: "orange", show_exit_info: false)
print "Type #{Rainbow('ANY').green} key and press '#{Rainbow('Enter').white}' to continue: "

# While loop to enter application
input_attempts = 0
while input_attempts < 3
  user_input = gets.chomp.capitalize

  if user_input == ""
    input_attempts += 1
    if input_attempts == 3
      clear
      puts "The application has ended, try again..."
      puts HEADER
      puts "Thanks for using #{Rainbow('Virtual Job Organiser').orange}\n"
      puts HEADER
      exit
    else
      print "Incorrect input, please try again: "
    end
  else
    clear
    break
  end
end

# Creates a new joblist instance
loaded_jobs = JSON.load_file(JOBS_FILE_PATH, symbolize_names: true)
jobs_list = JobList.new(loaded_jobs, JOBS_FILE_PATH)

# Main application loop to choose job lists etc
loop do
  clear
  puts "Type '#{Rainbow('h').white}' to view HELP MENU"
  print_header("Choose a job list to view OR Add a new job!", color: "blue", show_exit_info: true)
  puts "#{Rainbow('View All Jobs').pink}       -- Type and Submit '#{Rainbow('1').white}'"
  puts "#{Rainbow('Incomplete Job List').brown} -- Type and Submit '#{Rainbow('2').white}'"
  puts "#{Rainbow('Staged Job List').orange}     -- Type and Submit '#{Rainbow('3').white}'"
  puts "#{Rainbow('Completed Job List').green}  -- Type and Submit '#{Rainbow('4').white}'"
  puts "#{Rainbow('Add New Job').blue}         -- Type and Submit '#{Rainbow('5').white}'"
  puts "#{Rainbow('Remove a Job').red}        -- Type and Submit '#{Rainbow('6').white}'"

  list_choice = gets.strip.downcase

  case list_choice

  # Exit option
  when "exit"
    clear
    break

  # Help option
  when "h"
    clear
    print_helper
    puts "\nPress #{Rainbow('ENTER').white} to return to menu"
    gets
  # Menu option 1
  when "1"
  clear
  print_header("You are viewing: All Jobs")

  jobs_list.jobs.each do |job|
    print_job(job)
  end
  puts "\nPress #{Rainbow('ENTER').white} to return to menu"
  gets

  # Menu option 2
  when "2"
    clear
    print_header("You are viewing: Incomplete Jobs", color: "brown")
    incomplete_jobs = filter_jobs_by_status(jobs_list.jobs, "incomplete")

    incomplete_jobs.each do |job|
      print_job(job)
    end
    puts "\nType job name to #{Rainbow('STAGE').orange} job OR '#{Rainbow('back').white}' to return to menu\n"
    job_name = gets.strip.downcase
    if job_name != 'back'
      jobs_list.update_job(job_name, "staged")
      jobs_list.save_jobs
    end

  # Menu option 3
  when "3"
    clear
    print_header("You are viewing: Staged Jobs", color: "orange")
    staged_jobs = filter_jobs_by_status(jobs_list.jobs, "staged")

    staged_jobs.each do |job|
      print_job(job)
    end
    puts "\nType job name to #{Rainbow('COMPLETE').green} job OR '#{Rainbow('back').white}' to return to menu\n"
    job_name = gets.strip.downcase
    if job_name != 'back'
      jobs_list.update_job(job_name, "complete")
      jobs_list.save_jobs
    end

  # Menu option 4
  when "4"
    clear
    print_header("You are viewing: Completed Jobs")
    complete_jobs = filter_jobs_by_status(jobs_list.jobs, "complete")

    complete_jobs.each do |job|
      print_job(job)
    end
    puts "\nPress #{Rainbow('ENTER').white} to return to menu"
    gets
  # Menu option 5
  when "5"
    clear
    print_header("Adding new job to Incomplete Jobs List", color: "blue")
    puts "Input job name to ADD job OR type '#{Rainbow('back').white}' to return to menu: "
    job_name = gets.strip.downcase
    if job_name != 'back'
      jobs_list.add_job(job_name)
      jobs_list.save_jobs
    end
  # Menu option 6
  when "6"
    clear
    print_header("You are viewing: Remove job from Job List", color: "red")
    jobs_list.jobs.each do |job|
      print_job(job)
    end
    puts "\nInput job name to REMOVE job OR type '#{Rainbow('back').white}' to return to menu:  "
    job_name = gets.strip.downcase
    if job_name != 'back'
      jobs_list.remove_job(job_name)
      jobs_list.save_jobs
    end

  # If no input, error message
  else
    puts "Invalid menu selection, try again.."
  end
end

# Exit message
print_header("Thanks for using Virtual Job Organiser", color: "orange", show_exit_info: false)
