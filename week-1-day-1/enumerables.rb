

def by_two(array)
  array.map { |i| i * 2 }
end

class Array
  def my_each(&block)
    count = 0

    while count < length
      block.call(self[count])
      count += 1
    end

    self
  end
end
#
# return_value = [1, 2, 3].my_each do |num|
#   puts num
# end.my_each do |num|
#   puts num
# end
# p return_value

def median(array)
  array = array.sort
  if array.length % 2 == 1
    array[array.length / 2]
  else
    a1 = array[array.length / 2 + 0.5]
    a2 = array[array.length / 2 - 0.5]
    (a1 + a2) / 2.0
  end
end
#
# p median([1, 2, 3, 4, 5])
# p median([2, 3, 4, 5])
# p median([2, 56, 77, 2, 1])
# p median([3, 312, 234, 123])

def concatenate(array)
  str = array.inject("") do |string, word|
    string + word
  end
end

p concatenate(["Yay ", "for ", "strings!"])
