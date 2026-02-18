#!/bin/bash

# Options
options="  Shutdown\n󰜉  Reboot\n󰤄  Suspend\n󰗽  Logout"

# Get user choice via Rofi
chosen="$(echo -e "$options" | rofi -dmenu -i -p "Power Menu:" -theme-str 'window {width: 15%;}')"

# Execute based on choice
case $chosen in
    *Shutdown)
        systemctl poweroff ;;
    *Reboot)
        systemctl reboot ;;
    *Suspend)
        systemctl suspend ;;
    *Logout)
        i3-msg exit ;;
esac
