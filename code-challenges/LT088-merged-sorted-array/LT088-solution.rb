require 'json'

def merge(nums1, m, nums2, n)
  # Merges two sorted arrays nums1 and nums2 into nums1 in-place.
  # nums1 has length m + n where first m elements are to be merged,
  # and nums2 has length n.
  # Your solution here
end

def run_tests
  test_cases = JSON.parse(File.read('test_cases.json'))
  
  test_cases.each_with_index do |test, i|
    nums1 = test['nums1'].dup  # Duplicate to avoid modifying original test case
    m = test['m']
    nums2 = test['nums2']
    n = test['n']
    expected = test['expected']
    
    merge(nums1, m, nums2, n)
    result = nums1
    if result == expected
      puts "Test case #{i+1} passed"
    else
      puts "Test case #{i+1} failed: expected #{expected}, got #{result}"
    end
  end
end

run_tests if __FILE__ == $PROGRAM_NAME
