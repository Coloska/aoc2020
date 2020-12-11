def input_construction
  input = File.read('./aocD11.input').split("\n")
#  add . as a border on the array

  # array construction
  twoDArray = []
  input.each do |row|
    row = row.split("")
    twoDArray << row
  end
  twoDArray
end

def calculate_buffer(row_index, seat_index)
  [
      [row_index-1, seat_index-1], [row_index, seat_index-1], [row_index+1, seat_index-1],
      [row_index-1, seat_index+0], "self", [row_index+1, seat_index+0],
      [row_index-1, seat_index+1], [row_index, seat_index+1], [row_index+1, seat_index+1]
  ]
end

def buffer_part_two(y, x, y_length, x_length, input)
  # look nw
  nw_index = -1
  nw_neighbour = 0
  until y + nw_index < 0 or x + nw_index < 0
    break if input[y + nw_index][x + nw_index] == "L"
    if input[y + nw_index][x + nw_index] == "#"
      nw_neighbour += 1
      break
    end
    nw_index -= 1
  end

  # look n
  n_index = -1
  n_neighbour = 0
  until y + n_index < 0
    break if input[y + n_index][x] == "L"
    if input[y + n_index][x] == "#"
      n_neighbour += 1
      break
    end
    n_index -= 1
  end

  # look ne
  ne_index = -1
  ne_neighbour = 0
  until y + ne_index < 0 or x + ne_index > x_length
    break if input[y + ne_index][x - ne_index] == "L"
    if input[y + ne_index][x - ne_index] == "#"
      ne_neighbour += 1
      break
    end
    ne_index -= 1
  end

  # look e
  e_index = 1
  e_neighbour = 0
  until x + e_index > x_length
    break if input[y][x + e_index] == "L"
    if input[y][x + e_index] == "#"
      e_neighbour += 1
      break
    end
    e_index += 1
  end

  # look se
  se_index = 1
  se_neighbour = 0
  until y + se_index >= y_length or x + se_index > x_length
    break if input[y + se_index][x + se_index] == "L"
    if input[y + se_index][x + se_index] == "#"
      se_neighbour += 1
      break
    end
    se_index += 1
  end

  # look s
  s_index = 1
  s_neighbour = 0
  until y + s_index >= y_length
    break if input[y + s_index][x] == "L"
    if input[y + s_index][x] == "#"
      s_neighbour += 1
      break
    end
    s_index += 1
  end

  # look sw
  sw_index = 1
  sw_neighbour = 0
  until y + sw_index >= y_length or x - sw_index < 0
    break if input[y + sw_index][x - sw_index] == "L"
    if input[y + sw_index][x - sw_index] == "#"
      sw_neighbour += 1
      break
    end
    sw_index += 1
  end

  # look w
  w_index = 1
  w_neighbour = 0
  until x - w_index < 0
    break if input[y][x - w_index] == "L"
    if input[y][x - w_index] == "#"
      w_neighbour += 1
      break
    end
    w_index += 1
  end
  [nw_neighbour, n_neighbour, ne_neighbour, e_neighbour, se_neighbour, s_neighbour, sw_neighbour, w_neighbour]
end

def part_two_iteration(input)
  output = []
  input.each_with_index do |row, row_index|
    unless row.include? "L" or row.include? "#"      # skipping floor rows
      output[row_index] = row
      next
    end
    output_row = []
    row.each_with_index do |seat, seat_index|
      if seat == "."      #skipping floor
        output_row[seat_index] = "."
        next
      end
      neighbors = buffer_part_two(row_index, seat_index, input.length, input[0].length, input)
      neighbor_count = neighbors.inject(0){|sum,x| sum + x }
      if neighbor_count == 0 and seat == "L"
        output_row[seat_index] = "#"
        next
      end
      if neighbor_count >= 5 and seat == "#"
        output_row[seat_index] = "L"
        next
      end
      output_row[seat_index] = seat
    end
    output << output_row
  end
  output
end

def part_one_iteration(input)
  output = []
  input.each_with_index do |row, row_index|
    unless row.include? "L" or row.include? "#"      # skipping floor rows
      output[row_index] = row
      next
    end
    output_row = []
    row.each_with_index do |seat, seat_index|
      # p seat == input[row_index][seat_index] <= TRUE
      if seat == "."      #skipping floor
        output_row[seat_index] = "."
        next
      end
      buffer = calculate_buffer(row_index, seat_index)
      neighbor_count = 0
      unless buffer.nil?
        buffer.each do |buffer|
          seat_status = input[buffer[0]][buffer[1]] unless buffer == "self"
          neighbor_count += 1 if seat_status == "#"
        end
      end
      if neighbor_count == 0 and seat == "L"
        output_row[seat_index] = "#"
        next
      end
      if neighbor_count >= 4 and seat == "#"
        output_row[seat_index] = "L"
        next
      end
      output_row[seat_index] = seat
    end
    output << output_row
  end
  output
end

def part_one
  require 'digest'
  output = []
  output << input_construction
  result = []
  result << (Digest::SHA2.hexdigest input_construction.to_s)
  index = 0
  loop do
    round_result = part_one_iteration(output[index])
    output << round_result
    result << (Digest::SHA2.hexdigest round_result.to_s)
    index += 1
    p "Part one:", round_result.flatten.count("#") if result.uniq.length < result.length
    break if result.uniq.length < result.length
  end
end

def part_two
  require 'digest'
  output = []
  output << input_construction
  result = []
  result << (Digest::SHA2.hexdigest input_construction.to_s)
  index = 0
  loop do
    round_result = part_two_iteration(output[index])
    output << round_result
    result << (Digest::SHA2.hexdigest round_result.to_s)
    index += 1
    p "Part two:", round_result.flatten.count("#") if result.uniq.length < result.length
    break if result.uniq.length < result.length
  end
end

part_one
part_two
