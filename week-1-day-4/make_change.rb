
## NOT OPTIMIZED; BRUTE FORCE

def make_change(amount, coins)
  return [] if amount <= 0 || coins.empty?
  return [amount] if coins.include? amount

  solutions = []

  coins.each do |value|
    amount_remaining = amount - value
    if amount_remaining > 0
      solutions << [value] + make_change(amount_remaining, coins)
    end
  end

  solutions.min_by(&:length)
end

## MAY NOT BE BEST SOLUTION, GOOD HEURISTIC

def smarter_make_change(amount, coins)
  solutions = []

  (coins.length).times do |i|
    solutions << dumb_make_change(amount, coins[i..-1], type: :naive)
    solutions << dumb_make_change(amount, coins[i..-1], type: :single)
    # solutions << dumb_make_change(amount, coins[i..-1], type: :comprehensive)
  end

  p solutions.size
  p solutions

  solutions.reject! { |arr| arr.empty? || arr.reduce(:+) != amount }
  solutions.min_by(&:length)
end

def dumb_make_change(amount, coins, options = {})
  coins.sort!.reverse!
  return [] if amount == 0 || coins.empty?
  return [amount] if coins.include? amount

  if options[:type] == :naive
    num_coin = amount / coins.first
    amount = amount % coins.first

    ([coins.first] * num_coin) + dumb_make_change(amount, coins[1..-1], type: :naive)

  elsif options[:type] == :single
    amount = amount - coins.first if amount > coins.first

    return [coins.first] * (amount / coins.first) if coins.length == 1

    [coins.first] + dumb_make_change(amount, coins[1..-1], type: :single)

  # elsif options[:type] == :comprehensive
  #   biggest_coin_num = amount / coins.first
  #   return dumb_make_change(  amount,
                                # coins[1..-1],
                                # type: :comprehensive) if biggest_coin_num == 0
  #
  #   solutions_partial = []
  #   biggest_coin_num.times do |num|
  #     amount = amount - (num * coins.first)
  #     solutions_partial << ([coins.first] * num) + dumb_make_change(amount,
  #                                       coins[0..-1],
  #                                       type: :comprehensive )
  #   end
  #
  #   solutions_partial
  end
end
