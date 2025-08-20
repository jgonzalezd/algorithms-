#!/bin/bash
set -e

# Initialize debug mode flag
DEBUG_MODE=false

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

show_help() {
    echo "Usage: $(basename "$0") [-d] [-h|--help] {ts|js|py|rb}"
    echo "Run challenge solutions."
    echo ""
    echo "  -d            Enable debug mode."
    echo "  -h, --help    Show this help message and exit."
    echo ""
    echo "Languages:"
    echo "  ts            TypeScript"
    echo "  js            JavaScript"
    echo "  py            Python"
    echo "  rb            Ruby"
    exit 0
}

# Run tests for a specific language
run_tests() {
    local lang=$1
    case "$lang" in
        ts)
            file=$(find_solution_file "TypeScript" "ts")
            if [ "$DEBUG_MODE" = true ]; then
                echo "Debugging TypeScript solution: $file"
                echo "Starting Node.js built-in debugger in the terminal..."
                node inspect -r ts-node/register "$file"
            else
                echo "Running TypeScript solution: $file"
                ts-node --compiler-options '{"module": "commonjs"}' "$file"
            fi
            ;;
        js)
            file=$(find_solution_file "JavaScript" "js")
            if [ "$DEBUG_MODE" = true ]; then
                echo "Debugging JavaScript solution: $file"
                echo "Open chrome://inspect in your browser to connect to the debugger"
                node --inspect-brk "$file"
            else
                echo "Running JavaScript solution: $file"
                node "$file"
            fi
            ;;
        py)
            file=$(find_solution_file "Python" "py")
            if [ "$DEBUG_MODE" = true ]; then
                echo "Debugging Python solution: $file"
                python3 -m pdb "$file"
            else
                echo "Running Python solution: $file"
                python3 "$file"
            fi
            ;;
        rb)
            file=$(find_solution_file "Ruby" "rb")
            if [ "$DEBUG_MODE" = true ]; then
                echo "Debugging Ruby solution: $file"
                ruby -r debug "$file"
            else
                echo "Running Ruby solution: $file"
                ruby "$file"
            fi
            ;;
        *)
            echo "Error: Unknown language '$lang'" >&2
            show_help >&2
            exit 1
            ;;
    esac
}

# Early exit for help flag
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    show_help
fi

# Argument Parsing
LANGUAGE=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    -d)
      DEBUG_MODE=true
      shift # past argument
      ;;
    -h|--help)
      show_help
      ;;
    -*) # Catches any other option starting with -
      echo "Error: Unknown option '$1'" >&2
      show_help >&2
      exit 1
      ;;
    *)
      if [[ -n "$LANGUAGE" ]]; then
        echo "Error: Only one language can be specified. Unexpected argument: '$1'" >&2
        show_help >&2
        exit 1
      fi
      LANGUAGE="$1"
      shift # past argument
      ;;
  esac
done

if [[ -z "$LANGUAGE" ]]; then
    echo "Error: Language argument is required." >&2
    show_help >&2
    exit 1
fi

run_tests "$LANGUAGE"
