#!/usr/bin/env bash
#-------------------------------------------------------------------------
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

echo
echo "INSTALLING NECESSARY COMPONENTS"
echo

base_PKGS=(

      # MICROCODE -----------------------------------------------------------

      # 'amd-ucode'
      'intel-ucode'

      # TERMINAL UTILITIES --------------------------------------------------

      'alacritty'
      'bash-completion'
      'zsh'
      'thefuck'
      'zoxide'
      'starship'

      # NETWORK UTILITIES ---------------------------------------------------

      'wpa_supplicant'
      'dialog'
      'networkmanager'
      'network-manager-applet'
      'dhclient'
      'libsecret'
      'ldns'

      # AUDIO UTILITIES -----------------------------------------------------

      'alsa-utils'
      'alsa-plugins'
      'pipewire'
      'pipewire-alsa'
      'pipewire-pulse'
      'pipewire-jack'
      'wireplumber'
      'pavucontrol'
      'volumeicon'

      # POWER MGMT ----------------------------------------------------------

      'auto-cpufreq'
      'thermald'

      # GENERAL UTILITIES ---------------------------------------------------

      'mesa-utils'
      'brightnessctl'
      'xdg-desktop-portal-hyprland'
      'hyprland'
      'polkit-gnome'
      'waybar'
      'swaybg'
      'playerctl'
      'udiskie'
      'mako'
      'noto-fonts'
      'ttf-nerd-fonts-symbols'
      'ttf-cascadia-code-nerd'
      'ttf-jetbrains-mono-nerd'
      'ttf-firacode-nerd'
      'ttf-mononoki-nerd'

      # DEVELOPMENT ---------------------------------------------------------

      'git'
      'github-cli'
      'cmake'
      'gcc'

      # MULTIMEDIA ----------------------------------------------------------

      'firefox'
      'discord'
      'spotify-launcher'
)

for PKG in "${base_PKGS[@]}"; do
    echo "INSTALLING ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo
echo "Done!"
echo