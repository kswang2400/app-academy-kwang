
def num_to_s(num, base)
  conversion = {
    10 => "A",
    11 => "B",
    12 => "C",
    13 => "D",
    14 => "E",
    15 => "F"
  }

  output = ""

  while num != 0
    remainder = num % base
    if remainder < 10
      output = remainder.to_s + output
    else
      output = conversion[remainder] + output
    end
    num = num / base
  end

  output
end

p num_to_s(5, 2)
p num_to_s(234, 2)
p num_to_s(234, 16)

def caesar(string, shift)
  output = ""
  string.split('').each do |x|
    num = x.ord - 97
    num = ((num + shift) % 26) + 97
    output += num.chr
  end

  output
  # from = ("a".."z").to_a.join
  # to = ("a".."z").to_a.rotate(shift).join
  #
  # string.tr(from, to)
end

p caesar("hello", 3)
p caesar("zany", 2)
