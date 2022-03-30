class JobItem
    attr_reader :name, :status

    def initialize(name, status)
        @name = name
        @status = status
    end

    def to_s
        return "#{@name}:     #{@status}"
    end
end
