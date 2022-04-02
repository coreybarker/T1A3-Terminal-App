require 'rainbow'
require 'json'

FILE_PATH = 'jobs.json'.freeze

class JobList
  # A class to load and manipulate the jobs file.
  attr_reader :jobs

  def initialize
    @jobs = JSON.load_file(FILE_PATH, symbolize_names: true)
  end

  # Adds job to app memory from user input
  def add_job(name)
    job_item = { name: name, status: "incomplete" }
    @jobs << job_item
  end

  # Updates job status by name to app memory from user input
  def update_job(name, status)
    @jobs = @jobs.map { |job| job[:name] == name ? { name: job[:name], status: status } : job }
  end

  def remove_job(name)
    job_item = { name: name, status: "complete" }
    @jobs << job_item.delete
  end

  # Writes user input from app memory to json file
  def save_jobs
    File.write(FILE_PATH, JSON.pretty_generate(@jobs))
  end
end
