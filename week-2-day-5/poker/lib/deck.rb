require_relative 'card'

class Deck < Card
  attr_reader :cards

  def self.build_deck
    all_cards = []

    SUITS.each do |suit, sym|
      VALUES.each do |name, value|
        all_cards << Card.new(name, suit)
      end
    end

    all_cards
  end

  def initialize(cards = Deck.build_deck)
    @cards = cards
  end
end
