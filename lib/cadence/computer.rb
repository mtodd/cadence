class Cadence::Computer
  
  attr_accessor :started_at, :finished_at, :duration,
                :counters, :total
  
  def initialize
    @counters = {}
    @counter  = Counter.new
    yield self
  end
  
  def for(key)
    self.counters[key] ||= Counter.new
  end
  def method_missing(method_name, *args, &block)
    self.for(method_name, &block)
  end
  
  def every(n = 1, &block)
    @counter.every(n, &block)
  end
  def next
    @counter.next
  end
  
  def start
    @started_at   = Time.now
    yield self
    @finished_at  = Time.now
    
    @duration = @finished_at - @started_at
  end
  
end
