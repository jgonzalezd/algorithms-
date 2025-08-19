import json
import sys
from typing import Callable, Any

def run(solution_func: Callable, case_file: str = 'test_cases.json') -> None:
    try:
        with open(case_file, 'r', encoding='utf-8') as f:
            test_cases = json.load(f)
    except FileNotFoundError:
        print(f"Error: {case_file} not found.")
        sys.exit(1)
    
    for i, case in enumerate(test_cases, start=1):
        expected = case.pop('expected', None)
        if expected is None:
            print(f"Warning: Test case {i} missing 'expected' key.")
            continue
        
        try:
            result = solution_func(**case)
        except Exception as e:
            print(f"❌ Test case {i} failed: Exception raised - {str(e)}")
            continue  # Or handle as needed
        
        if result == expected:
            print(f"✅ Test case {i} passed")
        else:
            print(f"❌ Test case {i} failed: expected {expected}, got {result}")
