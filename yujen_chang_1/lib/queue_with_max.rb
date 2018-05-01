# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    @store = RingBuffer.new()
    @store_max = RingBuffer.new()
  end

  def enqueue(val)
    @store.push(val)
    check_max(val)

  end

  def dequeue
    shift_val = @store.shift()
    if @store_max[0] == shift_val
      @store_max.shift()
      (0...length).each do |idx|
        check_max(@store[idx])
      end
    end
    # p @store_max
    # p @store
    # p self.max
    # check_max()
    shift_val
  end

  def max
    @store_max[0] if @store_max.length > 0
  end

  def length
    @store.length
  end

  protected

  def check_max(val)
    # if @store_max.length == 0
    #   @store_max.push(val)
    # elsif @store_max[0] < val
    #   @store_max.unshift(val)
    # elsif @store_max[0] >= val
    #   current_max = @store_max[0]
    #   @store_max.push(current_max)
    # end

    if @store_max.length == 0 || @store_max[0] < val
      @store_max.push(val)
    end
    @store_max.shift() if @store_max[0] < val

    @store_max[0]
  end

end
