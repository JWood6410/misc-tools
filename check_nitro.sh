#!/bin/bash
# This script performs two checks to see if a server is ready for Nitro instances.
# First, it checks to see if the server has a UUID in /etc/fstab.
# Second, it checks to see if the server is using the ena driver.

while IFS= read -r line; do
  fs=$(echo "$line" | awk '{print $3}')
#  echo $fs

  if [[ $line != \#* && ($fs == "ext3" || $fs == "ext4" || $fs == "xfs") && ! $line == UUID* ]]; then
    echo "Error: $line does not start with UUID"
    exit 1
  else
    echo "Pass: $line starts with UUID"
  fi
done < /etc/fstab

output=$(ethtool -i eth0)

if echo "$output" | grep -q "ena"; then
  echo "eth0 is using the ena driver"
else
  echo "eth0 is not using the ena driver"
  exit 1
fi