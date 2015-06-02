
# redo? 
# https://github.com/appacademy/ruby-curriculum/blob/master/w1d1/data-structures/hash.md

class MyHashSet < Hash
  attr_reader :store

  def initialize
    @store = {}
  end

  def printstore
    p @store
  end

  def insert(el)
    @store[el] = true
  end

  def include?(el)
    @store.keys.include?(el)
  end

  def delete(el)
    if @store.include?(el)
      @store.delete(el)
      true
    else
      false
    end
  end

  def to_a
    @store.to_a
  end

  def union(other_set)
    @store.merge(other_set.store)
  end

  def intersect(other_set)
    output = {}
    other_set.store.each do |key, value|
      if @store.has_key?(key)
        output[key] = value
      end
    end
    output
  end

  def minus(other_set)
    output = {}
    @store.each do |key, value|
      unless other_set.store.has_key? key
        output[key] = value
      end
    end
    output
  end
end

if __FILE__ == $PROGRAM_NAME
  h1 = MyHashSet.new
  h2 = MyHashSet.new

  el = "example"
  le = "empty"
  h1.insert(el)
  h1.insert(le)
  h1.insert('hello')
  h1.insert('bye')
  h2.insert(el)
  h2.insert('minus')

  p ""
  h1.printstore
  h2.printstore

  h1.include?(el)
  h1.delete(el)
  h1.printstore

  p ""
  h1.printstore
  h2.printstore

  p h1.to_a

  p h1.union(h2)
  p h1.intersect(h2)

  h1.printstore
  h2.printstore

  p h1.minus(h2)
end

