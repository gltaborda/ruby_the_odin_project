class Node
  attr_reader :value
  attr_accessor :next_node
  def initialize(value)
    @value = value
    @next_node = nil
  end
end


class LinkedList
  attr_reader :head, :tail, :size
  #attr_accessor 
  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value)
    new_node = Node.new(value)
    if is_empty?
      load_empty_list(new_node)
      @size += 1
    else
      @tail.next_node = new_node
      @tail = new_node
      @size += 1
    end
  end

  def prepend(value)
    new_node = Node.new(value)
    if is_empty?
      load_empty_list(new_node)
      @size += 1
    else
      auxiliar_node = @head
      @head = new_node
      new_node.next_node = auxiliar_node
      @size += 1
    end
  end

  def at(index)
    if index > @size - 1
      return "Index bigger than the size of the list"
    else
      current_node = @head
      (index).times do
        current_node = current_node.next_node        
      end
    end
    current_node
  end

  def pop
    auxiliar_node = @tail
    @tail = at(size-2)
    @tail.next_node = nil
    auxiliar_node
    @size -= 1
  end

  def contains?(value)
    found = false
    current_node = @head
    until found || current_node.nil? do
      found = (value == current_node.value)
      current_node = current_node.next_node
    end
    found
  end

  def find(value)
    index = nil
    found = false
    current_index = 0
    current_node = @head
    until found || current_node.nil? do
      if value == current_node.value
        index = current_index
        found = true
      end
      current_node = current_node.next_node
      current_index += 1
    end
    index
  end

  def to_s
    string_of_list = ""
    current_node = @head
    until current_node.nil? do
      string_of_list += "( #{current_node.value} ) => "
      current_node = current_node.next_node
    end
    string_of_list += "nil"
  end

  def insert_at(index, value)
    new_node = Node.new(value)
    previous_node = at(index-1)
    new_node.next_node = previous_node.next_node
    previous_node.next_node = new_node
    @size += 1
  end

  def remove_at(index)
    previous_node = at(index-1)
    auxiliar_node = previous_node.next_node
    previous_node.next_node = auxiliar_node.next_node
    #auxiliar_node.next_node = nil                      not really needed, just deletes a reference to the list
    @size -= 1
  end

  def is_empty?
    @size == 0
  end

  def load_empty_list(new_node)
    @head = new_node
    @tail = new_node
  end

end

list = LinkedList.new
list.prepend(1)
list.append(2)
list.append(3)
puts list.head.value
puts list.at(0).value
puts list.head.next_node.value
puts list.at(1).value
puts list.tail.value
puts list.at(2).value
puts list.tail.next_node.nil?
puts list.size
puts list.head
puts list.head.next_node
puts list.tail
puts list.pop
puts list.tail
puts list.contains?(3)
p list.find(2)
puts list.to_s
list.append(3)
list.append(5)
puts list.to_s
list.insert_at(3,4)
puts list.to_s
list.insert_at(3,6)
puts list.to_s
list.remove_at(3)
puts list.to_s