
require_relative 'hand_ranks'

class Hand
  include HandRanks
  attr_accessor :cards

  RANKS = [
    "high card",
    "pair",
    "two pair",
    "set",
    "straight",
    "flush",
    "boat",
    "quads",
    "straight flush",
    "royal flush"
  ]

  METHODS = [:royal?, :straight_flush?, :quads?, :boat?, :flush?, :straight?, :set?, :two_pair?, :one_pair?, :high_card?]

  def initialize
    @cards = []
  end

  def receive_card(card)
    @cards << card
  end

  def create_values
    values = []
    @cards.each { |card| values << card.value }
    values
  end

  def evaluate_hand
    values = create_values
    high_card = values.sort!.last
    index = 0

    METHODS.each.with_index do |m, idx|
      if send(m)
        index = idx
        if idx == 3
          values.each do |v|
            high_card = v if values.count(v) == 3
          end
        end
        break
      end
    end

    hand = 9 - index
    [hand, high_card]
  end

end
