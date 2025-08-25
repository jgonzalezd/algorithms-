const { run } = require('../../lib/ts_tester');

function solution(/* parameters */): any {
  /**
   * Implement your solution here.
   * Adjust the function signature and return type to match your challenge.
   */
  throw new Error('Not implemented');
}

// Different ways to call run() with optional parameters:

// 1. Run all test cases (default behavior)
run(solution);

// 2. Run only test case with ID 1
run(solution, { id: 1 });

// 3. Run with custom filename and specific ID
// run(solution, { caseFile: 'test_cases.json', id: 1 });

// 4. Run with custom filename only (all test cases)
// run(solution, { caseFile: 'custom_test_cases.json' });
