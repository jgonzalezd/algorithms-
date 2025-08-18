# Bubble Sort Implementation in Ruby
# Time Complexity: O(n²)
# Space Complexity: O(1)

def bubble_sort(arr)
  n = arr.length
  swapped = true
  
  while swapped
    swapped = false
    (0...n-1).each do |i|
      if arr[i] > arr[i + 1]
        # Swap elements
        arr[i], arr[i + 1] = arr[i + 1], arr[i]
        swapped = true
      end
    end
    n -= 1  # Last element is now in place
  end
  
  arr
end

# Example usage
if __FILE__ == $0
  test_array = [64, 34, 25, 12, 22, 11, 90]
  puts "Original array: #{test_array}"
  
  sorted_array = bubble_sort(test_array.dup)
  puts "Sorted array: #{sorted_array}"
end
