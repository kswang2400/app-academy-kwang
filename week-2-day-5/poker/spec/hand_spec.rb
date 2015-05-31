
require 'rspec'
require 'hand'
require 'card'

describe Hand do
  subject(:hand) { Hand.new }

  describe "#initialize" do
    it "should be empty when initialized" do
      expect(hand.cards.count).to eq(0)
    end
  end

  describe "#receive_cards" do
    let(:card) { Card.new(:Ace, :Hearts) }
    it "should take cards" do
      hand.receive_card(card)
      expect(hand.cards.count).to eq(1)
    end
  end

  describe "#royal" do
    it "should find a royal" do
      hand.receive_card(Card.new(:Ace, :Clubs))
      hand.receive_card(Card.new(:King, :Clubs))
      hand.receive_card(Card.new(:Queen, :Clubs))
      hand.receive_card(Card.new(:Jack, :Clubs))
      hand.receive_card(Card.new(:Ten, :Clubs))
      expect(hand.royal?).to be true
    end
  end

  describe "#straight_flush" do
    it "should find a straight flush" do
      hand.receive_card(Card.new(:Eight, :Clubs))
      hand.receive_card(Card.new(:Seven, :Clubs))
      hand.receive_card(Card.new(:Six, :Clubs))
      hand.receive_card(Card.new(:Five, :Clubs))
      hand.receive_card(Card.new(:Four, :Clubs))
      expect(hand.straight_flush?).to be true
    end
  end

  describe "#quads?" do
    it "should find quads" do
      hand.receive_card(Card.new(:Ace, :Clubs))
      hand.receive_card(Card.new(:Ace, :Hearts))
      hand.receive_card(Card.new(:Ace, :Diamonds))
      hand.receive_card(Card.new(:Ace, :Spades))
      hand.receive_card(Card.new(:King, :Diamonds))
      expect(hand.quads?).to be true
    end

    it "should not find no quads" do
      hand.receive_card(Card.new(:Ace, :Clubs))
      hand.receive_card(Card.new(:Ace, :Hearts))
      hand.receive_card(Card.new(:Ace, :Diamonds))
      hand.receive_card(Card.new(:Ten, :Spades))
      hand.receive_card(Card.new(:King, :Diamonds))
      expect(hand.quads?).to be false
    end
  end

  describe "#boat?" do
    it "should find a boat" do
      hand.receive_card(Card.new(:Ace, :Clubs))
      hand.receive_card(Card.new(:Ace, :Hearts))
      hand.receive_card(Card.new(:Ace, :Diamonds))
      hand.receive_card(Card.new(:King, :Spades))
      hand.receive_card(Card.new(:King, :Diamonds))
      expect(hand.boat?).to be true
    end

    it "should find quads too (RUN QUADS FIRST)" do
      hand.receive_card(Card.new(:Ace, :Clubs))
      hand.receive_card(Card.new(:Ace, :Hearts))
      hand.receive_card(Card.new(:Ace, :Diamonds))
      hand.receive_card(Card.new(:Ace, :Spades))
      hand.receive_card(Card.new(:King, :Diamonds))
      expect(hand.boat?).to be true
    end
  end

  describe "#flush?" do
    it "should return true for flush" do
      hand.receive_card(Card.new(:Ace, :Diamonds))
      hand.receive_card(Card.new(:Ten, :Diamonds))
      hand.receive_card(Card.new(:Jack, :Diamonds))
      hand.receive_card(Card.new(:Queen, :Diamonds))
      hand.receive_card(Card.new(:Nine, :Diamonds))
      expect(hand.flush?).to be true
    end
  end

  describe "#straight?" do
    it "should return true for straight" do
      hand.receive_card(Card.new(:Nine, :Clubs))
      hand.receive_card(Card.new(:Ten, :Diamonds))
      hand.receive_card(Card.new(:Jack, :Diamonds))
      hand.receive_card(Card.new(:Queen, :Diamonds))
      hand.receive_card(Card.new(:King, :Diamonds))
      expect(hand.straight?).to be true
    end

    it "should let ace wrap around" do
      hand.receive_card(Card.new(:Ace, :Clubs))
      hand.receive_card(Card.new(:Ten, :Diamonds))
      hand.receive_card(Card.new(:Jack, :Diamonds))
      hand.receive_card(Card.new(:Queen, :Diamonds))
      hand.receive_card(Card.new(:King, :Diamonds))
      expect(hand.straight?).to be true
    end

    it "should work correctly" do
      hand.receive_card(Card.new(:Ace, :Clubs))
      hand.receive_card(Card.new(:Nine, :Diamonds))
      hand.receive_card(Card.new(:Jack, :Diamonds))
      hand.receive_card(Card.new(:Queen, :Diamonds))
      hand.receive_card(Card.new(:King, :Diamonds))
      expect(hand.straight?).to be false
    end
  end

  describe "#set?" do
    it "should find a set" do
      hand.receive_card(Card.new(:Nine, :Clubs))
      hand.receive_card(Card.new(:Nine, :Diamonds))
      hand.receive_card(Card.new(:Nine, :Spades))
      hand.receive_card(Card.new(:Queen, :Diamonds))
      hand.receive_card(Card.new(:King, :Diamonds))
      expect(hand.set?).to be true
    end
  end

  describe "#two_pair?" do
    it "should find two pairs" do
      hand.receive_card(Card.new(:Nine, :Clubs))
      hand.receive_card(Card.new(:Nine, :Diamonds))
      hand.receive_card(Card.new(:Deuce, :Spades))
      hand.receive_card(Card.new(:Deuce, :Diamonds))
      hand.receive_card(Card.new(:King, :Diamonds))
      expect(hand.two_pair?).to be true
    end

    it "should find a set (RUN SET FIRST)" do
      hand.receive_card(Card.new(:Nine, :Clubs))
      hand.receive_card(Card.new(:Deuce, :Hearts))
      hand.receive_card(Card.new(:Deuce, :Spades))
      hand.receive_card(Card.new(:Deuce, :Diamonds))
      hand.receive_card(Card.new(:King, :Diamonds))
      expect(hand.two_pair?).to be true
    end
  end

  describe "#one_pair?" do
    it "should find a pair" do
      hand.receive_card(Card.new(:Nine, :Clubs))
      hand.receive_card(Card.new(:Nine, :Diamonds))
      hand.receive_card(Card.new(:Eight, :Spades))
      hand.receive_card(Card.new(:Queen, :Diamonds))
      hand.receive_card(Card.new(:King, :Diamonds))
      expect(hand.one_pair?).to be true
    end
  end

  describe "#high_card?" do
    it "should find no better hand" do
      hand.receive_card(Card.new(:Nine, :Clubs))
      hand.receive_card(Card.new(:Deuce, :Diamonds))
      hand.receive_card(Card.new(:Eight, :Spades))
      hand.receive_card(Card.new(:Queen, :Diamonds))
      hand.receive_card(Card.new(:Trey, :Diamonds))
      expect(hand.high_card?).to be true
    end
  end

  describe "#high_card_value" do
    it "should high card value" do
      hand.receive_card(Card.new(:Nine, :Clubs))
      hand.receive_card(Card.new(:Deuce, :Diamonds))
      hand.receive_card(Card.new(:Eight, :Spades))
      hand.receive_card(Card.new(:Queen, :Diamonds))
      hand.receive_card(Card.new(:Trey, :Diamonds))
      expect(hand.high_card_value).to eq(12)
    end
  end

  describe "#evaluate_hand" do
    it "should return score of hand" do
      hand.receive_card(Card.new(:Nine, :Clubs))
      hand.receive_card(Card.new(:Ten, :Diamonds))
      hand.receive_card(Card.new(:Jack, :Diamonds))
      hand.receive_card(Card.new(:Queen, :Diamonds))
      hand.receive_card(Card.new(:King, :Diamonds))
      expect(hand.evaluate_hand).to eq([4, 13])
    end

    it "should correctly rank boats" do
      hand.receive_card(Card.new(:Deuce, :Clubs))
      hand.receive_card(Card.new(:Deuce, :Hearts))
      hand.receive_card(Card.new(:Deuce, :Diamonds))
      hand.receive_card(Card.new(:King, :Spades))
      hand.receive_card(Card.new(:King, :Diamonds))
      expect(hand.evaluate_hand).to eq([6, 2])
    end
  end
end







































# ...
