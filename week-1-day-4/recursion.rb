
def range(start, final)
  return [] if final < start
  return [start] if (start - final) == 0

  [start] + range(start + 1, final)
end

def recursive_sum(arr)
  return 0 unless arr
  return arr[0] if arr.length == 1
  arr[0] + recursive_sum(arr[1..-1])
end

def iterative_sum(arr)
  count = 0
  arr.each do |el|
    count += el
  end
  
  count
end

def exp1(num, power)
  return 1 if power == 0
  num * exp(num, power - 1)
end

def exp2(num, power)
  return 1 if power == 0
  case power.odd?
  when false
    exp2(num, power / 2) * exp2(num, power / 2)
  when true
    exp2(num, power / 2) * exp2(num, power / 2) * num
  end
end

def deep_dup(arr)
  return arr unless arr.is_a?(Array)
  return [] if arr.empty?
  return arr.dup unless arr.any? { |el| el.is_a?(Array) }
  [].tap do |deep_clone|
    arr.each do |el|
      deep_clone << deep_dup(el)
    end
  end
end

def fib(n)
  return [0, 1].take(n) if n <= 2
  current_fibs = fib(n - 1)
  current_fibs << (current_fibs[-1] + current_fibs[-2])
end

def bsearch(array, target)
  return nil if array.empty?
  return nil unless target.between?(array.first, array.last)

  if array.size == 1
    return array.first == target ? 0 : nil
  end

  middle = array.length / 2

  case target<=>array[middle]
  when 1
    bsearch_temp = bsearch(array[middle..-1], target)
    bsearch_temp.nil? ? nil : middle + bsearch_temp
  when -1
    bsearch_temp = bsearch(array[0...middle], target)
    bsearch_temp.nil? ? nil : bsearch_temp
  else
    middle
  end
end
