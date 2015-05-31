require 'card'
require 'rspec'

describe Card do

  describe "#initialize" do
    subject(:card) { Card.new(:Four, :Clubs) }
    it "creates a card with value" do
      expect(card.value).to eq(4)
    end

    it "creates a card with suit" do
      expect(card.suit).to eq("c")
    end
  end

end
