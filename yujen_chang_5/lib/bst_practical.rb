def kth_largest(tree_node, k)
  arr = []
  arr = in_order_traversal(tree_node, arr)
  arr[k-1]
end

# order: large to small
def in_order_traversal(tree_node, arr = [])
  return arr if tree_node == nil

  arr = in_order_traversal(tree_node.right, arr)
  arr << tree_node
  arr = in_order_traversal(tree_node.left, arr)

  arr
end
