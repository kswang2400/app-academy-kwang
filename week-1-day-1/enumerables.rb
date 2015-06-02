
class Array
  def my_each(&block)
    (0..length).each do |i|
      block.call(self[i])
    end

    self
  end

  def by_two
    self.map { |i| i * 2 }
  end

  def median
    array = self.sort
    if array.length % 2 == 1
      array[array.length / 2]
    else
      a1 = array[array.length / 2 + 0.5]
      a2 = array[array.length / 2 - 0.5]
      (a1 + a2) / 2.0
    end
  end

  def concatenate
    self.inject { |string, word| string + word }
  end
end

if __FILE__ == $PROGRAM_NAME
  return_value = [1, 2, 3].my_each do |num|
    puts num
  end.my_each do |num|
    puts num
  end
  p return_value

  p [1, 2, 3, 4, 5].median
  p [2, 3, 4, 5].median
  p [2, 56, 77, 2, 1].median
  p [3, 312, 234, 123].median

  p ["Yay ", "for ", "strings!"].concatenate
end