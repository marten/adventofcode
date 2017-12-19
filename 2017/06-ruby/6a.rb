require 'set'

state = ARGF.read.split(/\s+/).map(&:to_i)
states = Set.new
history = []

while !states.include?(state)
  puts state.inspect
  states << state
  history << state.dup


  max = state.max
  idx = state.index(max)
  state[idx] = 0
  for i in 1..max
    state[(idx + i) % state.size] += 1
  end
  # puts state.inspect
end

puts "Iterations needed: #{states.size}"
puts "Loop size: #{states.size - history.index(state)}"
