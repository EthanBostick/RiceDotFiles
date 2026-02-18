#!/bin/sh
# Check if bluetooth is powered on
if [ $(bluetoothctl show | grep "Powered: yes" | wc -l) -eq 0 ]; then
  # %{T2} starts Font 2, %{T-} resets to default
  echo "%{F#66ffffff}%{T2}󰂲%{T-}" 
  exit 0
fi

# Get the name of the connected device
device=$(bluetoothctl info | grep "Name" | cut -d ' ' -f 2-)

if [ -z "$device" ]; then
  echo "%{T2}󰂯%{T-}" 
else
  # Get battery percentage
  battery=$(bluetoothctl info | grep "Battery Percentage" | awk -F '[()]' '{print $2}')
  if [ -z "$battery" ]; then
    echo "%{T2}󰂰%{T-} $device" 
  else
    echo "%{T2}󰂯%{T-} $device ($battery%)" 
  fi
fi
