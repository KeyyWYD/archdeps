#!/bin/bash

# Original Author: JaKooLit
# This script for selecting wallpapers (SUPER SHIFT W)
# MODIFIED to generate a blurred wallpaper

# File and folder names
wallDIR="$HOME/Pictures/Wallpapers"
SCRIPTSDIR="$HOME/.config/hypr/scripts"
wltmp="$HOME/.cache/swww/tmp.png"
blurred_wp="$HOME/.cache/swww/wp_blurred.png"
focused_monitor=$(hyprctl monitors | awk '/^Monitor/{name=$2} /focused: yes/{print name}')

# Variables
blur="50x30"
FPS=60
TYPE="any"
DURATION=2
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION"

# Check if swaybg is running
if pidof swaybg > /dev/null; then
  pkill swaybg
fi

# Retrieve image files
PICS=($(find "${wallDIR}" -type f \( -iname \*.jpg -o -iname \*.jpeg -o -iname \*.png -o -iname \*.gif \)))
RANDOM_PIC="${PICS[$((RANDOM % ${#PICS[@]}))]}"
RANDOM_PIC_NAME=".random"

# Rofi command
rofi_command="rofi -i -show -dmenu -config ~/.config/rofi/config-wallpaper.rasi"


# Sorting Wallpapers
menu() {
  sorted_options=($(printf '%s\n' "${PICS[@]}" | sort))
  # Place ". random" at the beginning
  printf "%s\n" "$RANDOM_PIC_NAME"
  for pic_path in "${sorted_options[@]}"; do
    pic_name=$(basename "$pic_path")
    # Displaying .gif to indicate animated images
    if [[ -z $(echo "$pic_name" | grep -i "\.gif$") ]]; then
      printf "%s\x00icon\x1f%s\n" "$(echo "$pic_name" | cut -d. -f1)" "$pic_path"
    else
      printf "%s\n" "$pic_name"
    fi
  done
}

# initiate swww if not running
swww query || swww-daemon --format xrgb

# Choice of wallpapers
main() {
  choice=$(menu | ${rofi_command})
  # No choice case
  if [[ -z $choice ]]; then
    exit 0
  fi

  # Random choice case
  if [ "$choice" = "$RANDOM_PIC_NAME" ]; then
    RANDOM_PIC="${PICS[$((RANDOM % ${#PICS[@]}))]}"
    swww img -o $focused_monitor "${RANDOM_PIC}" $SWWW_PARAMS
    exit 0
  fi

  # Find the index of the selected file
  pic_index=-1
  for i in "${!PICS[@]}"; do
    filename=$(basename "${PICS[$i]}")
    if [[ "$filename" == "$choice"* ]]; then
      pic_index=$i
      break
    fi
  done

  if [[ $pic_index -ne -1 ]]; then
    swww img -o $focused_monitor "${PICS[$pic_index]}" $SWWW_PARAMS
  else
    echo "Image not found."
    exit 1
  fi

  cp "${PICS[$pic_index]}" $wltmp
  magick $wltmp -resize 75%\! $wltmp
  echo ":: Resized to 75%"
  if [ ! "$blur" == "0x0" ] ; then
    magick $wltmp -blur $blur $blurred_wp
    rm -rf $wltmp
    echo ":: Blurred"
  fi

}

# Check programs
if pidof rofi > /dev/null; then
  pkill rofi
  exit 0
fi

if pidof dunst > /dev/null; then
  pkill dunst
  exit 0
fi

main

sleep 0.5
${SCRIPTSDIR}/WallustSww.sh
${SCRIPTSDIR}/Refresh.sh