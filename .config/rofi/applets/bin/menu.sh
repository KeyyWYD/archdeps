 #!/usr/bin/env bash

## Arch menu

# Set shared path
dir="$HOME"/.config/rofi/applets/shared/

# Grid Settings
list_col='1'
list_row='6'

# Elements
prompt='Applications'
mesg="Installed Packages : `pacman -Q | wc -l` (pacman)"

# CMDs (add your apps here)
term_cmd='alacritty'
file_cmd='dolphin'
web_cmd='firefox'
music_cmd='spotify'
setting_cmd='xfce4-settings-manager'
power_cmd="$HOME"/.config/rofi/applets/bin/powermenu.sh

# Options
option_1=""
option_2=""
option_3=""
option_4=""
option_5=""
option_6=""

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "window {fullscreen: false; location: west; anchor: west; width: 80px; x-offset: 4px; y-offset: 0px; margin: 0px; padding: 0px; border: 0px solid; border-radius: 10px;}" \
    -theme-str "mainbox {enabled: true; spacing: 15px;  margin: 0px; padding: 15px; background-color: transparent; children: [ "listview" ];}" \
    -theme-str "listview {columns: $list_col; lines: $list_row; cycle: true; scrollbar: false; layout: vertical; spacing: 15px;}" \
    -theme-str "textbox-prompt-colon {str: '';}" \
    -theme-str "element {padding: 10px 10px;}" \
    -theme-str "element-text {font: 'feather 16'; vertical-align: 0.5; horizontal-align: 0.5;}" \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme ${dir}/config.rasi
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6" | rofi_cmd
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		${term_cmd}
	elif [[ "$1" == '--opt2' ]]; then
		${file_cmd}
	elif [[ "$1" == '--opt3' ]]; then
		${web_cmd}
	elif [[ "$1" == '--opt4' ]]; then
		${music_cmd}
	elif [[ "$1" == '--opt5' ]]; then
		${setting_cmd}
  elif [[ "$1" == '--opt6' ]]; then
		bash ${power_cmd}
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		run_cmd --opt1
        ;;
    $option_2)
		run_cmd --opt2
        ;;
    $option_3)
		run_cmd --opt3
        ;;
    $option_4)
		run_cmd --opt4
        ;;
    $option_5)
		run_cmd --opt5
        ;;
    $option_6)
		run_cmd --opt6
        ;;
esac
