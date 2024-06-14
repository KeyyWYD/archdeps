#!/usr/bin/env bash
#-------------------------------------------------------------------------
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

echo
echo "INSTALLING NECESSARY COMPONENTS"
echo

base_PKGS=(

      # TERMINAL UTILITIES --------------------------------------------------

      'alacritty'
      'zsh'
      'fzf'
      'thefuck'
      'zoxide'
      # 'starship'

      # NETWORK UTILITIES ---------------------------------------------------

       # 'wpa_supplicant'
       # 'dialog'
      'networkmanager'
      'network-manager-applet'
       # 'libsecret'
      'ldns'

      # AUDIO UTILITIES -----------------------------------------------------

      'alsa-utils'
      'alsa-plugins'
      'pipewire'
      'pipewire-alsa'
      'pipewire-pulse'
       # 'pipewire-jack'
      'wireplumber'
      'pavucontrol'
      'volumeicon'

      # POWER MGMT ----------------------------------------------------------

      'thermald'

      # GENERAL UTILITIES ---------------------------------------------------

      'mesa-utils'
      'brightnessctl'
      'xdg-desktop-portal-hyprland'
      'xdg-user-dirs'
      'hyprland'
      'polkit-gnome'
       # 'gnome-control-center'
      'waybar'
       # 'playerctl'
       # 'udiskie'
      'swaybg'
       # 'dunst'
      'stow'

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

      'git'
      'github-cli'
      'cmake'
       # 'gcc'
      
      # MULTIMEDIA ----------------------------------------------------------

      'firefox'
      'discord'
      'spotify-launcher'
)

for PKG in "${base_PKGS[@]}"; do
    echo "INSTALLING ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

systemctl --user --now enable pipewire pipewire-pulse pipewire-pulse.socket wireplumber

echo
echo "Done!"
echo
