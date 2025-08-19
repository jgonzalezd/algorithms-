require_relative '../../lib/ruby_tester'

# Implement your solution here. Adjust the method name and parameters.
def solution(params)
  
  # Extract the parameters directly
  nums1 = params['nums1']
  m = params['m']
  nums2 = params['nums2']
  n = params['n']
  


  # Create a copy to avoid modifying the original array
  result = []
  i = 0
  j = 0
  while result.length < m + n
    if nums1[i] < nums2[j]
      result << nums1[i]
      i += 1
    else if nums1[i] > nums2[j]
      result << nums2[j]
      j += 1
    else
      result << nums1[i]
      result << nums2[j]
      i += 1
      j += 1
  end

  result
end

Tester.run(method(:solution)) if __FILE__ == $PROGRAM_NAME
