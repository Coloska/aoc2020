def part_one
  input = []
  File.readlines('./aocD9.input').each do |line|
    input << line.gsub!("\n", "").to_i
  end
  block_length = 25
  result = 0
  input.each_with_index do |number, index|
    next if index < block_length
    buffer = (index - block_length..index - 1).to_a
    numbers_inspection = input.values_at(buffer.min..buffer.max)
    has_sum = numbers_inspection.permutation(2).to_a.map!{|pair| pair[0] + pair[1] == number}.include? true
    result = index unless has_sum
    # p index, number unless has_sum
  end
  result
end

def part_two
  input = []
  File.readlines('./aocD9.input').each do |line|
    input << line.gsub!("\n", "").to_i
  end
  i_of_number_to_aim_for = part_one
  number_to_aim_for = input[i_of_number_to_aim_for]
  input.each_with_index do |number, index|
    buffer = (index..i_of_number_to_aim_for).to_a
    inspect_these = input.values_at(buffer.min..buffer.max) unless buffer.length < 2
    if inspect_these
      sum = 0
      inspect_these.map do |value|
        sum = sum + value
        if number_to_aim_for == sum
          result_array = input.values_at(index..input.find_index(value)).to_a
          p result_array.min + result_array.max
        end
        break if number_to_aim_for <= sum
      end
      break if number_to_aim_for == sum
    end
  end
end

part_two
