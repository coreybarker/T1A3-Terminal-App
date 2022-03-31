require 'rainbow'
# require 'tty-prompt'
require_relative './job_list'
require_relative './add_job'

# Page styling
HEADER = "--------------------------------------------------------------\n".freeze

def clear
    puts "\e[2J\e[f"
end

class RunSheet
  attr_reader :name, :joblist

  def initialize(name, job_items)
    @name = name
    @joblist = JobList.new
    populate_joblist(job_items)
    @add_job = AddJob.new
  end

  def populate_joblist(job_items)
    job_items.each do |name, status|
      @joblist.add_job(name, status)
    end
  end

  def add_to_joblist(name, status)
    @add_job.add_item(name, status)
  end

  def get_list
    return @add_job
  end

  def welcome_incomplete
    puts HEADER
    puts Rainbow("You are viewing: #{@name}").red.center(HEADER.length)
    puts HEADER
  end

  def welcome_staged
    puts HEADER
    puts Rainbow("You are viewing: #{@name}").orange.center(HEADER.length)
    puts HEADER
  end

  def welcome_complete
    puts HEADER
    puts Rainbow("You are viewing: #{@name}").green.center(HEADER.length)
    puts HEADER
  end

  def logout
    puts
    puts "To exit type 'Logout'"
  end

  def print_list
    @joblist.display
  end

  def print_addjob
    if @add_job
      @add_job.display
      puts "Jobs added: "
      puts
    end
  end
end

# TTY::Prompt.new.mask("Enter password:")
