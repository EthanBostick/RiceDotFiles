#!/bin/bash

# --terse makes the output easy to read (e.g., "VCP 10 C 50 100")
# awk '{print $4}' grabs just the 4th word, which is the current brightness.
brightness=$(ddcutil getvcp 10 --terse 2>/dev/null | awk '{print $4}')

# If we successfully got a number, print it. Otherwise, print an error icon.
if [ -n "$brightness" ]; then
    echo "$brightness%"
else
    echo "---"
fi
