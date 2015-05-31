
require 'rspec'
require 'player'
require 'card'
require 'hand'

describe Player do
  subject(:player) { Player.new("Bill", 0.1) }

  describe "#initialize" do

    it "should initialize player with name and stack" do
      expect(player.name).to eq("Bill")
      expect(player.stack).to eq(0.1)
    end
  end

  context "Midgame" do
    subject(:player) { Player.new("Bill", 100) }
    before(:each) {
    player.hand.receive_card(Card.new(:Ace, :Clubs))
    player.hand.receive_card(Card.new(:King, :Clubs))
    player.hand.receive_card(Card.new(:Queen, :Clubs))
    player.hand.receive_card(Card.new(:Jack, :Clubs))
    player.hand.receive_card(Card.new(:Ten, :Clubs))
    player.bet = 40
    player.called = 30
    player.playing = true }

    describe "#discard" do
      it "should discard cards" do
        player.discard([0,1])
        expect(player.hand.cards.count).to eq(3)
      end
    end

    describe "#fold" do
      it "should stop playing" do
        player.fold
        expect(player.playing).to be false
      end
    end

    describe "#call" do
      it "should changed called amount" do
        player.call
        expect(player.called).to eq(40)
      end
    end

    describe "#bet_raise" do
      it "should update bet_raise and called" do
        player.bet_raise(20)
        expect(player.called).to eq(60)
        expect(player.bet).to eq(60)
      end
    end

    describe "#all_in" do
      it "should go all in" do
        player.all_in
        expect(player.call).to eq(100)
        expect(player.bet).to eq(100)
      end
    end

  end
end

































# ...
