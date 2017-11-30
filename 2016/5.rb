require 'digest/md5'

def a
  door_id = "uqwqemis"

  password = []
  index = 0

  while password.size < 8
    hash = Digest::MD5.hexdigest("#{door_id}#{index}")

    if hash.start_with?("00000")
      password << hash[5]

      puts password.inspect
    end

    puts index if index % 10000 == 0
    index += 1
  end

  puts password.join('')
end

def b
  door_id = "uqwqemis"

  password = Array.new(8)
  index = 0

  while password.count(nil) > 0
    hash = Digest::MD5.hexdigest("#{door_id}#{index}")

    if hash.start_with?("00000")
      loc = hash[5]
      char = hash[6]

      if %w(0 1 2 3 4 5 6 7).include?(loc)
        password[loc.to_i] ||= char
      end

      puts password.inspect
    end

    # puts index if index % 10000 == 0
    index += 1
  end

  puts password.join('')
end

b
