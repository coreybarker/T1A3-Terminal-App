require 'rainbow'
require_relative './runsheet'
require_relative './job_list'

HEADER = "--------------------------------------------------------------".freeze
EXIT_INFO = "To EXIT application, type 'Exit'".freeze

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
  else
    puts Rainbow(title).green.center(HEADER.length)
  end
end

def print_header(title, color: "green", show_exit_info: true)
  puts "#{HEADER}\n"
  print_header_title(title, color)
  puts "#{HEADER}\n"
  puts "#{EXIT_INFO}\n\n" if show_exit_info
end

def clear
  puts "\e[2J\e[f"
end

# used to print each list by status
def filter_jobs_by_status(jobs, status)
  jobs.filter { |job| job[:status] == status }
end

# # always use together!
# jobs.update_job("raking", "complete")
# jobs.save_jobs

# Begin terminal output... #

clear
print_header(Rainbow("Welcome to the virtual Job Run Sheet!").orange.center(HEADER.length), show_exit_info: false)
print "Type #{Rainbow('ANY').green} key to continue: "

input_attempts = 0
while input_attempts < 3
  user_input = gets.chomp.capitalize

  if user_input == ""
    input_attempts += 1
    if input_attempts == 3
      clear
      puts "Application has ended, try again..."
      exit
    else
      puts "Incorrect input, please try again: "
    end
  else
    clear
    break
  end
end

puts HEADER
puts Rainbow("Choose a job list to view OR Add a new job!").blue.center(HEADER.length)
puts HEADER
puts Rainbow("Incomplete Job List").red + "-- Type '1'".center(HEADER.length)
puts Rainbow("Staged     Job List").orange + "-- Type '2'".center(HEADER.length)
puts Rainbow("Completed  Job List").green + "-- Type '3'".center(HEADER.length)
puts Rainbow("Add New Job        ").blue + "-- Type '4'".center(HEADER.length)

jobs_list = JobList.new

loop do
  list_choice = gets.strip.downcase

  case list_choice
  when "exit"
    clear
    break

  when "1"
    incomplete_jobs = filter_jobs_by_status(jobs_list.jobs, "incomplete")

    clear
    print_header("You are viewing: Incomplete Jobs", color: "red")

    incomplete_jobs.each do |job|
      print_job(job)
    end
    puts "\nType job name to #{Rainbow('STAGE').orange} job\n"

  when "2"
    staged_jobs = filter_jobs_by_status(jobs_list.jobs, "staged")

    clear
    print_header("You are viewing: Staged Jobs", color: "orange")
    staged_jobs.each do |job|
      print_job(job)
    end
    puts "\nType job name to #{Rainbow('COMPLETE').green} job\n"
    job_name = gets.strip.downcase

    jobs_list.update_job(job_name, "complete")
    jobs_list.save_jobs

  when "3"
    complete_jobs = filter_jobs_by_status(jobs_list.jobs, "complete")

    clear
    print_header("You are viewing: Completed Jobs")

    complete_jobs.each do |job|
      print_job(job)
    end
    puts "\nType job name to #{Rainbow('REMOVE').red} job\n"

  when "4"
    clear
    print_header("Adding new job to Incomplete Jobs List", color: "blue")
    puts "Input job name: "
    job_name = gets.strip.downcase

    jobs_list.add_job(job_name)
    jobs_list.save_jobs
    # list_choice = "1"
  else
    puts "Invalid input, try again.."
  end
end

puts "Thanks for using #{Rainbow('Virtual Job Run Sheet').orange}\n"
