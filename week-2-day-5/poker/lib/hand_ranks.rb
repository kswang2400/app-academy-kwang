
module HandRanks

  def royal?
    straight_flush? && create_values.sort == [10, 11, 12, 13, 14]
  end

  def straight_flush?
    flush? && straight?
  end

  def quads?
    values = create_values
    values.each { |value| return true if values.count(value) == 4 }
    false
  end

  def boat? # Run quads first
    create_values.uniq.count == 2
  end

  def flush?
    @cards.all? { |card| card.suit == cards.first.suit }
  end

  def straight?
    values = create_values.sort!
    values.last - values.first == 4 || values == [2, 3, 4, 5, 14]
  end

  def set?
    values = create_values
    values.each { |value| return true if values.count(value) == 3 }
    false
  end

  def two_pair? # Run set first
    create_values.uniq.count == 3
  end

  def one_pair?
    create_values.uniq.count == 4
  end

  def high_card?
    create_values.uniq.count == 5
  end

  def high_card_value
    create_values.sort.last
  end
end






































# ...
