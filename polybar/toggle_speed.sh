#!/bin/bash

# 1. Grab the active connection using the exact same logic as your display script
ACTIVE_CONN=$(nmcli -t -f ACTIVE,NAME,TYPE connection show | grep '^yes' | grep -v ':loopback' | head -n 1)
CON_NAME=$(echo "$ACTIVE_CONN" | cut -d: -f2)
TYPE=$(echo "$ACTIVE_CONN" | cut -d: -f3)

# 2. Safety check: Ensure we are online AND it's an Ethernet connection
if [ -z "$CON_NAME" ] || [[ "$TYPE" != *"ethernet"* ]]; then
    notify-send "Network" "No active Ethernet connection to toggle!" -u critical
    exit 1
fi

# 3. Check current configured speed directly from NetworkManager
CURRENT_SPEED=$(nmcli -g 802-3-ethernet.speed connection show "$CON_NAME" 2>/dev/null | tr -d '\n ')

# 4. Toggle Logic
if [ "$CURRENT_SPEED" = "100" ]; then
    # Currently 100 -> SWITCH TO HOME MODE (Fully Auto)
    nmcli connection modify "$CON_NAME" 802-3-ethernet.auto-negotiate yes 802-3-ethernet.speed 0
    nmcli connection modify "$CON_NAME" remove 802-3-ethernet.duplex
    notify-send "Network" "HOME MODE: Auto-Negotiate (Gigabit)" -u normal
else
    # Currently Auto/1000 -> SWITCH TO SCHOOL MODE (Polite 100Mbps)
    nmcli connection modify "$CON_NAME" 802-3-ethernet.auto-negotiate yes 802-3-ethernet.speed 100 802-3-ethernet.duplex full
    notify-send "Network" "SCHOOL MODE: Polite 100Mbps" -u normal
fi

# 5. Apply gracefully over the active link
nmcli connection up "$CON_NAME"
