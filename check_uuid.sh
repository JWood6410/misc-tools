#!/bin/bash

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