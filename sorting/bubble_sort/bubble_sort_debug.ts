// Bubble Sort Implementation in TypeScript with Debug Points
// Time Complexity: O(n²)
// Space Complexity: O(1)

function bubbleSort(arr: number[]): number[] {
    const n = arr.length;
    let swapped = true;
    let iteration = 0;
    
    console.log(`🔍 DEBUG: Starting bubble sort with array: [${arr}]`);
    
    while (swapped) {
        iteration += 1;
        swapped = false;
        
        console.log(`🔄 DEBUG: Iteration ${iteration}, array: [${arr}]`);
        
        for (let i = 0; i < n - 1; i++) {
            console.log(`  📊 DEBUG: Comparing arr[${i}]=${arr[i]} with arr[${i+1}]=${arr[i+1]}`);
            
            if (arr[i] > arr[i + 1]) {
                console.log(`  🔄 DEBUG: Swapping ${arr[i]} and ${arr[i+1]}`);
                // Swap elements
                [arr[i], arr[i + 1]] = [arr[i + 1], arr[i]];
                swapped = true;
                console.log(`  ✅ DEBUG: After swap: [${arr}]`);
            } else {
                console.log(`  ✅ DEBUG: No swap needed`);
            }
        }
        
        n--;  // Last element is now in place
        console.log(`🎯 DEBUG: End of iteration ${iteration}, swapped: ${swapped}, n: ${n}`);
    }
    
    console.log(`🎉 DEBUG: Sorting completed in ${iteration} iterations`);
    return arr;
}

// Example usage with debug output
if (require.main === module) {
    const testArray: number[] = [64, 34, 25, 12, 22, 11, 90];
    console.log(`🚀 Original array: [${testArray}]`);
    
    const sortedArray = bubbleSort([...testArray]);
    console.log(`✅ Final sorted array: [${sortedArray}]`);
}

export default bubbleSort;
