
require_relative 'array'
require_relative 'enumerables'
require_relative 'hash'
require_relative 'strings'
# require_relative 'uglyTowers'

if __FILE__ == $PROGRAM_NAME
  p [1,2,1,3,3].my_uniq
  p [-1, 0, 2, -2, 1].two_sum
  p my_transpose([
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ])
  tester = [100, 50, -16, 129, -9, 100, -1000]
  p stock_picker(tester)

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

  p num_to_s(5, 2)
  p num_to_s(234, 2)
  p num_to_s(234, 16)

  p caesar("hello", 3)
  p caesar("zany", 2)
end

