
class Hangman

  def initialize(player_guess, player_picks)
    @player_guess = player_guess
    @player_picks = player_picks
    prompt_secret_word
  end

  def prompt_secret_word
    @display = ["_"] * @player_picks.pick_word
    @player_picks.length = @display.length
    @player_guess.length = @display.length
  end

  def update_display(letter, result)
    if result.nil?
      @player_guess.guess_was(false)
      return
    end
    @player_guess.guess_was(true)
    result.each { |pos| @display[pos] = letter }
  end

  def won?
    return !(@display.include?('_'))
  end

  def check_win
    if won?
      print @display.join("")
      print "\n\nGood Job\n\n"
    end
  end

  def take_turn
    @player_guess.show( @display )
    @player_picks.show( @display )
    letter = @player_guess.guess_letter
    result = @player_picks.check_letter(letter)
    update_display(letter, result)
    check_win
  end

  def play
    until won?
      take_turn
    end
  end

end

class HumanPlayer
  attr_writer :length

  def pick_word
    print "\nPick a word. How long is it? \n\n"
    return Integer(gets)
  end

  def show(display)
    puts display.join(' ')
  end

  def guess_was(good)
    print good ? "\nYour guess was right\n\n" : "\nYour guess was wrong\n\n"
  end

  def guess_letter
    print "\nGuess a letter. \n\n"
    gets.chomp
  end

  def check_letter(letter)
    print "\nAre there any #{letter.upcase}'s? ( Y / N ) \n\n"
    response = gets.chomp.upcase

    return nil if response == "N"

    print "\nWhere? \n\n"
    positions = get_positions

    until check_positions?(positions)
      print "\nPlease enter valid input\n\n"
      positions = get_positions
    end

    positions
  end

  def get_positions
    positions = gets.chomp.split(/[^0-9]+/)
    to_integers(positions)
  end

  def check_positions?(array)
    array.all? { |el| (0...@length).include?(el) }
  end

  def to_integers(array)
    array.map! { |i| Integer(i) -1 }
  end
end

class ComputerPlayer

  def initialize
    @dictionary = get_dictionary
    @unguessed_letters = ('a'..'z').to_a
    @possible_list = @dictionary.dup
  end

  def show(display)
    @known_letters = display
  end

  def guess_was(good)
    remove_letter unless good
  end

  def update_possible
    new_list = @possible_list.dup
    @possible_list.each do |word|
      @known_letters.each_with_index do |l, i|
        next if l == '_'
        if word[i] != l
          new_list.delete(word)
        end
      end
    end
    @possible_list = new_list
  end

  def remove_letter
    @possible_list.select! { |word| !(word.include?(@current_letter))}
  end


  def length=(length)
    @length = length
    @possible_list.select! { |word| word.length == length }
    p @possible_list
  end

  def get_dictionary
    words = File.readlines('dictionary.txt')
    words.map(&:chomp)
  end

  def pick_word
    @word = @dictionary.sample
    p @word
    @word.length
  end

  def guess_letter
    update_possible
    p @possible_list
    @current_letter = find_most_letter
    @unguessed_letters.delete(@current_letter)

    @current_letter
  end

  def find_most_letter
    count = Hash.new(0)
    @possible_list.join("").each_char do |letter|
      count[letter] += 1
    end

    max = 0
    max_letter = ""

    count.each do |letter, num|
      if num > max && @unguessed_letters.include?(letter)
        max = num
        max_letter = letter
      end
    end

    max_letter
  end

  def check_letter(letter)
    return nil unless @word.include?(letter)
    positions = []
    @word.chars.each_with_index do |l, index|
      positions << index if l == letter
    end

    positions
  end
end

game = Hangman.new(ComputerPlayer.new, HumanPlayer.new)
game.play
