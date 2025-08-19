import * as fs from 'fs';

function merge(nums1: number[], m: number, nums2: number[], n: number): void {
    /**
     * Merges two sorted arrays nums1 and nums2 into nums1 in-place.
     * nums1 has length m + n where first m elements are to be merged,
     * and nums2 has length n.
     */
    // Your solution here
}

function runTests(): void {
    const testCases = JSON.parse(fs.readFileSync('test_cases.json', 'utf8'));
    
    testCases.forEach((test: any, i: number) => {
        const nums1: number[] = [...test.nums1]; // Copy to avoid modifying original test case
        const m: number = test.m;
        const nums2: number[] = test.nums2;
        const n: number = test.n;
        const expected: number[] = test.expected;
        
        merge(nums1, m, nums2, n);
        const result: number[] = nums1;
        if (JSON.stringify(result) === JSON.stringify(expected)) {
            console.log(`Test case ${i+1} passed`);
        } else {
            console.log(`Test case ${i+1} failed: expected ${JSON.stringify(expected)}, got ${JSON.stringify(result)}`);
        }
    });
}

runTests();
