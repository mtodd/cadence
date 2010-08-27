class Cadence::Computer
  
  attr_accessor :started_at, :finished_at, :duration,
                :counter, :counters, :total
  
  def initialize
    @counter  = Counter.new
    @counters = {}
    @ticks    = {}
    
    yield self
  end
  
  ### Keys
  
  def for(key)
    self.counters[key] ||= Counter.new
  end
  def method_missing(method_name, *args, &block)
    self.for(method_name, &block)
  end
  
  ### Overall total and count tracking
  
  def every(n = 1, &block)
    @counter.every(n, &block)
  end
  def next
    @counter.next
    @ticks.each do |(n, (last, tick))|
      @ticks[n] = [self.duration.to_i, tick]
      instance_eval(&tick) if self.duration.to_i > last.to_i && self.duration.to_i % n == 0
    end
  end
  
  ### Timing
  
  def ticks(n = 1, &block)
    @ticks[n] ||= [nil, block]
  end
  
  ### Runtime
  
  def start
    @started_at   = self.timestamp
    yield self
    @finished_at  = self.timestamp
    
    @duration = @finished_at - @started_at
  end
  
  def timestamp
    Time.now
  end
  
  def duration
    self.timestamp.to_f - self.started_at.to_f
  end
  
  def rate
    # self.duration / self.counter.count
    self.counter.count / self.duration
  end
  
  def n
    self.counter.count
  end
  
end
