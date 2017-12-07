class Node
  def initialize(name)
    @name = name
    @children ||= []
  end

  attr_reader :name, :weight, :children

  def weight=(val)
    @weight = val.to_i
  end

  def add_child(node)
    @children << node
    node.set_parent(self)
  end

  def set_parent(node)
    @parent = node
  end

  def root?
    !@parent
  end

  def balanced?
    return true if @children.empty?
    @children.map(&:cumulative_weight).uniq.size == 1
  end

  def cumulative_weight
    @weight + @children.map(&:cumulative_weight).sum
  end

  def inspect
    if children?
      "#{@name}:#{@weight} + (#{@children.map(&:inspect).join(" + ")})"
    else
      "#{@name}:#{@weight}"
    end
  end

  def children?
    @children.size > 0
  end
end

nodes = {}

ARGF.readlines.each do |line|
  name, weight, _, children = line.match(/(\w+)\s+\((\d+)\)( -> (.*))?/).captures

  nodes[name] ||= Node.new(name)
  nodes[name].weight= weight

  if children
    for child in children.split(', ')
      nodes[child] ||= Node.new(child)
      nodes[name].add_child(nodes[child])
    end
  end
end

root = nodes.values.find(&:root?)
node = root

puts "The root is: #{root.name}"

while true
  unbalanced_child = node.children.find { |i| !i.balanced? }
  if unbalanced_child
    node = unbalanced_child
  else
    puts "#{node.name} is unbalanced, because:"
    node.children.each { |c| puts "#{c.cumulative_weight} = #{c.inspect}" }
    break
  end
end
