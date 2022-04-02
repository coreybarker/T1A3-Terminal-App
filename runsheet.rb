require 'rainbow'
# require 'tty-prompt'
require_relative './job_list'

class RunSheet
  attr_reader :name # :job_list

  def initialize(name, job_items)
    @name = name
    @joblist = JobList.new
    populate_joblist(job_items)
  end

  def populate_joblist(job_items)
    job_items.each do |name, _status|
      @joblist.add_job(name)
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
    puts Rainbow("You are viewing: Incomplete Jobs").red.center(HEADER.length)
    puts HEADER
  end

  def welcome_staged
    puts HEADER
    puts Rainbow("You are viewing: Staged Jobs").orange.center(HEADER.length)
    puts HEADER
  end

  def welcome_complete
    puts HEADER
    puts Rainbow("You are viewing: Completed Jobs").green.center(HEADER.length)
    puts HEADER
  end

  def welcome_add_job
    puts HEADER
    puts Rainbow("Adding new job to Incomplete Jobs List").blue.center(HEADER.length)
    puts HEADER
    puts
    puts "Type in the new job name:"
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
