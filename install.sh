#!/usr/bin/env bash
#-------------------------------------------------------------------------
#  Arch Linux Post Install ( Hyprland )
#-------------------------------------------------------------------------

sudo pacman -Syu

echo '  _____    __  __  _____  _      __    __   _____    __  ___ '
echo '  \_   \/\ \ \/ _\/__   \/_\    / /   / /   \_   \/\ \ \/ _ \'
echo '   / /\/  \/ /\ \   / /\//_\\\  / /   / /     / /\/  \/ / /_\/'
echo '/\/ /_/ /\  / _\ \ / / /  _  \/ /___/ /___/\/ /_/ /\  / /_\\ '
echo '\____/\_\ \/  \__/ \/  \_/ \_/\____/\____/\____/\_\ \/____/ '
echo NECESSARY COMPONENTS

echo Installing yay . . .

mkdir -p "$HOME"/tmp/
cd "$HOME"/tmp/
git clone 'https://aur.archlinux.org/yay.git'
cd yay && makepkg -si
cd "$HOME"
rm -rf tmp/yay
yay --version


base_PKGS=(

      # TERMINAL UTILITIES --------------------------------------------------

       'alacritty'
       'fd'
       'fzf'
       'thefuck'
       'zoxide'
       'zsh'

      # NETWORK UTILITIES ---------------------------------------------------

      'ldns'

      # AUDIO UTILITIES -----------------------------------------------------

      'alsa-utils'
      'alsa-plugins'
      'pavucontrol'
      'pipewire'
      'pipewire-alsa'
      'pipewire-pulse'
      'wireplumber'

      # POWER MGMT ----------------------------------------------------------

      'thermald'

      # GENERAL UTILITIES ---------------------------------------------------

      'mesa-utils'
      'brightnessctl'
      'xdg-desktop-portal-hyprland'
      'xdg-user-dirs'
      'hyprland'
      'polkit-kde-agent'
      'rofi-wayland'
      'swappy'
      'swaync'
      'swaybg'
      'stow'
      'wayshot'
      'waybar'
      'wl-clipboard'
      'wf-recorder'

      # Fonts ---------------------------------------------------------------

       'noto-fonts'
       'ttf-nerd-fonts-symbols'
       'ttf-nerd-fonts-symbols-common'
       'ttf-cascadia-code-nerd'
       'ttf-jetbrains-mono-nerd'
       'ttf-mononoki-nerd'
       'ttf-dejavu'
       'ttf-fira-code'
       'ttf-firacode-nerd'
       'ttf-font-awesome'

      # DEVELOPMENT ---------------------------------------------------------

       'github-cli'
       'cmake'

      # MULTIMEDIA ----------------------------------------------------------

       'firefox'
       'discord'
       'spotify-launcher'
)

yay_PKGS=(
    'matugen-bin'
    'sddm-git'
)

for pPKG in "${base_PKGS[@]}"; do
    echo "INSTALLING ${pPKG}"
    sudo pacman -S "$pPKG" --noconfirm --needed
done

for yPKG in "${yay_PKGS[@]}"; do
    echo "INSTALLING ${yPKG}"
    yay -S "$yPKG"
done

systemctl --user --now enable pipewire pipewire-pulse pipewire-pulse.socket wireplumber

echo
echo
echo '▓█████▄  ▒█████   ███▄    █ ▓█████ '
echo '▒██▀ ██▌▒██▒  ██▒ ██ ▀█   █ ▓█   ▀ '
echo '░██   █▌▒██░  ██▒▓██  ▀█ ██▒▒███   '
echo '░▓█▄   ▌▒██   ██░▓██▒  ▐▌██▒▒▓█  ▄ '
echo '░▒████▓ ░ ████▓▒░▒██░   ▓██░░▒████▒'
echo ' ▒▒▓  ▒ ░ ▒░▒░▒░ ░ ▒░   ▒ ▒ ░░ ▒░ ░'
echo ' ░ ▒  ▒   ░ ▒ ▒░ ░ ░░   ░ ▒░ ░ ░  ░'
echo ' ░ ░  ░ ░ ░ ░ ▒     ░   ░ ░    ░   '
echo '   ░        ░ ░           ░    ░  ░'
echo ' ░                                 '
echo '---- Restart to apply changes -----'



