const fs = require('fs');

function merge(nums1, m, nums2, n) {
    /**
     * Merges two sorted arrays nums1 and nums2 into nums1 in-place.
     * nums1 has length m + n where first m elements are to be merged,
     * and nums2 has length n.
     */
    // Your solution here
}

function runTests() {
    const testCases = JSON.parse(fs.readFileSync('test_cases.json', 'utf8'));
    
    testCases.forEach((test, i) => {
        const nums1 = [...test.nums1]; // Copy to avoid modifying original test case
        const m = test.m;
        const nums2 = test.nums2;
        const n = test.n;
        const expected = test.expected;
        
        merge(nums1, m, nums2, n);
        const result = nums1;
        if (JSON.stringify(result) === JSON.stringify(expected)) {
            console.log(`Test case ${i+1} passed`);
        } else {
            console.log(`Test case ${i+1} failed: expected ${JSON.stringify(expected)}, got ${JSON.stringify(result)}`);
        }
    });
}

runTests();
