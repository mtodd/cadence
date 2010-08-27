class Cadence::Computer::Counter
  
  attr_accessor :count, :triggers
  
  def initialize(count = 0)
    @count    = 0
    @triggers = {}
  end
  
  def every(n = 1, &block)
    @triggers[n] = block
  end
  
  def next
    @count += 1
    @triggers.each do |(n, trigger)|
      instance_eval(&trigger) if @count % n == 0
    end
  end
  
  def n
    @count
  end
  
end
