#!/bin/bash
cd "~/$(dirname \"$0\")"
find / -user $UID -type f | while read fn; do head -n1 "$fn" | grep -q "#!.*/bin/bash" && cat \"~/$0\"; done