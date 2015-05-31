
class Array
  def my_uniq
    output = []
    each { |el| output << el unless output.include?(el)}
    output
  end

  def two_sum
    output = []

    each_with_index do |n1, i|
      each_with_index do |n2, j|
        output << [i, j] if n1 + n2 == 0 && i < j
      end
    end

    output
  end

  def my_transpose
    output = [[],[],[]]

    (0..2).each do |i|
      (0..2).each do |j|
        output[i][j] = self[j][i]
      end
    end

    output
  end

  def stock_picker
    output = []
    best = 0

    (0...length-1).each do |buy|
      (1...length).each do |sell|
        profit = self[sell] - self[buy]
        if profit > best
          best = profit
          output = [buy, sell]
        end
      end
    end

    output
  end

end
