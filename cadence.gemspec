Gem::Specification.new do |s|
  s.name              = "cadence"
  s.version           = "0.0.1"
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = "Interval/period callback library"
  s.homepage          = "http://github.com/mtodd/cadence"
  s.email             = "mtodd@highgroove.com"
  s.authors           = [ "Matt Todd" ]

  s.files             = %w( README.textile Rakefile )
  s.files            += Dir.glob("lib/**/*")
  s.files            += Dir.glob("test/**/*")

  s.description = <<-description
    Track counts and compute rate of iteration. Set up callbacks for various
    intervals such as every n increments or every n ticks.
    
    computer = Cadence::Computer.new do |c|
      c.every 5 do
        p [:completed_processing, n]
      end
    end
    
    computer.start do |c|
      1.upto(100) do |n|
        c.next
        # do magic here
      end
    end
    
    Mostly intended for providing intermitent feedback of the progress of tasks
    that will run for lengthy periods of time.
    
    Rudimentary support for time-based callbacks is possible through #ticks.
  description
end
