class Board
  attr_accessor :board
  attr_reader :array_empty

  def initialize
    @board = Array.new(3) { Array.new(3) }
    @array_empty = []
    (0..2).each do |i|
      (0..2).each do |j|
        @array_empty << [i, j]
      end
    end
  end

  def won?
    if board.include?([0, 0, 0]) || board.include?([1, 1, 1])
      true
    elsif board.transpose.include?([0, 0, 0]) ||
          board.transpose.include?([1, 1, 1])
      true
    elsif board[0][0] == board[1][1] && board[0][0] == board[2][2]  &&
          !board[0][0].nil?
      true
    elsif board[0][2] == board[1][1] && board[0][2] == board[2][0] &&
          !board[0][2].nil?
      true
    else
      false
    end
  end

  def winner
    p "congrats, you win!"
  end

  def empty?(pos)
    if board[pos[0]][pos[1]].nil?
      return true
    end
    p "position not empty"
    false
  end

  def in_bounds?(pos)
    if (0..2).include?(pos[0]) && (0..2).include?(pos[1])
      return true
    end
    p "out of bounds"
    false
  end

  def place_mark(pos, mark)
    board[pos[0]][pos[1]] = mark
  end
end

class Game
  attr_accessor :board, :player1, :player2

  def initialize (player1, player2)
    @board = Board.new
    @player1 = player1
    @player2 = player2
    player1.mark = 1
    player2.mark = 0
  end

  def play
    p board.won?
    p board.array_empty
    until board.won?
      puts "player1's turn"
      play_turn(player1)
      p board.array_empty
      unless board.won?
        puts "player2's turn"
        play_turn(player2)
        p board.array_empty
      end
    end

    board.winner
  end

  def play_turn(player)
    position = player.move
    until board.in_bounds?(position) && board.empty?(position)
      position = player.move
    end
    board.place_mark(position, player.mark)
    board.array_empty.delete(position)
    show_board
  end

  def show_board
    p board.board[0]
    p board.board[1]
    p board.board[2]
  end
end

class HumanPlayer
  attr_accessor :mark

  def move
    print "Select row: "
    r = Integer(gets)
    print "Select column: "
    c = Integer(gets)

    [r, c]
  end
end

# haven't finished AI
class ComputerPlayer < HumanPlayer
  def initialize
  end

  def move

  end

end

# new_board = Board.new
# p new_board.board
# new_board.board = [[0, 0, 0], [nil, nil, 1], [nil, nil, 0]]
# p new_board.won?
# new_board.board = [[0, nil, nil], [0, nil, 1], [0, 1, nil]]
# p new_board.won?
# new_board.board = [[0, nil, nil], [nil, 0, 1], [nil, 1, 0]]
# p new_board.won?
# new_board.board = [[nil, nil, 1], [0, 1, nil], [1, 0, 1]]
# p new_board.won?

charlie = HumanPlayer.new
kevin = HumanPlayer.new
new_game = Game.new(charlie, kevin)
p new_game.board
new_game.play
