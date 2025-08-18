# 🐛 Algorithm Debugging Guide

This guide covers debugging techniques for all four languages in your algorithm study environment.

## 🚀 Quick Start Debugging

### Method 1: VS Code Debugger (Recommended)

1. **Open any algorithm file** (`.rb`, `.py`, `.js`, `.ts`)
2. **Set breakpoints** by clicking in the gutter (left margin)
3. **Press F5** or go to Run → Start Debugging
4. **Select the appropriate debug configuration**:
   - "Debug Ruby Algorithm" for `.rb` files
   - "Debug Python Algorithm" for `.py` files
   - "Debug JavaScript Algorithm" for `.js` files
   - "Debug TypeScript Algorithm" for `.ts` files

### Method 2: Debug with Test Cases

```bash
# Debug Python algorithm with test cases
python debug_with_tests.py sorting/bubble_sort/bubble_sort.py sorting/bubble_sort/test_cases.json
```

## 🔧 Language-Specific Debugging

### Ruby Debugging

#### VS Code Debugger
- ✅ **Fully supported** with Ruby extension
- Set breakpoints and use F5 to start debugging
- Variables, call stack, and watch expressions available

#### Command Line Debugging
```bash
# Debug with pry (interactive debugger)
cd sorting/bubble_sort
ruby -r pry -e "require_relative 'bubble_sort'; binding.pry"

# Debug with byebug
ruby -r byebug bubble_sort.rb
```

#### Adding Debug Points in Code
```ruby
# Add this line where you want to pause
require 'pry'; binding.pry

# Or use byebug
require 'byebug'; byebug

# Simple debug output
puts "DEBUG: arr = #{arr.inspect}"
```

### Python Debugging

#### VS Code Debugger
- ✅ **Fully supported** with Python extension
- Set breakpoints and use F5 to start debugging
- Full variable inspection and step-through

#### Command Line Debugging
```bash
# Debug with pdb
cd sorting/bubble_sort
python -m pdb bubble_sort.py

# Debug with ipdb (enhanced pdb)
python -m ipdb bubble_sort.py
```

#### Adding Debug Points in Code
```python
# Add breakpoint (Python 3.7+)
breakpoint()

# Or use pdb
import pdb; pdb.set_trace()

# Or use ipdb for better experience
import ipdb; ipdb.set_trace()

# Simple debug output
print(f"DEBUG: arr = {arr}")
```

### JavaScript Debugging

#### VS Code Debugger
- ✅ **Fully supported** with Node.js debugger
- Set breakpoints and use F5 to start debugging
- Full variable inspection and step-through

#### Command Line Debugging
```bash
# Debug with Node.js inspector
cd sorting/bubble_sort
node --inspect-brk bubble_sort.js

# Debug with ts-node
ts-node --inspect-brk bubble_sort.ts
```

#### Adding Debug Points in Code
```javascript
// Add breakpoint
debugger;

// Simple debug output
console.log('DEBUG:', { arr, i, swapped });
console.table(arr); // Nice table format for arrays
```

### TypeScript Debugging

#### VS Code Debugger
- ✅ **Fully supported** with TypeScript debugger
- Set breakpoints and use F5 to start debugging
- Full type information and variable inspection

#### Command Line Debugging
```bash
# Debug with ts-node
cd sorting/bubble_sort
ts-node --inspect-brk bubble_sort.ts

# Compile and debug
tsc bubble_sort.ts
node --inspect-brk bubble_sort.js
```

#### Adding Debug Points in Code
```typescript
// Add breakpoint
debugger;

// Simple debug output
console.log('DEBUG:', { arr, i, swapped });
console.table(arr); // Nice table format for arrays
```

## 🎯 Advanced Debugging Techniques

### 1. Step-by-Step Execution

**VS Code Controls:**
- **F10**: Step Over (execute current line)
- **F11**: Step Into (go into function calls)
- **Shift+F11**: Step Out (exit current function)
- **F5**: Continue execution
- **Shift+F5**: Stop debugging

### 2. Variable Inspection

**Watch Expressions:**
- Add variables to watch in the Debug panel
- Use expressions like `arr.length`, `i < n-1`

**Call Stack:**
- View the call stack to understand execution flow
- Click on stack frames to navigate

### 3. Conditional Breakpoints

1. Right-click on a breakpoint
2. Select "Edit Breakpoint"
3. Add condition: `i === 5` or `arr.length > 10`

### 4. Logpoint Debugging

1. Right-click on a breakpoint
2. Select "Add Logpoint"
3. Enter: `Array: {arr}, Index: {i}, Swapped: {swapped}`

## 🔍 Debugging Common Algorithm Issues

### 1. Array Index Out of Bounds
```python
# Python
print(f"Array length: {len(arr)}, Index: {i}")

# Ruby
puts "Array length: #{arr.length}, Index: #{i}"

# JavaScript/TypeScript
console.log(`Array length: ${arr.length}, Index: ${i}`);
```

### 2. Infinite Loops
```python
# Add loop counter
loop_count = 0
while swapped and loop_count < 1000:
    loop_count += 1
    print(f"Loop iteration: {loop_count}")
    # ... rest of loop
```

### 3. Wrong Output
```python
# Compare expected vs actual
expected = [1, 2, 3, 4, 5]
actual = bubble_sort([3, 1, 4, 1, 5])
print(f"Expected: {expected}")
print(f"Actual: {actual}")
print(f"Match: {expected == actual}")
```

## 🛠️ Debugging Tools

### Built-in Tools
- **VS Code Debugger**: Primary debugging tool
- **Console Output**: Simple print/puts/console.log debugging
- **Test Cases**: Use `test_cases.json` files for systematic testing

### External Tools
- **Ruby**: pry, byebug, ruby-debug
- **Python**: pdb, ipdb, pudb
- **JavaScript**: Node.js inspector, Chrome DevTools
- **TypeScript**: Same as JavaScript + type checking

## 📋 Debugging Checklist

Before starting to debug:
- [ ] Set breakpoints at key points in the algorithm
- [ ] Have test cases ready
- [ ] Understand the expected input/output
- [ ] Know the algorithm's time/space complexity
- [ ] Have a hypothesis about what might be wrong

During debugging:
- [ ] Step through the code line by line
- [ ] Inspect variable values at each step
- [ ] Compare actual vs expected behavior
- [ ] Check array indices and loop conditions
- [ ] Verify data types and conversions

## 🎯 Example Debugging Session

Let's debug a bubble sort implementation:

1. **Set breakpoints** at:
   - Start of the main loop
   - Inside the comparison condition
   - After the swap operation

2. **Start debugging** with F5

3. **Step through** and watch:
   - Array state after each iteration
   - Whether swaps are happening
   - Loop termination conditions

4. **Use watch expressions**:
   - `arr` (full array)
   - `i` (current index)
   - `swapped` (swap flag)

5. **Check test cases** to verify correctness

## 🚀 Performance Debugging

### Memory Usage
```python
# Python
import tracemalloc
tracemalloc.start()
# ... your algorithm
current, peak = tracemalloc.get_traced_memory()
print(f"Current memory usage: {current / 1024 / 1024:.1f} MB")
print(f"Peak memory usage: {peak / 1024 / 1024:.1f} MB")
```

### Execution Time
```python
# Python
import time
start_time = time.time()
# ... your algorithm
end_time = time.time()
print(f"Execution time: {end_time - start_time:.4f} seconds")
```

### JavaScript/TypeScript
```javascript
// Performance timing
console.time('bubbleSort');
bubbleSort(arr);
console.timeEnd('bubbleSort');

// Memory usage (Node.js)
const used = process.memoryUsage();
console.log(`Memory usage: ${Math.round(used.heapUsed / 1024 / 1024 * 100) / 100} MB`);
```

This debugging setup gives you comprehensive tools to debug algorithms in all four languages effectively!
