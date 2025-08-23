require 'json'

module Tester
  def self.run(solution_func, id = nil, case_file = 'test_cases.json')
    begin
      case_file 
      test_cases = JSON.parse(File.read(case_file))
    rescue Errno::ENOENT
      puts "Error: #{case_file} not found."
      exit(1)
    end

    test_cases.each_with_index do |test, i|
      current_id = test.delete('id')
      if id && current_id != id
        next
      end
      expected = test.delete('expected')
      if expected.nil?
        puts "Warning: Test case #{i+1} missing 'expected' key."
        next
      end

      begin
        result = solution_func.call(test['params'])
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
