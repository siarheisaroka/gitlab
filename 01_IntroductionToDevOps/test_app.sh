#!/bin/bash
set -ex
# Make curl request and store output in variable
output=$(curl http://127.0.0.1:8000)
echo $output

# Check if "Django Girls Blog" exists in output
if [[ $output == *"Django Girls Blog"* ]]; then
	  echo "Found 'Django Girls Blog' in output"
  else
	    echo "Could not find 'Django Girls Blog' in output"
	      exit 1
fi

