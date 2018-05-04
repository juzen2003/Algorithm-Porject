class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length < 2
    pivot = QuickSort.partition(array, start, length, &prc)

    left_start = start
    left_length = pivot - start
    right_start = pivot + 1
    right_length = length - 1 - left_length

    QuickSort.sort2!(array, left_start, left_length, &prc)
    QuickSort.sort2!(array, right_start, right_length, &prc)

    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new {|el1, el2| el1 <=> el2}
    barrier = start
    pivot = array[start]

    i = start + 1
    while i < length + start
      if (prc.call(array[i], pivot) <= 0)
        array[barrier+1], array[i] = array[i], array[barrier+1]
        barrier += 1
      end
      i += 1
    end
    # swap the pivot with element at barrier
    array[barrier], array[start] = array[start], array[barrier]
    barrier
  end
end
