#!/bin/bash

# the script will fail if error and show the error
set -euo pipefail

# correct sorting of CPU
export LC_ALL=C
echo "first conveyor"
{
 #table header
 printf "%-7s %-6s %s\n" "PID" "%CPU" "COMMAND"

 #data
 ps aux \
 | grep -E '^root[[:space:]]' \
 | awk '{printf "%-7s %-6s %s\n", $2, $3, substr($0, index($0,$11))}' \
 | sort -k2,2nr 
} > system_monitoring.txt

echo "Ready, check the file system_monitoring.txt " 
