class AddJob
  def initialize
    @add_job_items = {}
  end

  def add_item(name, status)
    @add_job_items[name] = status
  end

  def get_items
    return @add_job_items
  end
end
