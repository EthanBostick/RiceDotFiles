#!/bin/bash

# 1. Grab the active connection (ignoring the internal loopback)
ACTIVE_CONN=$(nmcli -t -f ACTIVE,NAME,TYPE connection show | grep '^yes' | grep -v ':loopback' | head -n 1)
NAME=$(echo "$ACTIVE_CONN" | cut -d: -f2)
TYPE=$(echo "$ACTIVE_CONN" | cut -d: -f3)

# 2. Check if offline
if [ -z "$NAME" ]; then
    echo "%{F#66ffffff}%{T2}󰖪%{T-} Offline"
    exit 0
fi

# 3. If Ethernet: Do the speed math using the dynamic $NAME
if [[ "$TYPE" == *"ethernet"* ]]; then
    CONFIG_SPEED=$(nmcli -g 802-3-ethernet.speed connection show "$NAME" 2>/dev/null | tr -d '\n ')
    
    if [ "$CONFIG_SPEED" = "100" ]; then
        SPEED="100Mb/s"
    else
        SPEED="1Gb/s"
    fi
    
    echo "%{T2}󰈀%{T-} (${SPEED}) ${NAME}"

# 4. If Wi-Fi: Just show the name (no ethernet speed math required)
else
    echo "%{T2}󰖩%{T-} ${NAME}"
fi
