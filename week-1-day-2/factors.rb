
def factors(num)
  output = []
  (1..num).each do |n|
    if num % n == 0
      output << n
    end
  end

  output
end

p factors(12)
p factors(100)
