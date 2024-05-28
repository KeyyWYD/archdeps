#!/bin/bash
# All dependencies

sudo ()
{
    [[ $EUID = 0 ]] || set -- command sudo "$@"
    "$@"
}

sudo pacman -Sy &&
# Main Packages
sudo pacman -S alsa-firmware \
    alsa-utils \
    thermald \
    tlp \
    stow \
    zsh \
    thefuck \
    zoxide \
    playerctl \
    inotify-tools \
    hyprland xdg-desktop-portal-hyprland \
    polkit-gnome \
    rofi-wayland \
    udiskie \
    waybar \
    mako \
    alacritty \
    starship \
    xdg-user-dirs \
    ttf-cascadia-code-nerd \
    ttf-mononoki-nerd --noconfirm &&

git clone https://aur.archlinux.org/yay.git ~/Downloads/yay
cd ~/Downloads/yay
makepkg -si

yay -S --noconfirm swww &&
yay -S --noconfirm fluent-gtk-theme &&
yay -S --noconfirm bibata-cursor-theme-bin &&

mv ~/.zshrc ~/.zshrc_old


