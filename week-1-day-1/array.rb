# w1d1

class Array
  # removing duplicates

  def my_uniq
    unique = []
    self.each do |num|
      unless unique.include? num
        unique << num
      end
    end

    unique
  end

  # two_sum

  def two_sum
    output = []
    self.each_with_index do |num, index|
      if self.include? (num * -1)
        pair = [index, self.index(num * -1)]
        if pair[0] < pair[1]
          output << pairs
        end
      end
    end

    output
  end
end

p [1,2,1,3,3].my_uniq
p [-1, 0, 2, -2, 1].two_sum

def my_transpose(matrix)
  num_columns = matrix[0].length
  transposed_matrix = Array.new(num_columns) { Array.new }

  matrix.each do |row|
    (0...num_columns).each do |position|
      transposed_matrix[position] << row[position]
    end
  end

  transposed_matrix
end

p my_transpose([
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ])


def stock_picker(array)
  output = []
  max = 0
  # (0...array.length - 1).each do |i|
    # (i + 1...array.length).each do |j|
  array.each_with_index do |first_price, index1|
    array.each_with_index do |second_price, index2|
      profit = second_price - first_price
      if profit > max && index1 < index2
        max = profit
        output = [index1, index2]
      end
    end
  end

  output
end

tester = [100, 50, -16, 129, -9, 100, -1000]
p stock_picker(tester)

class TowersOfHanoi

  def initialize(starting_size)
    starting_towers = [(1..starting_size).to_a, [], []]
    final_towers = [[], [], (1..starting_size).to_a]
  end

  def run
    print "Starting size: "

    until starting_towers == final_towers # Make an is_won? method for this
      p "Towers = #{starting_towers}"
      move(starting_towers)
    end
    p "Towers = #{starting_towers}"
    p "YAY"
  end

  def move(starting_towers)
    # Break out to get_move
    print "Move from: "
    from = gets.chomp.to_i

    print "Move to: "
    to = gets.chomp.to_i

    # make is_valid?(from, to) method
    if (0..2).include?(from) && (0..2).include?(to)
      if starting_towers[from].empty?
        print "Empty tower, try again\n"
        move(starting_towers)
      end

      disk = starting_towers[from].shift
      starting_towers[to].unshift(disk)

      unless starting_towers[to].count == 1
        if starting_towers[to][0] > starting_towers[to][1]
          print "Illegal move, try again\n"
          starting_towers[to].shift
          starting_towers[from].unshift(disk)
          move(starting_towers)
        end
      end

    else
      print "Illegal towers, try again\n"
      move(starting_towers)
    end
    starting_towers
  end
end

game = TowersOfHanoi.new(gets.chomp.to_i)
game.run
