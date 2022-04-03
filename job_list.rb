require 'rainbow'
require 'json'

# A class to load and manipulate the jobs file.
class JobList
  attr_reader :jobs

  def initialize(jobs, file_path)
    @jobs = jobs
    @file_path = file_path
  end

  # Adds job to app memory from user input
  def add_job(name)
    if name == ""
      puts "Invalid input, can't be empty"
    else
      job_item = { name: name, status: "incomplete" }
      @jobs << job_item
    end
  end

  # Updates job status by name to app memory from user input
  def update_job(name, status)
    if name == ""
      puts "Invalid input, can't be empty"
    else
      @jobs = @jobs.map { |job| job[:name] == name ? { name: job[:name], status: status } : job }
    end
  end

  def remove_job(name)
    @jobs = @jobs.filter { |job| job[:name] != name }
  end

  # Writes user input from app memory to json file
  def save_jobs
    File.write(@file_path, JSON.pretty_generate(@jobs))
  end
end
