require_relative "heap"

class Array
  def heap_sort!
    prc = Proc.new {|el1, el2| el2 <=> el1}
    # heapify_up
    # set the artifical line from left to right
    i = 1
    while i < self.length
      BinaryMinHeap.heapify_up(self, i, i+1, &prc)
      i += 1
    end

    # p "heapify: #{self}"
    # extract steps:
    # swap
    # set the artifical line from right to left
    # heapyify_down
    j = self.length-1
    while j > 0
      self[j], self[0] = self[0], self[j]
      BinaryMinHeap.heapify_down(self, 0, j, &prc)
      j -= 1
      # p "extract: #{self}"
    end

    self
  end
end
