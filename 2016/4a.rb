require './room'
rooms = ARGF.read.split("\n").map {|i| Room.new(i) }

real_rooms = rooms.select {|room| room.real? }

four_a_answer = real_rooms.map(&:sector_id).reduce(&:+)
puts four_a_answer

real_rooms.each {|room| puts "#{room.sector_id} -- #{room.decrypt}" }
