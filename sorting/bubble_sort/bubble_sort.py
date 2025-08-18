# Bubble Sort Implementation in Python
# Time Complexity: O(n²)
# Space Complexity: O(1)

def bubble_sort(arr):
    n = len(arr)
    swapped = True
    
    while swapped:
        swapped = False
        for i in range(n - 1):
            if arr[i] > arr[i + 1]:
                # Swap elements
                arr[i], arr[i + 1] = arr[i + 1], arr[i]
                swapped = True
        n -= 1  # Last element is now in place
    
    return arr

# Example usage
if __name__ == "__main__":
    test_array = [64, 34, 25, 12, 22, 11, 90]
    print(f"Original array: {test_array}")
    
    sorted_array = bubble_sort(test_array.copy())
    print(f"Sorted array: {sorted_array}")
