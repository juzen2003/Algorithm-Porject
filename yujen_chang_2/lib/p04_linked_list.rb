class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    @next.prev = @prev
    @prev.next = @next
  end
end

class LinkedList
  include Enumerable
  
  def initialize
    @head = Node.new
    @tail = Node.new
    # init as empty list
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    return nil if empty?
    @head.next
  end

  def last
    return nil if empty?
    @tail.prev
  end

  def empty?
    @head.next == @tail || @tail.prev == @head
  end

  def get(key)
    self.each do |node|
      if key == node.key
        return node.val
      end
    end
  end

  def include?(key)
    self.each do |node|
      if key == node.key
        return true
      end
    end

    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    # p new_node
    @tail.prev.next = new_node
    new_node.next = @tail
    new_node.prev = @tail.prev
    # p @tail
    @tail.prev = new_node

    new_node
  end

  def update(key, val)
    self.each do |node|
      if key == node.key
        node.val = val
      end
    end
  end

  def remove(key)
    self.each do |node|
      if key == node.key
        node.remove
      end
    end
  end

  def each(&prc)
    node = @head.next
    while node != @tail
      prc.call(node)
      node = node.next
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
