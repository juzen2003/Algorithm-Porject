require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @store = StaticArray.new(8)
    @capacity = 8
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[get_physical_index(index)]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[get_physical_index(index)] = val
    @length += 1
  end

  # O(1)
  def pop
    raise "index out of bounds" if self.length == 0

    pop_val = @store[get_physical_index(@length-1)]
    @length -= 1
    pop_val
  end

  # O(1) ammortized
  def push(val)
    resize! if @capacity == @length

    @store[get_physical_index(@length)] = val
    @length += 1
  end

  # O(1)
  def shift
    raise "index out of bounds" if self.length == 0

    shift_val = @store[@start_idx]
    @start_idx += 1
    @length -= 1
    shift_val
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @capacity == @length

    @start_idx -= 1
    @length += 1
    @store[start_idx] = val
    # p @start_idx
    # p @store
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index >= @length
  end

  def resize!
    # we can't do @capacity *=2 because it would mess up get_physical_index(idx) later
    @new_cap = @capacity * 2

    new_store = StaticArray.new(@new_cap)
    @length.times do |idx|
      new_store[idx] = @store[get_physical_index(idx)]
    end

    @capacity = @new_cap
    @start_idx = 0
    @store = new_store
  end

  # this is to get the physical index on Static Array
  def get_physical_index(idx)
    (idx + @start_idx) % @capacity
  end
end
