
require 'array'
require 'rspec'

describe Array do
  subject(:arr) { [1,2,-1,-2,5] }

  describe "#my_uniq" do
    it "takes in an Array and returns only the unique items" do
      expect(arr.my_uniq).to eq([1,2,-1,-2,5])
    end
  end

  describe "#two_sum" do
    it "returns indices that sum to 0" do
      expect(arr.two_sum).to eq([ [0, 2], [1, 3] ])
    end
  end


  describe "#my_transpose" do
    let(:matrix) {[
                  [0, 1, 2],
                  [3, 4, 5],
                  [6, 7, 8]
                  ]}

    it "returns transposed matrix" do
      expect(matrix.my_transpose).to eq([
                                          [0, 3, 6],
                                          [1, 4, 7],
                                          [2, 5, 8]
                                        ])
    end
  end

  describe "#stock_picker" do
    let(:stocks) {[1000,1,-2,3,100]}
    it "returns the most profitable indices of days" do
      expect(stocks.stock_picker).to eq([2,4])
    end
  end

end
