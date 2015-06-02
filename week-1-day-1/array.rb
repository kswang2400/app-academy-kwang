
class Array
  def my_uniq
    unique = []
    self.each do |num|
      unless unique.include? num
        unique << num
      end
    end

    unique
  end

  def two_sum
    output = []
    self.each_with_index do |num, index|
      if self.include? (num * -1)
        pair = [index, self.index(num * -1)]
        if pair[0] < pair[1]
          output << pair
        end
      end
    end

    output
  end
end

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

def stock_picker(array)
  output = []
  max = 0

  (0...array.length - 1).each do |i|
    (i + 1...array.length).each do |j|
      profit = array[j] - array[i]
      if profit > max
        max = profit
        output = [i, j]
      end
    end
  end

  output
end


