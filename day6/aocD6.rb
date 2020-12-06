def part_one
  group, group_counter, count = [], 0, 0
  File.readlines('./aocD6.input').each do |line|
    if line == "\n"
      group_counter += 1
      count = count + group[group_counter-1].split("").uniq.length
      next
    end
    group[group_counter] = "" if group[group_counter].nil?
    group[group_counter] = group[group_counter] + line.gsub("\n", "")
  end
  p count
end

def part_two
  group, group_counter, group_size = [], 0, 0
  result = 0
  File.readlines('./aocD6.input').each do |line|
    if line == "\n"
      occurrences = Hash.new(0)
      group[group_counter].split("").each {|v| occurrences[v] +=1}
      result = result + occurrences.map {|k, v| k if v == group_size}.compact.length #filter_map from 2.7
      group_size = 0
      group_counter += 1
      next
    end
    group_size += 1
    group[group_counter] = "" if group[group_counter].nil?
    group[group_counter] = group[group_counter] + line.gsub("\n", "")
  end
  p result
end
