require_relative 'heap2'
require 'byebug'
class PriorityMap
  def initialize(&prc)
    @map = {}
    prc = Proc.new{ |v1, v2| @map[v1] <=> @map[v2] }
    @queue = BinaryMinHeap.new(&prc)
  end

  def [](key)
    @map[key]
  end

  def []=(key, value)
    if has_key?(key)
      update(key, value)
    else
      insert(key, value)
    end
  end

  def count
    @map.size
  end

  def empty?
    @map.empty?
  end

  def extract
    key = @queue.extract
    value = @map.delete(key)
    [key, value]
  end

  def has_key?(key)
    @map.key?(key)
  end

  protected
  attr_accessor :map, :queue

  def insert(key, value)
    @map[key] = value
    @queue.push(key)
  end

  def update(key, value)
    @map[key] = value
    @queue.reduce!(key)
  end
end
