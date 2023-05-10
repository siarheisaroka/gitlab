#!/bin/bash
set -ex
# Make curl request and store output in variable
output=$(curl http://127.0.0.1:8000)
echo $output

# Check if "Django Girls Blog" exists in output
if [[ $output == *"Your it to gave life whom as"* ]]; then
	  echo "Found 'Your it to gave life whom as' in output"
  else
	    echo "Could not find 'Your it to gave life whom as' in output"
	      exit 1
fi

