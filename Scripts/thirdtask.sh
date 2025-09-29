#!/bin/bash
# the  script will fail if error  and show the error
set -euo pipefail

echo "third conveyor"

{
#table header
printf "%-20s %-12s %s\n" "Filesystem"  "Available"  "Mounted on"

#getting data for the task (disk pace usage monitoring)
df -Pk \
| awk 'NR>1 {printf "%-20s %-12s %s\n", $1, $4, $6}' \
| sort -k2,2n
} > disk_space_usage.txt

echo "Ready, check the file disk_space_usage.txt"

