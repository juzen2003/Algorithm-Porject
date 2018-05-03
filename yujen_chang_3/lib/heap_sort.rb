require_relative "heap"

class Array
  def heap_sort!
    # heapify_up
    # set the artifical line from left to right
    i = 1
    while i < self.length
      BinaryMinHeap.heapify_up(self, i, i+1)
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
      BinaryMinHeap.heapify_down(self, 0, j)
      j -= 1
      # p "extract: #{self}"
    end

    self.reverse!
  end
end
