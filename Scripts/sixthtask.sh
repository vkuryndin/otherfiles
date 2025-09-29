#!/usr/bin/env bash
set -euo pipefail
export LC_ALL=C

# hosts list
hosts=("192.168.179.2" "192.168.179.129" "192.168.179.1" "192.168.2.1")

#counters
available=0
unavailable=0

outfile="hosts_check.txt"

#create the file
: > "$outfile"

#making the cycle
#enabling debugging
#set -x
for host in "${hosts[@]}"; do
  if timeout 2 ping -n -c 1 -W 1 -w 2 "$host" &> /dev/null; then
    echo "Host $host available"
    echo "Host $host available" >> "$outfile"
    ((++available))
  else
    echo "Host $host not available"
    echo "Host $host not available" >> "$outfile"
    ((++unavailable))
  fi
done
#disabling debugging
#set +x
#showing the results
echo "------------------------------"
echo "Available hosts  : $available"
echo "Unavailable hosts: $unavailable"

#writing results to file

{
  echo "---------------------------"
  echo "Available hosts  : $available"
  echo "Unavailable hosts: $unavailable"
}  >> "$outfile"

echo "Ready, check the file $outfile"
