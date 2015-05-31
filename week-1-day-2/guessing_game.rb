
class NumberGuess
  attr_reader :random_number
  attr_accessor :user_guess, :guess_count

  def initialize
    @random_number = rand(1..100)
    @guess_count = 0
    prompt
  end

  def prompt
    p "Guess a number between 1 and 100: "
    user_guess = Integer(gets) rescue nil

    if legal?(user_guess)
      @guess_count += 1
      if win?(user_guess)
        return
      else
        check_number(user_guess)
        prompt
      end
    end
  end

  def check_number(guess)
    (guess > random_number) ? (p "too high") : (p "too low")
  end

  def win?(guess)
    if guess == random_number
      p "you win!"
      return true
    end
    false
  end

  def legal?(user_guess)
    if user_guess.nil?
      p "not an integer"
      return false
    elsif !(1..100).to_a.include? user_guess
      p "not between 1 and 100"
      return false
    else
      return true
    end
  end
end


new_game = NumberGuess.new
