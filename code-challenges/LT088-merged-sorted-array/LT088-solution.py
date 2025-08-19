import json

def merge(nums1, m, nums2, n):
    """
    Merges two sorted arrays nums1 and nums2 into nums1 in-place.
    nums1 has length m + n where first m elements are to be merged,
    and nums2 has length n.
    """
    # Your solution here
    pass

def run_tests():
    with open('test_cases.json', 'r') as f:
        test_cases = json.load(f)
    
    for i, test in enumerate(test_cases):
        nums1 = test['nums1'].copy()  # Copy to avoid modifying original test case
        m = test['m']
        nums2 = test['nums2']
        n = test['n']
        expected = test['expected']
        
        merge(nums1, m, nums2, n)
        result = nums1
        assert result == expected, f"Test case {i+1} failed: expected {expected}, got {result}"
        print(f"Test case {i+1} passed")

if __name__ == "__main__":
    run_tests()
