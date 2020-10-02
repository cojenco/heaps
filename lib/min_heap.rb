class HeapNode
  attr_reader :key, :value

  def initialize(key, value)
    @key = key
    @value = value
  end
end

class MinHeap

  def initialize
    @store = []
  end

  # This method adds a HeapNode instance to the heap
  # Time Complexity: O(logn) where n is the total nodes of the heap, since at most we are just traversing one subtree
  # Space Complexity: O(logn) due to the system stack from recursion
  def add(key, value = key)
    # create a new node and add to the rear of the array (last leaf node)
    @store << HeapNode.new(key, value)

    # ensure heap property via calling heap_up
    last_index = @store.length - 1
    heap_up(last_index)
  end

  # This method removes and returns an element from the heap
  #   maintaining the heap structure
  # Time Complexity: O(logn) where n is the total nodes of the heap, since at most we are just traversing one subtree and maximum one swap per level
  # Space Complexity: O(logn) due to the system stack from recursion
  def remove()
    return nil if self.empty?

    # swap root node and last leaf node (swap head and rear of internal array) and pop it
    last_index = @store.length - 1
    swap(0, last_index)
    removed = @store.pop

    # ensure heap property via calling heap_down
    heap_down(0)
    return removed.value
  end


  # Used for Testing
  def to_s
    return "[]" if @store.empty?

    output = "["
    (@store.length - 1).times do |index|
      output += @store[index].value + ", "
    end

    output += @store.last.value + "]"
      
    return output
  end

  # This method returns true if the heap is empty
  # Time complexity: O(1)
  # Space complexity: O(1)
  def empty?
    return @store.empty?
  end

  private

  # This helper method takes an index and
  #  moves it up the heap, if it is less than it's parent node.
  #  It could be **very** helpful for the add method.
  # Time complexity: O(logn) since maximum one swap per level of the tree
  # Space complexity: O(logn) due to the system stack from recursion
  def heap_up(index)
    parent_index = (index - 1) / 2

    # base case: index at root or if current node is greater than parent node
    return if index == 0
    return if @store[index].key > @store[parent_index].key
    
    # recursive case: swap and run again
    swap(index, parent_index)
    heap_up(parent_index)
  end

  # This helper method takes an index and 
  #  moves it down the heap if it's greater
  #  than it's parent node.
  def heap_down(index)
    # calculate index of (possible) children
    child_L = index * 2 + 1
    child_R = index * 2 + 2

    # base case #1 - if current node has no children at all
    return if child_L >= @store.length    
    # base case #2 - if a child exists and current node is smaller than min_child
    min_child = child_L
    if child_R < @store.length
      min_child = @store[child_L].key < @store[child_R].key ? child_L : child_R
    end

    return if @store[index].key < @store[min_child].key

    # recursive case: swap and run again
    swap(index, min_child)
    heap_down(min_child)
  end

  # If you want a swap method... you're welcome
  def swap(index_1, index_2)
    temp = @store[index_1]
    @store[index_1] = @store[index_2]
    @store[index_2] = temp
  end
end