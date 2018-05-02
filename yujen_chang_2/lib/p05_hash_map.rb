require_relative 'p02_hashing'
require_relative 'p04_linked_list'
#  eject: O(n), insert: O(n), read: O(1)
class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def [](key)
    # optional but useful; return the bucket corresponding to `key`
    bucket(key)
  end

  def []=(key, val)
    set(key, val)
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    resize! if @count >= @store.length

    if self.include?(key)
      bucket(key).update(key, val)
    else
      bucket(key).append(key, val)
      @count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    if bucket(key).remove(key)
      @count -= 1
    end
  end

  def each(&prc)
    @store.each do |linked_list|
      linked_list.each do |node|
        prc.call(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    original_store = @store
    new_num_buckets = 2 * num_buckets
    # directly assign to @store because we would use set to put all nodes in again
    @store = Array.new(new_num_buckets) { LinkedList.new }
    @count = 0

    original_store.each do |linkedlist|
      linkedlist.each do |node|
        set(node.key, node.val)
      end
    end

  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    # now each bucket is a LinkedList
    @store[key.hash % num_buckets]
  end


end
