
require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    evaluator != board.winner
  end

  def winning_node?(evaluator)
    evaluator == board.winner
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    next_moves = []
    mark = flip_mark(next_mover_mark)

    (0..2).each do |i|
      (0..2).each do |j|
        if board.empty?([i, j])
          next_moves << TicTacToeNode.new(board, mark, [i, j])
        end
      end
    end

    next_moves
  end

  def flip_mark(next_mover_mark)
    next_mover_mark == :x ? :o : :x
  end
end
