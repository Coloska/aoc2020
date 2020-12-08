def input
  input = []
  File.readlines('./aocD8.input').each do |line|
    input << line.gsub!("\n", "").split(" ")
  end
  input
end

def next_index(instruction, index, acc)
  acc += instruction[1].to_i if instruction[0] == "acc"
  if instruction == ["jmp", "+1"] || instruction[0] == "nop" || instruction[0] == "acc" || instruction == ["jmp", "+0"]
    [index+=1, acc]
  else
    [index += instruction[1].to_i, acc]
  end
end

def switch_probe(input, instruction_index, instruction_record, acc)
  inner_i_record = instruction_record.clone
  input[instruction_index][0] == "nop" ? input[instruction_index][0] = "jmp" : input[instruction_index][0] = "nop"
  result = next_index(input[instruction_index], instruction_index, acc)
  instruction_index, acc = result[0], result[1]
  inner_i_record << instruction_index
  until 1 != 1
    break [true, acc] if instruction_index == input.length
    break false if instruction_index > input.length-1
    result = next_index(input[instruction_index], instruction_index, acc)
    instruction_index, acc = result[0], result[1]
    break false if inner_i_record.include? instruction_index
    inner_i_record << instruction_index
  end
end

def part_one
  acc = 0
  instruction_index = 0
  instruction_record = []
  until 1 != 1
    break if instruction_record.include? instruction_index
    instruction_record << instruction_index
    if input[instruction_index][0] == "nop" || input[instruction_index][0] == "jmp"
      finite = switch_probe(input, instruction_index, instruction_record, acc)
      p finite[1] if finite     #second part solution
      break if finite
    end
    result = next_index(input[instruction_index], instruction_index, acc)
    instruction_index, acc = result[0], result[1]
  end
  # p acc     # first part solution
end

part_one
