require 'rainbow'
require_relative './jobitem'

class JobList
    def initialize
        @job_items = []
    end

    def add_job(name, status)
        job_item = JobItem.new(name, status)
        @job_items << job_item
    end

    def get_status(name)
        job = @job_items.find { |job_item| job_item.name == name }
        return job.status
    end

    def get_jobs
        return @job_items
    end

    def display
        puts 
        @job_items.each { |job| puts job }
        return nil
    end
end

# this is temporary test code
# joblist = JobList.new
# joblist.add_job("Sweeping", "Incomplete")
# joblist.add_job("Mop", "Incomplete")

# joblist.display
