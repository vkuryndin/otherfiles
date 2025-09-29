#!/bin/bash
# the script will fail if error and show the error
set -euo pipefail

# correct sorting
export LC_ALL=C

echo "fourth conveyor"

(find /var/log -type f -name '*.log' -readable -exec grep -h --text -E 'WARNING' {} + || true) \
| grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' || true \
| awk -F. '($1<=255 && $2<=255 && $3<=255 && $4<=255)'\
| sort \
| uniq \
> unique_warnings_ips.txt

if [[ ! -s unique_warnings_ips.txt ]]; then
  echo "No warning lines with valid IPs found" > unique_warnings_ips.txt
fi

echo "Ready, check the file unique_warnings_ips.txt"

