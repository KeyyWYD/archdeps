#!/bin/bash

sudo ()
{
    [[ $EUID = 0 ]] || set -- command sudo "$@"
    "$@"
}


# Dependencies & Important software
sudo pacman -Sy &&
sudo pacman -S stow \
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
	kitty \
 	fastfetch \
  	starship \
	ttf-mononoki-nerd --noconfirm &&

git clone https://aur.archlinux.org/swww.git ~/swww &&
cd ~/swww &&
makepkg -si --noconfirm &&
cd ../ &&
rm -rf ~/swww &&

git clone https://aur.archlinux.org/fluent-gtk-theme.git ~/fluent-gtk-theme &&
cd ~/fluent-gtk-theme &&
makepkg -si --noconfirm &&
cd ../ &&
rm -rf ~/fluent-gtk-theme &&

git clone https://aur.archlinux.org/bibata-cursor-theme-bin.git ~/bibata-cursor-theme &&
cd ~/bibata-cursor-theme &&
makepkg -si --noconfirm &&
cd ../ &&
rm -rf ~/bibata-cursor-theme &&

if [ "$(whoami)" != "build" ]; then
	chsh -s $(which zsh) $(whoami)
fi &&

mv ~/.zshrc ~/.zshrc_old


