
class Array
  def my_each(&block)
    0.upto(length - 1) do |i|
      block.call self[i]
    end
  end

  def my_map(&block)
    mapped = []
    my_each do |el|
      mapped << block.call(el)
    end
  end

  def my_select(&block)
    selected = []
    my_each do |el|
      selected << el if block.call(el)
    end
    
    selected
  end

  def my_inject(original, &block)
    my_each do |el|
      original = block.call(original, el)
    end

    original
  end

  def my_sort(&block)
    return self if length <= 1

    left, right, pivot = [], [], first

    each_with_index do |num, i|
      next if i == 0

      if block.call(num, pivot) <= 0
        left << num
      elsif block.call(num, pivot) == 1
        right << num
      end
    end

    left.my_sort(&block) + [pivot] + right.my_sort(&block)
  end
end

def eval_block(*args, &block)
  block_given? ? block.call(*args) : (puts "no block given")
end
