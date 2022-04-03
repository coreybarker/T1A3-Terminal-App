require 'rainbow'
require_relative './job_list'

# Page styling and headings
HEADER = "--------------------------------------------------------------".freeze
EXIT_INFO = "To EXIT application, type 'Exit'".freeze

def clear
    puts "\e[2J\e[f"
end

def print_job(job_info)
  puts "Name: #{job_info[:name]} | Status: #{job_info[:status]}\n"
end

def print_header_title(title, color)
  case color
  when "red"
    puts Rainbow(title).red.center(HEADER.length)
  when "orange"
    puts Rainbow(title).orange.center(HEADER.length)
  when "blue"
    puts Rainbow(title).blue.center(HEADER.length)
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
  puts HEADER.to_s
  puts Rainbow("HELP INSTRUCTIONS BELOW").pink.center(HEADER.length)
  puts Rainbow("\n Welcome to the help menu").white.center(HEADER.length)
  puts "\nTyping any key upon starting, enters you into the application."
  puts "If no key is enter, after 3 attempts, the application will exit."
  puts Rainbow("\nLIST OF COMMANDS BELOW").white
  puts "\n'#{Rainbow('h').white}'  -- Takes you to the Helper page (You are viewing now)"
  puts "'#{Rainbow('1').white}'  -- Takes you to the Incomplete Job List page"
  puts "'#{Rainbow('2').white}'  -- Takes you to the Staged Job List page"
  puts "'#{Rainbow('3').white}'  -- Takes you to the Complete Job List page"
  puts "'#{Rainbow('4').white}'  -- Takes you to the Add New Job page"
  puts "'#{Rainbow('5').white}'  -- Takes you to the Remove Job page"
  puts "\n'#{Rainbow('Exit').white}' -- Exits you out of the application"
end

# Method to clear terminal screen
def clear
  puts "\e[2J\e[f"
end

# used to print each list by status
def filter_jobs_by_status(jobs, status)
  jobs.filter { |job| job[:status] == status }
end

# Begin terminal output...

clear
print_header(Rainbow("Welcome to the Virtual Job Organiser!").orange.center(HEADER.length), show_exit_info: false)
print "Type #{Rainbow('ANY').green} key and press 'Enter' to continue: "

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

puts "Type '#{Rainbow('h').white}' to view HELP MENU"
puts HEADER
puts Rainbow("Choose a job list to view OR Add a new job!").blue.center(HEADER.length)
puts HEADER
puts Rainbow("Incomplete Job List").brown + "-- Type '1'".center(HEADER.length)
puts Rainbow("Staged     Job List").orange + "-- Type '2'".center(HEADER.length)
puts Rainbow("Completed  Job List").green + "-- Type '3'".center(HEADER.length)
puts Rainbow("Add New Job        ").blue + "-- Type '4'".center(HEADER.length)
puts Rainbow("Remove a Job       ").red + "-- Type '5'".center(HEADER.length)

# Creates a new joblist instance
jobs_list = JobList.new

# Main application loop to choose job lists etc
loop do
  list_choice = gets.strip.downcase

  case list_choice

  # Exit option
  when "exit"
    clear
    break

  # Help option
  when 'h'
    clear
    print_helper

  # Menu option 1
  when "1"
    incomplete_jobs = filter_jobs_by_status(jobs_list.jobs, "incomplete")

    clear
    print_header("You are viewing: Incomplete Jobs", color: "brown")

    incomplete_jobs.each do |job|
      print_job(job)
    end
    puts "\nType job name to #{Rainbow('STAGE').orange} job\n"
    job_name = gets.strip.downcase

    case job_name
    when job_name
      jobs_list.update_job(job_name, "staged")
      jobs_list.save_jobs
      clear
      print_header("You are viewing: Incomplete Jobs", color: "brown")
      puts "Job is now staged.."
      puts "\nReturn to Incomplete jobs list -- Type '1'"
      puts "View Staged jobs               -- Type '2'"
      puts "View Complete jobs             -- Type '3'"
      puts "Add new job                    -- Type '4'"
      puts "Remove a job                   -- Type '5'"
    when ""
      puts "Invalid input, try again.."
      redo
    end

  # Menu option 2
  when "2"
    staged_jobs = filter_jobs_by_status(jobs_list.jobs, "staged")

    clear
    print_header("You are viewing: Staged Jobs", color: "orange")
    staged_jobs.each do |job|
      print_job(job)
    end
    puts "\nType job name to #{Rainbow('COMPLETE').green} job\n"
    job_name = gets.strip.downcase

    case job_name
    when job_name
      jobs_list.update_job(job_name, "complete")
      jobs_list.save_jobs
      clear
      print_header("You are viewing: Staged Jobs", color: "orange")
      puts "Job is has been completed.."
      puts "\nReturn to Incomplete jobs list -- Type '1'"
      puts "View Staged jobs               -- Type '2'"
      puts "View Complete jobs             -- Type '3'"
      puts "Add new job                    -- Type '4'"
      puts "Remove a job                   -- Type '5'"
    when ""
      puts "Invalid input, try again.."
      redo
    end

  # Menu option 3
  when "3"
    complete_jobs = filter_jobs_by_status(jobs_list.jobs, "complete")

    clear
    print_header("You are viewing: Completed Jobs")
    complete_jobs.each do |job|
      print_job(job)
    end
    puts "\nReturn to Incomplete jobs list -- Type '1'"
    puts "View Staged jobs               -- Type '2'"
    puts "View Complete jobs             -- Type '3'"
    puts "Add new job                    -- Type '4'"
    puts "Remove a job                   -- Type '5'"

  # Menu option 4
  when "4"
    clear
    print_header("Adding new job to Incomplete Jobs List", color: "blue")
    puts "Input job name: "
    job_name = gets.strip.downcase

    case job_name
    when job_name
      jobs_list.add_job(job_name)
      jobs_list.save_jobs
      clear
      print_header("Adding new job to Incomplete Jobs List", color: "blue")
      puts "Job is now added.."
      puts "\nReturn to Incomplete jobs list -- Type '1'"
      puts "View Staged jobs               -- Type '2'"
      puts "View Complete jobs             -- Type '3'"
      puts "Add new job                    -- Type '4'"
      puts "Remove a job                   -- Type '5'"
    when ""
      puts "Invalid input, try again.."
      redo
    end
  when "5"
    # remove_job = filter_jobs_by_status(jobs_list.jobs, "")

    clear
    print_header("You are viewing: Remove job from Job List", color: "red")
    @jobs.each do |job|
      print_job(job)
    end
    puts "Input job name: "
  # job_name = gets.strip.downcase

  # If no input, error message
  else
    puts "Invalid input, try again.."
  end
end

# Exit message
puts HEADER
puts "Thanks for using #{Rainbow('Virtual Job Organiser').orange}\n"
puts HEADER
