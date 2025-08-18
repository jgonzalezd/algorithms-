# Bubble Sort Implementation in Python with Debug Points
# Time Complexity: O(n²)
# Space Complexity: O(1)

def bubble_sort(arr):
    n = len(arr)
    swapped = True
    iteration = 0
    
    print(f"🔍 DEBUG: Starting bubble sort with array: {arr}")
    
    while swapped:
        iteration += 1
        swapped = False
        
        print(f"🔄 DEBUG: Iteration {iteration}, array: {arr}")
        
        for i in range(n - 1):
            print(f"  📊 DEBUG: Comparing arr[{i}]={arr[i]} with arr[{i+1}]={arr[i+1]}")
            
            if arr[i] > arr[i + 1]:
                print(f"  🔄 DEBUG: Swapping {arr[i]} and {arr[i+1]}")
                # Swap elements
                arr[i], arr[i + 1] = arr[i + 1], arr[i]
                swapped = True
                print(f"  ✅ DEBUG: After swap: {arr}")
            else:
                print(f"  ✅ DEBUG: No swap needed")
        
        n -= 1  # Last element is now in place
        print(f"🎯 DEBUG: End of iteration {iteration}, swapped: {swapped}, n: {n}")
    
    print(f"🎉 DEBUG: Sorting completed in {iteration} iterations")
    return arr

# Example usage with debug output
if __name__ == "__main__":
    test_array = [64, 34, 25, 12, 22, 11, 90]
    print(f"🚀 Original array: {test_array}")
    
    sorted_array = bubble_sort(test_array.copy())
    print(f"✅ Final sorted array: {sorted_array}")
