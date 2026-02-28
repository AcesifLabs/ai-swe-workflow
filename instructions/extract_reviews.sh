#!/bin/bash

# Check if a file was provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path_to_json_file>"
    exit 1
fi

INPUT_FILE="$1"

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "Error: 'jq' is not installed. Please install it to run this script."
    exit 1
fi

# Process the JSON and format the output
jq 'map(select(.position != null) | {
  file_path: .position.new_path,
  issue_line: .position.new_line,
  issue_line_range: (if .position.line_range then {
    start: .position.line_range.start.new_line,
    end: .position.line_range.end.new_line
  } else null end),
  is_resolved: .resolved,
  requested_change: .body
})' "$INPUT_FILE"
