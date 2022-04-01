require 'rainbow'
require 'json'

FILE_PATH = 'jobs.json'.freeze

class JobList
  # A class to load and manipulate the jobs file.
  attr_reader :jobs

  def initialize
    @jobs = JSON.load_file(FILE_PATH, symbolize_names: true)
  end

  def add_job(name)
    job_item = { name: name, status: "incomplete" }
    @jobs << job_item
  end

  def update_job(name, status)
    @jobs = @jobs.map { |job| job[:name] == name ? { name: job[:name], status: status } : job }
  end

  # Writes to json file
  def save_jobs
    File.write(FILE_PATH, JSON.pretty_generate(@jobs))
  end

  def get_status(name)
    job = @jobs.find { |job_item| job_item.name == name }
    job.status
  end

  def display
    puts
    @jobs.each { |job| puts job }
    nil
  end
end
