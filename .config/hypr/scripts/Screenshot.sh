#!/bin/bash

# Screenshot script
# TODO: SS to Clipboard & icons

sDIR="$HOME/.config/hypr/scripts"
ssDIR="$(xdg-user-dir PICTURES)/Screenshots"
file="$ssDIR/$(date '+%Y-%m-%d_%H-%M-%S').png"

fullscreen() {
    wayshot -f "$file"
    notify-send -u low "Screenshot Saved" "$file"
    "$sDIR/Sounds.sh" --screenshot
    swappy -f "$file"
}

region() {
    wayshot -s "$(slurp)" -f "$file"
    notify-send -u low "Screenshot Saved" "$file"
    "$sDIR/Sounds.sh" --screenshot
    swappy -f "$file"
}

if [[ "$1" == "--selection" ]]; then
    region
elif [[ "$1" == "--full" ]]; then
    fullscreen
else
    wayshot --stdout | wl-copy
fi
