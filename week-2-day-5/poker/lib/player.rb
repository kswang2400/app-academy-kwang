
class Player
  attr_reader :name
  attr_accessor :stack, :playing, :hand, :bet, :called, :acted

  def initialize(name, stack)
    @name = name
    @stack = stack
    @hand = Hand.new
    @called = 0   # what player has committed
    @playing = false
    @acted = false
  end

  def fold
    @playing = false
    @stack -= @called
    @hand = Hand.new
  end

  def call(amount)
    @called += amount
  end

  def check
    bet_raise(0, 0)
  end

  def bet_raise(call_amt, amount)
    call(call_amt)
    @called += amount
  end
  #
  # def all_in
  #   bet_raise(@stack - @bet)
  # end

  def discard(indices)
    indices.each { |i| @hand.cards.delete_at(i) }
  end




end
