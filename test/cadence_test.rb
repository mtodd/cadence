$:.unshift(File.join(File.dirname(__FILE__), '..'))
require 'lib/cadence'

data = (1..100).to_a

computer = Cadence::Computer.new do |c|
  c.every 5 do
    p [:every, 5, n]
  end
  
  c.for(:tens).every do
    p [:tens, :every, n]
  end
  
  c.twenties.every 2 do
    p [:twenties, :every, 2, n]
  end
  
  c.ticks 1 do
    p [:tock, n, timestamp]
  end
end

computer.start do |c|
  data.each do |n|
    c.next
    c.tens.next if n % 10 == 0
    c.twenties.next if n % 20 == 0
    p [:n, n]
    sleep 0.02
  end
end
