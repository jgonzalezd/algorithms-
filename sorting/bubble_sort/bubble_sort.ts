// Bubble Sort Implementation in TypeScript
// Time Complexity: O(n²)
// Space Complexity: O(1)

function bubbleSort(arr: number[]): number[] {
    const n = arr.length;
    let swapped = true;
    
    while (swapped) {
        swapped = false;
        for (let i = 0; i < n - 1; i++) {
            if (arr[i] > arr[i + 1]) {
                // Swap elements
                [arr[i], arr[i + 1]] = [arr[i + 1], arr[i]];
                swapped = true;
            }
        }
        n--;  // Last element is now in place
    }
    
    return arr;
}

// Example usage
if (require.main === module) {
    const testArray: number[] = [64, 34, 25, 12, 22, 11, 90];
    console.log(`Original array: [${testArray}]`);
    
    const sortedArray = bubbleSort([...testArray]);
    console.log(`Sorted array: [${sortedArray}]`);
}

export default bubbleSort;
