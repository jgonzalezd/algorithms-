require 'json'

module Tester
  def self.run(solution_func, case_file = 'test_cases.json')
    begin
      test_cases = JSON.parse(File.read(case_file))
    rescue Errno::ENOENT
      puts "Error: #{case_file} not found."
      exit(1)
    end

    test_cases.each_with_index do |test, i|
      expected = test.delete('expected')
      if expected.nil?
        puts "Warning: Test case #{i+1} missing 'expected' key."
        next
      end

      begin
        result = solution_func.call(test)
      rescue StandardError => e
        puts "❌ Test case #{i+1} failed: Exception raised - #{e.message}"
        next
      end

      if result == expected
        puts "✅ Test case #{i+1} passed"
      else
        puts "❌ Test case #{i+1} failed: expected #{expected}, got #{result}"
      end
    end
  end
end
