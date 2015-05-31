
class Towers
  attr_accessor :board

  def initialize
    @board = []
  end

  def set_board
    @board = [ [3, 2, 1], [], [] ]
  end

  def render
    @board
  end

  def cheat
    @board = [ [], [], [3, 2, 1] ]
  end

  def move(from, to)
    from = @board[from.to_i]
    to = @board[to.to_i]

    unless from.empty?
      if to.empty? || from.last < to.last
        to << from.pop
      else
        raise "bigger cant go on top of smaller"
      end
    else
      raise "empty pile"
    end
  end

  def won?
    return true if  @board = [ [], [3, 2, 1], [] ] ||
                    @board = [ [], [], [3, 2, 1] ]
  end


end
