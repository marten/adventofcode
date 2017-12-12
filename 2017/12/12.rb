require 'set'
require 'ap'

nodes = {}
ARGF.readlines.each do |line|
  id, *links = line.split(' <-> ')

  id = id.strip
  links = links.join('')

  nodes[id] ||= Set.new
  links.split(', ').each do |link|
    link = link.strip
    nodes[link] ||= Set.new
    nodes[id] << link
  end
end

discovered = Set.new
groups = 0

while discovered.size < nodes.size
	seed = (nodes.keys.to_set - discovered).first

	queue = Queue.new
	queue << seed

	group = Set.new
	while !queue.empty?
		id = queue.pop
		next if group.include? id
		group << id

		nodes[id].each do |linked|
			queue << linked
		end
	end

	discovered += group
	groups += 1

  if seed == "0"
    puts "12a: Nodes in group 0: #{group.size}"
  end
end

puts "12b: Number of groups: #{groups}"