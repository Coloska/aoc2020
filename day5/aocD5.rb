def task_one
  seat_id = []
  File.readlines('./aocD5.input').each do |line|
    line.gsub!(/[RLBF]/, 'R' => 1, 'L' => '0', 'B' => 1, 'F' => 0)
    row, seat = line[0, 7].to_i(2), line[7, 10].to_i(2)
    seat_id << row * 8 + seat
  end
  seat_iD
end

def task_two
  (task_one.min..task_one.max).to_a - task_one
end

puts "Max seat:", task_one.max
puts "My seat:", task_two
