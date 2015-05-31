require 'pry'

class EightQueens
  def initialize
    @board = Array.new(8) { Array.new(8) {"      "} }
    @queens = []
  end

  def place_queen
    (0..7).each do |x|
      (0..7).each do |y|
        @queens.each do |queen|
          place_piece(true, *queen)
        end
        next if self[x,y] == :blocked || self[x,y] == "   Q  "
        p [x,y]
        p @queens.count
        place_piece(true, x, y)
        @queens << [x, y]
        check_win
        unless place_queen
          place_piece(false, x, y)
          @queens.delete([x, y])
        end
      end
    end
    return false
  end

  def check_win
    if @queens.count == 8
      puts "Nice!"
      p @queens
      show
      puts "you might want to quit at this point"
      gets.chomp
    end
  end

  def start
    unless place_queen
      puts "Impossible"
    end
  end

  def place_piece(place, *pos)
    mark = place ? :blocked : "      "
    mark_threatened_spaces(pos, mark)
    self[*pos] = "   Q  " if place
  end

  def mark_threatened_spaces(pos, mark)
    mark_row(pos[0], mark)
    mark_column(pos[1], mark)
    mark_diagonals(pos, mark)
  end

  def mark_row(row, mark)
    (0...8).each do |i|
      self[row, i] = mark
    end
  end

  def mark_column(column, mark)
    (0...8).each do |i|
      self[i, column] = mark
    end
  end

  def mark_diagonals(pos, mark)
    mark_negative_diagonal(pos, mark)
    mark_positive_diagonal(pos, mark)
  end

  def mark_positive_diagonal(pos, mark)
    (-7..7).each do |n|
      if (0..7).include?(pos[0]+n) && (0..7).include?(pos[1]+n)
        self[pos[0]+n, pos[1]+n] = mark
      end
    end
  end

  def mark_negative_diagonal(pos, mark)
    (-7..7).each do |n|
      if (0..7).include?(pos[0]-n) && (0..7).include?(pos[1]+n)
        self[pos[0]-n, pos[1]+n] = mark
      end
    end
  end


  def [](x, y)
    @board[x][y]
  end

  def []=(x, y, value)
    @board[x][y] = value
  end

  def show
    print "\n"
    8.times do |n|
      p @board[n]
    end
  end

end

eq = EightQueens.new


eq.start
