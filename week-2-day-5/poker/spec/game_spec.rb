
require 'rspec'
require 'game'
require 'deck'
require 'player'
require 'hand'

describe Game do
  let(:p1) { Player.new("a", 100) }
  let(:p2) { Player.new("b", 200) }
  let(:p3) { Player.new("c", 300) }
  let(:p4) { Player.new("d", 400) }

  subject(:game) { Game.new([p1, p2, p3, p4], Deck.new) }

  describe "#initialize" do
    it "should initialize with new deck & players" do
      expect(game.deck.cards.count).to eq(52)
      expect(game.players.count).to eq(4)
    end
  end

  describe "#deal" do
    it "should deal everyone 5 cards" do
      game.deal
      expect(p1.hand.cards.count).to eq(5)
      expect(p2.hand.cards.count).to eq(5)
      expect(p3.hand.cards.count).to eq(5)
      expect(p4.hand.cards.count).to eq(5)
    end

    it "should remove cards from deck" do
      game.deal
      expect(game.deck.cards.count).to eq(32)
    end
  end

  describe "#bet_round" do
    it "should go through everyone one" do
      expect(game.players.none? { |player| player.acted }).to be true
      game.bet_round
      expect(game.players.all? { |player| player.acted }).to be true
    end
  end

end
