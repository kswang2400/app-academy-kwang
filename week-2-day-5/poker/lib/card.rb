
class Card
  attr_reader :value, :suit
  SUITS = {
            Clubs: "c",
            Diamonds: "d",
            Hearts: "h",
            Spades: "s"
          }

  VALUES = {
            Deuce: 2,
            Trey: 3,
            Four: 4,
            Five: 5,
            Six: 6,
            Seven: 7,
            Eight: 8,
            Nine: 9,
            Ten: 10,
            Jack: 11,
            Queen: 12,
            King: 13,
            Ace: 14
          }


  def initialize(value, suit)
    @value, @suit = VALUES[value], SUITS[suit]
  end

end
