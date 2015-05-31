
require './00_tree_node.rb'

class KnightPathFinder
  attr_accessor :visited_positions
  attr_reader :start_position, :root

  def initialize(start_position)
    @start_position = start_position
    @visited_positions = [start_position]
    @root = build_move_tree
  end

  def self.valid_moves(pos)
    possible_moves = []
    (-2..2).each do |i|
      if i.abs == 2
        if valid_space?([pos[0] + i, pos[1] + 1])
          possible_moves << [pos[0] + i, pos[1] + 1]
        end
        if valid_space?([pos[0] + i, pos[1] - 1])
          possible_moves << [pos[0] + i, pos[1] - 1]
        end
      elsif i.abs == 1
        if valid_space?([pos[0] + i, pos[1] + 2])
          possible_moves << [pos[0] + i, pos[1] + 2]
        end
        if valid_space?([pos[0] + i, pos[1] - 2])
          possible_moves << [pos[0] + i, pos[1] - 2]
        end
      end
    end

    return possible_moves
  end

  def self.valid_space?(pos)
    return (0..7).include?(pos[0]) && (0..7).include?(pos[1])
  end

  def build_move_tree
    @move_tree = start_position
    root = PolyTreeNode.new(start_position)
    queue = [root]
    until queue.empty?
      current = queue.shift
      new_pos = new_move_positions(current.value)

      new_pos.each do |pos|
        position = PolyTreeNode.new(pos)
        position.parent = current
      end

      queue += current.children
    end

    root
  end

  def find_path(end_position)
    finish = root.dfs(end_position)
    finish.trace_path_back
  end

  def new_move_positions(pos)
    new_moves = self.class.valid_moves(pos)
    new_moves.select! { |move| !visited_positions.include?(move) }
    self.visited_positions += new_moves

    new_moves
  end
end

knight = KnightPathFinder.new([0,0])
p knight.find_path([7, 6])
p knight.find_path([6, 2])
