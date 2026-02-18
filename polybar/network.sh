#!/bin/bash

# Get the name of the active connection from NetworkManager
# This will return things like "Wired connection 1" or your Wi-Fi name
NAME=$(nmcli -t -f ACTIVE,NAME,TYPE connection show | grep '^yes' | cut -d: -f2)
TYPE=$(nmcli -t -f ACTIVE,NAME,TYPE connection show | grep '^yes' | cut -d: -f3)

if [ -z "$NAME" ]; then
    # Offline state
    echo "%{F#66ffffff}%{T2}󰖪%{T-} Offline"
elif [[ "$TYPE" == *"ethernet"* ]]; then
    # Ethernet icon + Name (e.g., 󰈀 Wired)
    echo "%{T2}󰈀%{T-} ${NAME}"
else
    # Wi-Fi icon + Name (e.g., 󰖩 MyHomeWifi)
    echo "%{T2}󰖩%{T-} ${NAME}"
fi
