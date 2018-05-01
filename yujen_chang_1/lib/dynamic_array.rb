require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @length = 0
    @store = StaticArray.new(8)
    @capacity = 8
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[index] = value
    @length += 1
  end

  # O(1)
  def pop
    raise "index out of bounds" if self.length == 0

    @length -= 1
    @store[@length]
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @capacity == @length

    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if self.length == 0

    shift_val = @store[0]
    (1...@length).each do |idx|
      @store[idx-1] = @store[idx]
    end

    @length -= 1
    shift_val
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @capacity == @length

    (@length-1).downto(0).each do |idx|
      @store[idx+1] = @store[idx]
    end

    @length += 1
    @store[0] = val
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index >= @length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2

    new_store = StaticArray.new(@capacity)
    @length.times do |idx|
      new_store[idx] = @store[idx]
    end

    @store = new_store
  end
end
