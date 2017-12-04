p ARGF.count { |l| !l.split.map{ |w| w.chars.sort.join }.uniq! }
