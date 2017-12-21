class Layer
  attr_reader :range

  def initialize(index, range)
    @index = index
    @range = range
    @cache = {}
  end

  def position_at(time)
    time = time % (2 + (range-2)*2)
    return @cache[time] if @cache[time]

    scanner = 0
    scanner_dir = :down

    time.times do
      case scanner_dir
      when :down
        if scanner < range - 1
          scanner += 1
        else
          scanner -= 1
          scanner_dir = :up
        end
      when :up
        if scanner > 0
          scanner -= 1
        else
          scanner += 1
          scanner_dir = :down
        end
      end
    end

    @cache[time] = scanner
  end

  def caught?(time)
    position_at(time) == 0
  end
end

class UnscannedLayer
  def initialize(index)
    @index = index
  end

  def caught?(time)
    false
  end
end

class Firewall
  attr_reader :layers
  def initialize(config)
    @layers = []
    config.each do |index, range|
      @layers[index] = Layer.new(index, range)
    end
    @layers.each_with_index do |layer, index|
      @layers[index] ||= UnscannedLayer.new(index)
    end
  end

  def severity(delay = 0)
    severity = 0
    caught = []

    size.times do |idx|
      if layers[idx].caught?(idx + delay)
        caught << idx
        severity += idx * layers[idx].range
      end
    end

    # puts "Caught in layers: #{caught.inspect}"
    [severity, caught]
  end

  def size
    @layers.size
  end
end

config = eval("{" + ARGF.read.gsub(": ", " => ").gsub("\n", ",") + "}")
firewall = Firewall.new(config)

puts "13a: #{firewall.severity}"

delay = 0
severity = 0
while true
  severity, caught = firewall.severity(delay)
  # puts "Delay: #{delay}, #{severity}"
  break if caught.size == 0
  delay += 1
end

puts "13b: #{delay} -> #{severity}"