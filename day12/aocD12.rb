def part_one
  direction = 90 #face east
  x, y = 0, 0
  File.readlines('./aocD12.input').each do |line|
    line_instruction = line.split("\n")[0].split /([FNSEWLR])(\d+)/
    instruction = line_instruction.reject { |c| c.empty? }
    instruction[1] = instruction[1].to_i

    if instruction[0] == "L" or instruction[0] == "R"
      direction = instruction[1] + direction if instruction[0] == "R"
      direction = direction - instruction[1] if instruction[0] == "L"
      direction = direction % 360
      next
    end

    if instruction[0] == "F"
      instruction[0] = "N" if direction == 0
      instruction[0] = "E" if direction == 90
      instruction[0] = "S" if direction == 180
      instruction[0] = "W" if direction == 270
    end

    x = x + instruction[1] if instruction[0] == "E"
    x = x - instruction[1] if instruction[0] == "W"
    y = y + instruction[1] if instruction[0] == "N"
    y = y - instruction[1] if instruction[0] == "S"
  end

  p x.abs + y.abs
end

def part_two
  waypoint_x, waypoint_y = 10, 1
  x, y = 0, 0
  File.readlines('./aocD12.input').each do |line|
    line_instruction = line.split("\n")[0].split /([FNSEWLR])(\d+)/
    instruction = line_instruction.reject { |c| c.empty? }
    instruction[1] = instruction[1].to_i

    waypoint_y = waypoint_y + instruction[1] if instruction[0] == "N"
    waypoint_x = waypoint_x + instruction[1] if instruction[0] == "E"
    waypoint_y = waypoint_y - instruction[1] if instruction[0] == "S"
    waypoint_x = waypoint_x - instruction[1] if instruction[0] == "W"

    if instruction[0] == "L" or instruction[0] == "R"
      if instruction == ["R", 90] or instruction == ["L", 270]
        # [x, y] => [y, -x]
        temp = waypoint_x
        waypoint_x = waypoint_y
        waypoint_y = temp * -1
      end
      if instruction == ["R", 180] or instruction == ["L", 180]
        waypoint_y = waypoint_y * -1
        waypoint_x = waypoint_x * -1
      end
      if instruction == ["R", 270] or instruction == ["L", 90]
        # [x, y] => [-y, x]
        temp = waypoint_x
        waypoint_x = waypoint_y * -1
        waypoint_y = temp
      end
    end

    if instruction[0] == "F"
      x = x + waypoint_x * instruction[1]
      y = y + waypoint_y * instruction[1]
    end

  end

  p x.abs + y.abs
end

part_one
part_two
