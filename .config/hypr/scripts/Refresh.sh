#!/bin/bash

# Original Author: JaKooLit
# Script for refreshing programs

# Kill already running processes
_ps=(waybar rofi dunst)
for _prs in "${_ps[@]}"; do
    if pidof "${_prs}" >/dev/null; then
        pkill "${_prs}"
    fi
done

# Relaunch Programs
sleep 0.2
waybar &

sleep 0.5
dunst > /dev/null 2>&1 &

exit 0