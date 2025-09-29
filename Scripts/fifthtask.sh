#!/bin/bash
set -euo pipefail
export LC_ALL=C

echo "fifth conveyor"

{
#table header
 printf "%10s\t%s\n" "SIZE_MB" "DIRECTORY"

#data calculating sizes  of subdirectories, not recursive
#du  - disk usage
#awk - text processing
#head - top 5 directories
du -m --max-depth=1 /home \
| awk '$2 != "/home" && $1 > 100' \
| sort -k1,1nr \
| head -n 5 \
| awk '{printf "%10d\t%s\n", $1, $2}'
} > largest_directories.txt


# if there is no lines in the file or equal to 1 ,this means that there are no big directories
if [[ $(wc -l < largest_directories.txt) -le 1 ]]; then
 msg="No subdirectories larger than 100 MB in /home"
 echo "$msg"
 echo "$msg" >> largest_directories.txt
 
 echo "Showing subdirectories <=100MB:"

#counting directories one more time
 du -m --max-depth=1 /home \
 | awk '$2  != "/home" && $1 <= 100 {printf " - %s : %d MB\n", $2, $1 }'
fi

echo "Ready, check the file largest_directories.txt"

