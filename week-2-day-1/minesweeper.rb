
class Tile
  attr_reader :position, :bombed, :numbeR, :options
  attr_accessor :flagged, :revealed

  def initialize(name, options = {})
    @name = name
    default = { :bombed => false, :number => 0 }
    @options = default.merge(options)

    @flagged = false
    @revealed = false
  end
end

class Board
  attr_reader :bomb_locations
  attr_accessor :board_view, :all_tiles

  def initialize
    @board_view = Array.new(9) { Array.new(9) { "  []  " } }
    @bomb_locations = create_new_bombs
    # @bomb_locations = [[0,0],[0,1],[0,2]]
    @all_tiles = Array.new(9) { Array.new(9)}
  end

  def show_board
    @board_view.each do |line|
      puts
      p line
      puts
    end
  end

  # returns list of bomb locations
  def create_new_bombs
    bombs = []

    until bombs.count == 10 do
      i = rand(9)
      j = rand(9)

      bombs << [i,j] unless bombs.include?([i,j])
    end

    bombs
  end

  # create all Tile objects
  def create_tiles
    (0..8).each do |x|
      (0..8).each do |y|

        tile = "[#{x}, #{y}]"
        if bomb_locations.include?([x,y])
          tile = Tile.new(tile, { :bombed => true })
        else
          number = check_neighbors([x, y])

          if number == 0
            tile = Tile.new(tile, {})
          else
            tile = Tile.new(tile, { :number => number })
          end
        end

        @board_view[x][y] = "  []  "
        @all_tiles[x][y] = tile
      end
    end
    # p @all_tiles
  end

  # returns number of adjacent bombs
  def check_neighbors(pos)
    all_directions = [
      [-1, 1],  [0, 1],  [1, 1],
      [-1, 0],           [1, 0],
      [-1, -1], [0, -1], [1, -1]
    ]
    count = 0

    all_directions.each do |change|
      neighbor = [change[0] + pos[0], change[1] + pos[1]]
      if bomb_locations.include? neighbor
        count += 1
      end
    end

    count
  end
end

class Game
  attr_reader :minefield

  def initialize
    @minefield = Board.new
    @minefield.create_tiles
    @winner = false
    @loser = false
  end

  def play
    until won? || lose?
      @minefield.show_board
      this_turn_position = get_coord
      type_of_turn = get_turn_type

      if type_of_turn == 1
        reveal(this_turn_position)
      elsif type_of_turn == 2
        flag(this_turn_position)
      end
    end

    if @winner
      @minefield.show_board
      p "Good job!"
    elsif @loser
      @minefield.show_board
      p "Nice try"
    end
  end

  def get_coord
    p "Take your turn, input coordinate e.g. 2, 4"
    this_turn_position = gets.chomp.split(", ").map! { |el| el.to_i }
  end

  def get_turn_type
    p "Reveal or Flag, (1) for reveal, (2) for flag"
    type_of_turn = Integer(gets.chomp)
  end

  def reveal(pos)
    current_tile = @minefield.all_tiles[pos[0]][pos[1]]
    user_view = @minefield.board_view[pos[0]][pos[1]]


    if current_tile.options[:bombed] == true
      @loser = true
      return
    elsif current_tile.options[:number] > 0
      # p "Adjacent bomb"
      current_tile.revealed = true
      @minefield.board_view[pos[0]][pos[1]] = "  #{current_tile.options[:number]}   "
    else
      # p "No bombs nearby"
      current_tile.revealed = true
      @minefield.board_view[pos[0]][pos[1]] = "  _   "
      unrevealed_neighbors(pos)
    end
  end

  def unrevealed_neighbors(pos)
    all_directions = [
      [-1, 1],  [0, 1],  [1, 1],
      [-1, 0],           [1, 0],
      [-1, -1], [0, -1], [1, -1]
    ]

    all_directions.each do |change|
      neighbor = [change[0] + pos[0], change[1] + pos[1]]
      next unless (0..8).include?(neighbor[0]) && (0..8).include?(neighbor[1])
      unless @minefield.all_tiles[neighbor[0]][neighbor[1]].revealed
        reveal(neighbor)
      end
    end
  end

  def flag(pos)
    @minefield.all_tiles[pos[0]][pos[1]].flagged = true
    @minefield.all_tiles[pos[0]][pos[1]].revealed = true
    @minefield.board_view[pos[0]][pos[1]] = "  F   "
  end

  def won?
    flag_count = 0
    count = 0
    (0..8).each do |x|
      (0..8).each do |y|
        tile = @minefield.all_tiles[x][y]
        count += 1 if tile.flagged && tile.options[:bombed]
        flag_count += 1 if @minefield.board_view[x][y] == "  F   "
      end
    end

    @winner = true if count == 10 && flag_count == 10
  end

  def lose?
    if @loser == true
      p "You lose :("
      return true
    end
  end
end


game = Game.new
# p game.minefield.bomb_locations

game.play
