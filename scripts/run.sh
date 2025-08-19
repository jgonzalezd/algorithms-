#!/bin/bash
set -e

# Find the solution file based on language extension
find_solution_file() {
    local lang=$1
    local ext=$2
    local file
    file=$(find . -maxdepth 1 -type f \( -name "solution.$ext" -o -name "*solution.$ext" \))
    if [ -z "$file" ]; then
        echo "Error: No .$ext solution file found in the current directory." >&2
        exit 1
    fi
    echo "$file"
}

# Run tests for a specific language
run_tests() {
    local lang=$1
    case "$lang" in
        ts)
            file=$(find_solution_file "TypeScript" "ts")
            echo "Running TypeScript solution: $file"
            ts-node --compiler-options '{"module": "commonjs"}' "$file"
            ;;
        js)
            file=$(find_solution_file "JavaScript" "js")
            echo "Running JavaScript solution: $file"
            node "$file"
            ;;
        py)
            file=$(find_solution_file "Python" "py")
            echo "Running Python solution: $file"
            python3 "$file"
            ;;
        rb)
            file=$(find_solution_file "Ruby" "rb")
            echo "Running Ruby solution: $file"
            ruby "$file"
            ;;
        *)
            echo "Usage: $0 {ts|js|py|rb}" >&2
            exit 1
            ;;
    esac
}

# Main script execution
if [ $# -eq 0 ]; then
    echo "Usage: $0 {ts|js|py|rb}" >&2
    exit 1
fi

run_tests "$1"
