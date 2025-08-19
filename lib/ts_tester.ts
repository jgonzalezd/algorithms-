const fs = require('fs');

/**
 * Runs test cases from a JSON file against a provided solution function.
 * @param solutionFunc - The solution function to test.
 * @param caseFile - Path to the test cases JSON file.
 */
function runTests(solutionFunc: (...args: any[]) => any, caseFile: string = 'test_cases.json'): void {
  let testCases: any[];
  try {
    testCases = JSON.parse(fs.readFileSync(caseFile, 'utf8'));
  } catch (e: any) {
    console.error(`Error: ${caseFile} not found or invalid JSON.`, e.message);
    process.exit(1);
  }

  testCases.forEach((test: any, i: number) => {
    const { expected, ...params } = test;
    if (expected === undefined) {
      console.log(`Warning: Test case ${i + 1} missing 'expected' key.`);
      return;
    }

    try {
      // Convert params object to array of values if solution expects multiple args
      // or pass as a single object if that's the expected format.
      const result = Object.keys(params).length > 0 
        ? solutionFunc(...Object.values(params)) 
        : solutionFunc();
      if (JSON.stringify(result) === JSON.stringify(expected)) {
        console.log(`✅ Test case ${i + 1} passed`);
      } else {
        console.log(`❌ Test case ${i + 1} failed: expected ${JSON.stringify(expected)}, got ${JSON.stringify(result)}`);
      }
    } catch (e: any) {
      console.log(`❌ Test case ${i + 1} failed: Exception raised - ${e.message}`);
    }
  });
}

module.exports = { run: runTests };
