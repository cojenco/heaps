require_relative "./min_heap"

# This method uses a heap to sort an array.
# Time Complexity:  O(nlogn) = O(nlogn + nlogn) since there are n additions and n removals
# Space Complexity: O(n) since using a MinHeap that has an internal array? but not creating an additional results array
def heapsort(list)
  # create heap instance and add
  heap = MinHeap.new
  list.each do |e|
    heap.add(e)
  end
  
  # retrieve min value from heap using heap#remove and reassign value to each index
  i = 0
  while i < list.length
    list[i] = heap.remove
    i += 1
  end

  return list
end