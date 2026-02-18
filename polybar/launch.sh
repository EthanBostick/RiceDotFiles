#!/usr/bin/env bash

# 1. Kill already running bar instances and old hider scripts
killall -q polybar
pkill -f hide_polybar.py

# 2. Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# 3. Launch Polybar
echo "---" | tee -a /tmp/polybar.log
polybar example 2>&1 | tee -a /tmp/polybar.log & disown

# 4. Launch the hider script
# We use 'python3' followed by the full path to the script
python3 ~/.config/polybar/hide_polybar.py &
