require_relative 'heap'
require_relative 'heap_sort'

def k_largest_elements(array, k)
  # push k els of array into BinaryMinHeap
  # iterate k times
  # push into heap O(logk)
  # this operation is O(klogk)
  heap = BinaryMinHeap.new
  k.times do
    heap.push(array.pop)
  end

  # push & extract rest of array (n-k)
  # push into heap O(log(n-k))
  # extract from heap O(log(n-k))
  # O((n-k)log(n-k))
  while !array.empty?
    heap.push(array.pop)
    heap.extract
  end

  # time: O(nlogn)
  heap.store

  # using heap_sort
  # O(nlogn) for heap sort
  # O(n)
  # array.heap_sort!
  # array.drop(array.length - k)

end
