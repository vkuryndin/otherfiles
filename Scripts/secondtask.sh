#!/bin/bash
# enabling showing errors
set -euo pipefail 

echo "second conveyor"
#cheсking whether relevant files are present 
if ! find "$HOME" -type f -name '*.txt' -size -1048577c | grep -q .; then
 echo "Nо txt files <=1 mb"
 exit 0
fi

#counting lines  xrgs will not run when there are no files
#making count variable to improve output
count=$(find "$HOME" -type f -name '*.txt' -size -1048577c -print0 \
|xargs -0 --no-run-if-empty wc -l \
|awk 'END {print (NR ? $1 : 0)}')

echo "Found $count lines in all .txt files (<=1 Mb)"
