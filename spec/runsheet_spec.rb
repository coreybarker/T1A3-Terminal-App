require './jobitem'
require './joblist'
require './addjob'
require './runsheet'

describe JobItem do
    it 'should return the job name' do
        name = "Sweeping"
        status = "Incomplete"
        job_item = JobItem.new(name, status)
        expect(job_item.name).to eq(name)
    end
end

describe JobItem do
    it 'should return the job status' do
        name = "Sweeping"
        status = "Incomplete"
        job_item = JobItem.new(name, status)
        expect(job_item.status).to eq(status)
    end
end

describe JobList do
    it 'Should be able to get a job name and status' do
        name = "Sweeping"
        status = "Incomplete"
        list = JobList.new
        list.add_job(name, status)
        expect(list.get_status(name)).to eq(status)
    end
    it 'Should be able to add a job' do
        name = "Sweeping"
        status = "Incomplete"
        list = JobList.new
        list.add_job(name, status)
        expect(list.get_jobs.length).to be(1)
    end
end

describe AddJob do
    it 'Should be able to stage a job to be added' do
        stagejob = AddJob.new
        name = "Mopping"
        status = "Complete"
        stagejob.add_item(name, status)
        expect(stagejob.get_items.length).to be(1)
    end
end

describe RunSheet do
    it 'Should make a runsheet with a name' do
        name = "Incomplete Job Runsheet"
        job_items = {}
        runsheet = RunSheet.new(name, job_items)
        expect(runsheet.name).to eq(name)
    end
    it 'Should make a runsheet with a joblist' do
        name = "Incomplete Job Runsheet"
        job_items = { mopping: "Complete", sweeping: "Incomplete" }
        runsheet = RunSheet.new(name, job_items)
        expect(runsheet.joblist.get_jobs.length).to be(2)
    end
    it 'Should add a job to job list' do
        name = "Incomplete Job Runsheet"
        job_items = { mopping: "Complete", sweeping: "Incomplete" }
        runsheet = RunSheet.new(name, job_items)
        job = "mopping"
        status = "Incomplete"
        runsheet.add_to_joblist(job, status)
        expect(runsheet.get_list.get_items.length).to be(1)
    end
    it 'Should define a welcome method' do
        name = "Incomplete Job Runsheet"
        job_items = { mopping: "Complete", sweeping: "Incomplete" }
        runsheet = RunSheet.new(name, job_items)
        expect(runsheet.welcome).to eq(nil)
    end
    it 'Should define a print_joblist method' do
        name = "Incomplete Job Runsheet"
        job_items = { mopping: "Complete", sweeping: "Incomplete" }
        runsheet = RunSheet.new(name, job_items)
        expect(runsheet.print_list).to eq(nil)
    end
end
