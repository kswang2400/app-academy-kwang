
require 'towers'
require 'rspec'


describe Towers do
  subject(:my_tower) { Towers.new }

  describe "#set_board" do
    it "sets the board" do
      expect(my_tower.set_board).to eq([ [3, 2, 1], [], [] ])
    end
  end

  context "after board is set" do
    before(:each) { my_tower.set_board }

    describe "#render" do
      it "returns board view" do
        expect(my_tower.render).to eq([ [3, 2, 1], [], [] ])
      end
    end

    describe "#move" do
      it "moves disk if valid" do
        my_tower.move(0,1)
        expect(my_tower.board).to eq([ [3, 2], [1], [] ])
      end

      it "raises error if move invalid" do
        expect { my_tower.move(1,0) }.to raise_error "empty pile"
      end

      it "raises error if size invalid" do
        my_tower.move(0,1)
        expect { my_tower.move(0,1) }.to raise_error "bigger cant go on top of smaller"
      end
    end

    describe "#won?" do
      it "ends game when pile is on another stick" do
        my_tower.cheat
        expect(my_tower.won?).to be true
      end
    end
  end
end
