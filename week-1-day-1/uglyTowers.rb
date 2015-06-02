
# NEED LOTS OF WORK... 

class TowersOfHanoi
  attr_reader :starting_towers, :final_towers
  
  def initialize(starting_size)
    @starting_towers = [(1..starting_size).to_a, [], []]
    @final_towers = [[], [], (1..starting_size).to_a]
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
game.move

