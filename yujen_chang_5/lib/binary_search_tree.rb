# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require_relative 'bst_node'

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    if @root == nil
      @root = BSTNode.new(value)
    else
      insert_node(@root, value)
    end
  end

  def find(value, tree_node = @root)
    return nil if tree_node == nil

    if tree_node.value == value
      tree_node
    elsif tree_node.value > value
      find(value, tree_node.left)
    else
      find(value, tree_node.right)
    end
  end

  def delete(value)
    target_node = find(value, node=@root)
    parent = target_node.parent

    return @root = nil if target_node == @root
    return nil if target_node == nil

    if (target_node.left == nil && target_node.right == nil)
      if target_node.value > parent.value
        parent.right = nil
      else
        parent.left = nil
      end
    elsif (target_node.left != nil && target_node.right == nil)
      parent.left = target_node.left
      target_node.left.parent = parent

    elsif (target_node.left == nil && target_node.right != nil)
      parent.right = target_node.right
      target_node.right.parent = parent

    else
      left_max_node = maximum(target_node.left)
      # if left_max_node has left children, it would take left_max_node old place
      if left_max_node.left != nil
        left_max_node.parent.right = left_max_node.left
        left_max_node.left.parent = left_max_node.parent
      end

      # replace target_node with left_max_node
      parent.left = left_max_node
      left_max_node.parent = parent
      left_max_node.left = target_node.left
      left_max_node.right = target_node.right
    end

    # remove the target_node from parent
    parent.remove(target_node)
    # target_node
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    if tree_node.right.nil?
      tree_node
    else
      # keep checking the right nodes
      maximum(tree_node.right)
    end

  end

  def depth(tree_node = @root)
    return 0 if tree_node == nil || (tree_node.left == nil && tree_node.right == nil)
    if (tree_node.right == nil)
      left_depth = 1 + depth(tree_node.left)
    elsif (tree_node.left == nil)
      right_depth = 1 + depth(tree_node.right)
    else
      1 + [depth(tree_node.right), depth(tree_node.left)].max
    end

  end

  def is_balanced?(tree_node = @root)
    return true if tree_node == nil

    difference = depth(tree_node.left) - depth(tree_node.right)
    if (difference.abs <= 1)
      if is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
        return true
      end
    end

    false
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return arr if tree_node == nil

    arr = in_order_traversal(tree_node.left, arr)
    arr += [tree_node.value]
    arr = in_order_traversal(tree_node.right, arr)

    arr
  end


  private
  # optional helper methods go here:
  def insert_node(node, value)
    return BSTNode.new(value) if node == nil

    if (node.value >= value)
      node.left = insert_node(node.left, value)
      node.left.parent = node
    else
      node.right = insert_node(node.right, value)
      node.right.parent = node
    end

    node
  end

end

# another different way for delete
# def delete(value)
#   @root = remove_from_tree(@root, value)
# end
#
# def remove_from_tree(tree_node, value)
#   if value == tree_node.value
#     remove(tree_node)
#   elsif value < tree_node.value
#     tree_node.left = remove_from_tree(tree_node.left, value)
#   else
#     tree_node.right = remove_from_tree(tree_node.right, value)
#   end
#
#   tree_node
# end
#
# def remove(node)
#   if node.right.nil? && node.left.nil?
#     node = nil
#   elsif node.left && node.right.nil?
#     node = node.left
#   elsif node.left.nil? && node.right
#     node = node.right
#   else
#     noe = replace_parent(node)
#   end
# end
#
# def replace_parent(node)
#   replacement_node = maximum(node.left)
#
#   if replace_node.left
#     node.left.right = replacement_node.left
#   end
#
#   replacement_node.left = node.left
#   replacement_node.right = node.right
#
#   replacement_node
# end
