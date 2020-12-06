def day_five
  seat_id = []
  File.readlines('./aocD5.input').each do |line|
    line.gsub!(/[RLBF]/, 'R' => 1, 'L' => '0', 'B' => 1, 'F' => 0)
    seat_id << line.to_i(2)
  end
  puts "Max seat:", seat_id.max
  #task_two
  puts "My seat:", (seat_id.min..seat_id.max).to_a - seat_id
end

day_five
