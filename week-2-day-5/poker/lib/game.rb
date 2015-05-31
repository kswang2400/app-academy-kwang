require_relative 'game'
require_relative 'deck'
require_relative 'player'
require_relative 'hand'

class Game
  attr_reader :players, :deck
  attr_accessor :bet

  def initialize(players, deck = Deck.new)
    @players = players
    @deck = deck
    @pot = 0
    @bet = 0
  end

  def action(player, bet = 0)
    puts "Check, call, bet, or fold?"

    player.bet = bet
    player_action = gets.chomp.downcase

    case player_action
    when "check"
      puts "I Check"
      player.check
    when "call"
      puts "I Call"
      player.call(@bet)
    when "bet"
      puts "I Bet"
      puts "How much"
      p amount = Integer(gets.chomp)
      player.bet_raise(@bet, amount)
      @bet += amount
    # when "all-in"
    #   puts "All-In"
    #   player.all_in
    when "fold"
      puts "I Fold"
      player.fold
    end

    p "Stack: #{player.stack}"
    p "Called: #{player.called}"
    p "Bet: #{@bet}"

  end

  def bet_round
    until @players.all? { |p| p.acted }
      under_the_gun = @players.shift
      under_the_gun.acted = true
      action(under_the_gun, bet)
      bet = under_the_gun.bet
      @players << under_the_gun
    end
  end

  def deal
    (0...5).each do |i|
      @players.each do |player|
        player.hand.receive_card(@deck.cards.pop)
      end
    end

  end

  def play_round
    @deck.shuffle!
    deal
  end

end

=begin
load 'game.rb'
g = Game.new([Player.new("a", 100), Player.new("b", 200), Player.new("c", 300), Player.new("d", 400)])
=end
