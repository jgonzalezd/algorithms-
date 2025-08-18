# Bubble Sort Algorithm

## Overview
Bubble Sort is a simple sorting algorithm that repeatedly steps through the list, compares adjacent elements, and swaps them if they are in the wrong order.

## Algorithm
1. Compare adjacent elements
2. If they are in wrong order, swap them
3. Repeat until no swaps are needed

## Complexity Analysis
- **Time Complexity**: O(n²) - Worst and Average case
- **Space Complexity**: O(1) - In-place sorting
- **Stability**: Stable

## Implementation Files
- `bubble_sort.rb` - Ruby implementation
- `bubble_sort.py` - Python implementation  
- `bubble_sort.js` - JavaScript implementation
- `bubble_sort.ts` - TypeScript implementation

## Usage Examples

### Ruby
```bash
cd sorting/bubble_sort
ruby bubble_sort.rb
```

### Python
```bash
cd sorting/bubble_sort
python bubble_sort.py
```

### JavaScript
```bash
cd sorting/bubble_sort
node bubble_sort.js
```

### TypeScript
```bash
cd sorting/bubble_sort
ts-node bubble_sort.ts
```

## Performance Comparison
Run all implementations to compare performance:
```bash
time ruby bubble_sort.rb
time python bubble_sort.py
time node bubble_sort.js
time ts-node bubble_sort.ts
```

## Test Cases
See `test_cases.json` for various test scenarios including:
- Empty arrays
- Single element arrays
- Already sorted arrays
- Reverse sorted arrays
- Arrays with duplicates
