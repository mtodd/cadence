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
end

computer.start do |c|
  data.each do |n|
    c.next
    c.tens.next if n % 10 == 0
    p [:n, n]
  end
end
