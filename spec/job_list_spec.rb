require './job_list'

FAKE_FILE_PATH = "test_jobs.json".freeze

describe JobList do
  describe "add_job" do
    jobs = []
    jobs_list = JobList.new(jobs, FAKE_FILE_PATH)

    it "should add a new job to the jobs list" do
      job_name = "sleeping"

      jobs_list.add_job(job_name)
      expected_job = { name: job_name, status: "incomplete" }
      found_job = jobs_list.jobs.find { |job| job[:name] == job_name }

      expect(found_job).to eq(expected_job)
    end

    it "should not add a new job if the job name is invalid" do
      invalid_name = ""

      jobs_list.add_job(invalid_name)
      found_job = jobs_list.jobs.find { |job| job[:name] == invalid_name }

      expect(found_job).to eq(nil)
    end
  end

  describe "update_job" do
    jobs = [{ name: "sleeping", status: "staged" }]

    it "should update the status of an existing job" do
      jobs_list = JobList.new(jobs, FAKE_FILE_PATH)

      jobs_list.update_job("sleeping", "complete")
      expected_job = { name: "sleeping", status: "complete" }
      found_job = jobs_list.jobs.find { |job| job[:name] == "sleeping" }

      expect(found_job).to eq(expected_job)
    end

    it "should leave jobs unchanged when given invalid job name" do
      jobs_list = JobList.new(jobs, FAKE_FILE_PATH)
      jobs_list.update_job("", "complete")

      expect(jobs_list.jobs).to eq(jobs)
    end
  end

  describe "remove_job" do
    it "should remove a job by name" do
      jobs = [{ name: "sleeping", status: "staged" }]
      jobs_list = JobList.new(jobs, FAKE_FILE_PATH)

      jobs_list.remove_job("sleeping")

      expect(jobs_list.jobs).to eq([])
    end
  end
end