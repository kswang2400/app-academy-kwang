
def rps(move)
  cm = computer_move


  p "#{cm}, #{result(move,cm)}"
end

def user_move
  p "Put in your move, rock paper or scissor"
  gets.chomp
end
def computer_move
  %w(rock paper scissor)[rand(3)]
end

def result(move1, move2)
  if move1 == move2
    return "draw"
  elsif move1 = "rock" && move2 == "paper"
    return "lose"
  elsif move1 = "rock" && move2 == "scissor"
    return "win"
  elsif move1 = "paper" && move2 == "rock"
    return "win"
  elsif move1 = "paper" && move2 == "scissor"
    return "lose"
  elsif move1 = "scissor" && move2 == "paper"
    return "win"
  elsif move1 = "scissor" && move2 == "rock"
    return "lose"
  end
  p "wrong items entered"
end

rps(user_move)
