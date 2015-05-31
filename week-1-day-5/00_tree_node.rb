
class PolyTreeNode
  attr_accessor :children
  attr_reader :value, :parent

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent)
    if parent.nil?
      @parent.children.delete(self)
      @parent = nil
    else
      if parent == @parent
        return @parent
      else
        @parent.children.delete(self) if !@parent.nil?
        @parent = parent
        @parent.children << self
      end
    end
  end

  def add_child(child)
    child.parent = self
  end

  def remove_child(child)
    child.parent = nil
  end

  def dfs(target)
    return self if self.value == target

    @children.each do |child|
      result = child.dfs(target)
      return result if result
    end

    nil
  end

  def bfs(target)
    queue = [self]

    while !queue.empty?
      queue.each do |person|
        current = queue.shift

        return current if current.value == target

        current.children.each do |child|
          queue << child
        end
      end
    end

    nil
  end

  def trace_path_back
    current = self
    output = [current.value]

    while current.parent
      output.unshift(current.parent.value)
      current = current.parent
    end

    output
  end
end
