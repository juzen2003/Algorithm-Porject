class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    @store.length
  end

  def extract
    # swap root and last node
    @store[0], @store[-1] = @store[-1], @store[0]
    # pop out last value
    pop_val = @store.pop
    # heapify down
    BinaryMinHeap.heapify_down(@store, 0, count, &@prc)
    pop_val
  end

  def peek
    @store[0]
  end

  def push(val)
    # push in value
    @store << val
    # heapify up
    BinaryMinHeap.heapify_up(@store, count-1, count, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    if (parent_index * 2 + 1) > len-1
      nil
    elsif (parent_index * 2 + 2) > len - 1
      [parent_index * 2 + 1]
    else
      [parent_index * 2 + 1, parent_index * 2 + 2]
    end
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1)/2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    # default proc
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    # get children indices
    children_idx = BinaryMinHeap.child_indices(len, parent_idx)

    # base case: return array if children_indices is nil or all children nodes are larger than parent
    return array if children_idx == nil || children_idx.all?{|idx| prc.call(array[parent_idx], array[idx]) <= 0}

    # there is at least one children node smaller than parent
    # p "children_idx: #{children_idx}"

    if children_idx.length == 1
      next_idx = children_idx[0]
    else
      # if prc.call(children_idx[0], children_idx[1]) == -1
      if prc.call(array[children_idx[0]], array[children_idx[1]]) == -1
        next_idx = children_idx[0]
      else
        next_idx = children_idx[1]
      end

    end
    # p "next: #{array[next_idx]}"
    # p "parent #{array[parent_idx]}"
    # swap
    array[parent_idx], array[next_idx] = array[next_idx], array[parent_idx]

    # keep heaping down
    heapify_down(array, next_idx, array.length, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    # base case
    return array if child_idx == 0
    parent_idx = BinaryMinHeap.parent_index(child_idx)

    if(prc.call(array[parent_idx], array[child_idx]) >= 0)
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
    end

    heapify_up(array, parent_idx, array.length, &prc)

  end
end
