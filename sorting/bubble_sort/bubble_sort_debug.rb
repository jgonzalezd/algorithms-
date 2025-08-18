# Bubble Sort Implementation in Ruby with Debug Points
# Time Complexity: O(n²)
# Space Complexity: O(1)

def bubble_sort(arr)
  n = arr.length
  swapped = true
  iteration = 0
  
  puts "🔍 DEBUG: Starting bubble sort with array: #{arr.inspect}"
  
  while swapped
    iteration += 1
    swapped = false
    
    puts "🔄 DEBUG: Iteration #{iteration}, array: #{arr.inspect}"
    
    (0...n-1).each do |i|
      puts "  📊 DEBUG: Comparing arr[#{i}]=#{arr[i]} with arr[#{i+1}]=#{arr[i+1]}"
      
      if arr[i] > arr[i + 1]
        puts "  🔄 DEBUG: Swapping #{arr[i]} and #{arr[i+1]}"
        # Swap elements
        arr[i], arr[i + 1] = arr[i + 1], arr[i]
        swapped = true
        puts "  ✅ DEBUG: After swap: #{arr.inspect}"
      else
        puts "  ✅ DEBUG: No swap needed"
      end
    end
    
    n -= 1  # Last element is now in place
    puts "🎯 DEBUG: End of iteration #{iteration}, swapped: #{swapped}, n: #{n}"
  end
  
  puts "🎉 DEBUG: Sorting completed in #{iteration} iterations"
  arr
end

# Example usage with debug output
if __FILE__ == $0
  test_array = [64, 34, 25, 12, 22, 11, 90]
  puts "🚀 Original array: #{test_array}"
  
  sorted_array = bubble_sort(test_array.dup)
  puts "✅ Final sorted array: #{sorted_array}"
end
