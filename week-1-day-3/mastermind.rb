
class Code
  attr_accessor :secret_code

  def initialize
    create_code
  end

  def create_code
    @secret_code = ""
    colors = %w(R G B Y O P)
    4.times do |n|
      @secret_code += colors.sample
    end
  end

  def exact_matches(other_code)
    matches = []
    4.times do |n|
      if secret_code[n] == other_code[n]
        matches << n
      end
    end

    matches
  end

  def near_matches(other_code, matches)
    temp_sc, temp_oc = code_arrays(other_code, matches)

    near_matches = []
    temp_oc.each do |element|
      near_matches << element if temp_sc.include?(element)
    end

    near_matches
  end

  def code_arrays(other_code, matches)
    temp_sc = secret_code.chars
    temp_oc = other_code.chars

    matches.each do |pos|
      temp_sc[pos] = temp_oc[pos] = nil
    end

    [temp_sc.compact, temp_oc.compact]
  end
end

class Game
  attr_reader :code, :turn_number

  def initialize
    @code = Code.new
    @turn_number = 0
    @won = false
  end

  def take_turn
    puts "\nInput your guess"
    guess = get_guess
    exact_matches = code.exact_matches(guess)

    check_win(exact_matches)
    return if @won

    near_matches = code.near_matches(guess, exact_matches)
    puts "\nYou have #{exact_matches.count} exact matches"
    puts "and #{near_matches.count} near matches."
  end

  def check_win(exact_matches)
    if exact_matches.count == 4
      @won = true
    end
  end

  def get_guess
    loop do
      input = gets.chomp.upcase
      return input if input =~ /\A[RGBYOP]{4}\Z/
      puts "Please enter a string of four colors from"
      puts "(R)ed, (G)reen, (B)lue, (Y)ellow, (O)range, or (P)urple."
    end
  end

  def play
    until over?
      @turn_number += 1
      puts "It is turn number #{turn_number}"
      take_turn
    end
  end

  def over?
    if @won
      puts "\nYou Win!"
      return true
    elsif @turn_number == 10
      puts "You Lose!"
      return true
    end
    return false
  end
end

new_game = Game.new
p new_game.code.secret_code
new_game.play
