
require 'deck'
require 'rspec'

describe Deck do

  describe "#initialize" do
    cards = [
              Card.new(:Four, :Hearts),
              Card.new(:Ace, :Diamonds),
              Card.new(:Ten, :Spades)
              ]

    it "should create a default 52 card deck" do
      deck = Deck.new
      expect(deck.cards.count).to eq(52)
    end

    it "should create a specialized deck" do
      deck = Deck.new(cards)
      expect(deck.cards.count).to eq(3)
    end
  end


end
