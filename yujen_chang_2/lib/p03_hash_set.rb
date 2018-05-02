require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count >= num_buckets
    self[key] << key if !self.include?(key)
    @count += 1
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_num_buckets = 2 * num_buckets
    new_store = Array.new(new_num_buckets) { Array.new }

    @store.each do |bucket|
      bucket.each do |key|
        new_store[key % new_num_buckets] << key
      end
    end

    @store = new_store
  end
end
