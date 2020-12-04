# Part 1
def part_one
  counter = 0
  File.readlines('./aocD4.input').each do |line|
    if line.split(" ").length() == 8
      counter += 1
      next
    end
    if line.split(" ").length() >= 7
      unless line =~ /cid/
        counter += 1
      end
    end
  end
  puts counter
end

# Part 2
def validator(line)
  decision = []
  hash = {}
  line.scan(/(\w+)+:(#?\w+)/) { |key, val| hash[key.downcase.to_sym] = val }
  decision << hash[:byr].to_i.between?(1920, 2002)
  decision << hash[:iyr].to_i.between?(2010, 2020)
  decision << hash[:eyr].to_i.between?(2020, 2030)
  decision << !!(hash[:hcl] =~ /#\h{6}/)
  decision << !!(hash[:pid] =~ /\A\d{9}\z/)
  decision << (hash[:ecl].scan(/(amb|blu|brn|gry|grn|hzl|oth)/).length() == 1)
  # Height
  metric = hash[:hgt].split(/(\d{2,3})(in|cm)/).reject(&:empty?)
  if metric[1] == "cm"
    decision << metric[0].to_i.between?(150, 193)
  elsif metric[1] == "in"
    decision << metric[0].to_i.between?(59, 76)
  end
  !(decision.length < 7 or decision.include?(false))
end

def part_two
  counter = 0
  File.readlines('./aocD4.input').each do |line|
    line.sub! "\n", ""
    if line.split(" ").length() == 8
      validator(line) ? counter +=1 : false
      next
    end

    if line.split(" ").length() == 7
      unless line =~ /cid/
        validator(line) ? counter += 1 : false
      end
    end
  end
  puts counter
end

part_one
part_two
