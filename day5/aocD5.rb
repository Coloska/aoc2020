def day_five
  input, seat_id = "./aocD5.input", []
  File.readlines(input).each {|line| seat_id << line.gsub!(/[RLBF]/, 'R' => 1, 'L' => '0', 'B' => 1, 'F' => 0).to_i(2)}
  p "Max seat:", seat_id.max , "My seat:", (seat_id.min..seat_id.max).to_a - seat_id
end

day_five
