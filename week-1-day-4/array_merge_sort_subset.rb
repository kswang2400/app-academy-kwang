
class Array
  def merge_sort
    return self if length <= 1
    merge(self[0...length / 2].merge_sort, self[length / 2..-1].merge_sort)
  end

  def merge(piece1, piece2)
    merged = []
    loop do
      if piece1.empty?
        return merged += piece2
      elsif piece2.empty?
        return merged += piece1
      elsif piece1.first < piece2.first
        merged << piece1.shift
      else
        merged << piece2.shift
      end
    end
  end

  def subsets
    return [[]] if length == 0
    all_till_last = self[0..-2].subsets
    all_till_last + all_till_last.map{ |subs| subs.dup << self.last }
  end
end
