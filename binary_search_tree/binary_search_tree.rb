class Node
  attr_reader :value
  attr_accessor :left, :right
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  def has_children?
    !(self.left == nil && self.right == nil)
  end
end

class BinarySearchTree
  attr_reader :root
  def initialize(array)
    @root = build_a_tree(array)
    @array = array
  end

  def build_a_tree(array)
    sorted_array = array.uniq.sort
    sort_array_bst(sorted_array)
  end

  def insert(value)
    add_node(@root, value)
  end

  def add_node(current_node, value)
    if value < current_node.value
      if current_node.left.nil?
        node = Node.new(value)
        current_node.left = node 
      elsif
        current_node = current_node.left
        add_node(current_node,value)
      end
    elsif
      if current_node.right.nil?
        node = Node.new(value)
        current_node.right = node 
      elsif
        current_node = current_node.right
        add_node(current_node,value)
      end
    end
  end

  def delete(value)
    remove_children(@root, value)
  end

  def remove_children(current_node, value)
    if value < current_node.value
      if current_node.left.value == value
        remove_by_children(current_node, current_node.left, "left")
      else
        remove_children(current_node.left, value)
      end
    else
      if current_node.right.value == value
        remove_by_children(current_node, current_node.right, "right")
      else
        remove_children(current_node.right, value)
      end
    end
  end

  def remove_by_children(parent, child, relationship)
    if child.has_children?
      if relationship == "left"
        parent.left = child.left || child.right
        parent.left.right = child.right unless child.right.nil?
      elsif relationship == "right"
        parent.right = child.left || child.right
        parent.right.right = child.right unless child.right.nil?
      end

    else
      if relationship == "left"
        parent.left = nil
      else
        parent.right = nil
      end
    end
  end
  
  def sort_array_bst(array)
    unless array.empty? 
      middle = array.length/2
      current_node = Node.new(array[middle])
      current_node.left = sort_array_bst(array[0...middle])
      current_node.right = sort_array_bst(array[(middle + 1)..])
      current_node
    else
      nil
    end
  end
  
end

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = BinarySearchTree.new(array)
tree.insert(24)
tree.delete(67)
puts tree.root.right.value
puts tree.root.right.left.value
puts tree.root.right.left.right.value
puts tree.root.right.right.value







