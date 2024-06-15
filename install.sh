#!/usr/bin/env bash
#
#
# Arch Post Install Script

cat << "EOF"
                                                  ,
                .          ,-.       _,---._ __  / \
               / \        /  )    .-'       `./ /   \
              /   \      (  (   ,'            `/    /|
             /     \      \  `-"             \'\   / |
            /.      \      `.              ,  \ \ /  |
           ,_ `.     \      /`.          ,'-`----Y   |
          /   ``-     .    (            ;        |   '
         /             `   |  ,-.    ,-'         |  /
        /               `. |  | (   |            | /
      .`      ."`".       \   |  \  `.___________|/
     .       '     \       \ -'   `--'
    /        \      ;     -.\
   /        .'     /._     `".
  /   .-"`             `"-.   `.
.`.-`                       `-._\
`                               `

EOF

#-------------------
# check for updates
#-------------------
sudo pacman -Syu

cat << "EOF"

              ┳      ┓┓•
              ┃┏┓┏╋┏┓┃┃┓┏┓┏┓
              ┻┛┗┛┗┗┻┗┗┗┛┗┗┫
                           ┛ NECESSARY COMPONENTS

INSTALLING yay
EOF

mkdir -p "$HOME"/tmp/
cd "$HOME"/tmp/
git clone 'https://aur.archlinux.org/yay.git'
cd yay && makepkg -si
cd "$HOME"
rm -rf tmp/yay
yay --version

base_PKGS=(

      # SYSTEM --------------------------------------------------------------
       'pipewire'                          # audio/video server
       'pipewire-alsa'                     # pipewire alsa client
       'pipewire-audio'                    # pipewire audio client
       'pipewire-pulse'                    # pipewire pulseaudio client
       'wireplumber'                       # pipewire session manager
       'pavucontrol'                       # pulseaudio volume control
       'brightnessctl'                     # screen brightness control
       'udiskie'                           # manage removable media
       'ldns'                              # DNS library
       'thermald'                          # cpu temp monitor (Intel)

      # DISPLAY MANAGER -----------------------------------------------------
       'qt5-quickcontrols'                 # for sddm theme ui elements
       'qt5-quickcontrols2'                # for sddm theme ui elements
       'qt5-graphicaleffects'              # for sddm theme effects

      # WINODW MANAGER ------------------------------------------------------
       'hyprland'                          # wlroots-based wayland compositor
       'rofi-wayland'                      # application launcher
       'swappy'                            # snapshot editing tool
       'swaync'                            # notification daemon
       'swaybg'                            # wallpaper
       'waybar'                            # system bar
       'wl-clipboard'                      # cli copy/paste utilities
       'wf-recorder'                       # screen recording tool

      # DEPENDENCIES --------------------------------------------------------
       'polkit-kde-agent'                  # authentication agent
       'xdg-desktop-portal-hyprland'       # xdg desktop portal for hyprland
       'qt5-imageformats'                  # for dolphin image thumbnails
       'ffmpegthumbs'                      # for dolphin video thumbnails
       'mesa-utils'                        # opengl gfx library
       'xdg-user-dirs'                     # user folders
       'stow'                              # symlink farm manager

      # THEMING -------------------------------------------------------------
       'qt5-wayland'                       # wayland support in qt5
       'qt6-wayland'                       # wayland support in qt6

      # SHELL ---------------------------------------------------------------
       'zsh'                               # shell
       'fd'                                # filesystem entry finder
       'fzf'                               # command-line fuzzy finder
       'thefuck'                           # corrects previous console command
       'zoxide'                            # smarter cd command

      # FONTS ---------------------------------------------------------------
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

      # APPLICATIONS --------------------------------------------------------
       'alacritty'                         # terminal
       'dolphin'                           # kde file manger
       'ark'                               # kde file archiver
       'firefox'                           # browser
       'discord'                           # messaging
       'spotify-launcher'                  # music player
       'github-cli'                        # github command line tool
       'cmake'
)

yay_PKGS=(
       'auto-cpufreq'
       'matugen-bin'
       'sddm-git'
       'wayshot-bin'
)

for pPKG in "${base_PKGS[@]}"; do
    echo
    echo "INSTALLING ${pPKG}"
    sudo pacman -S "$pPKG" --noconfirm --needed
done

for yPKG in "${yay_PKGS[@]}"; do
    echo
    echo "INSTALLING ${yPKG}"
    yay -S "$yPKG"
done

cat << "EOF"

                   ┏•      •             •
              ┏┏┓┏┓╋┓┏┓┓┏┏┓┓┏┓┏┓  ┏┏┓┏┓┓┏┓┏┏┓┏
              ┗┗┛┛┗┛┗┗┫┗┻┛ ┗┛┗┗┫  ┛┗ ┛ ┗┛┗┗┗ ┛
                      ┛        ┛

EOF

sudo auto-cpufreq --install
systemctl --user --now enable pipewire pipewire-pulse pipewire-pulse.socket wireplumber
systemctl enable thermald auto-cpufreq sddm

cat << "EOF"


              ▓█████▄  ▒█████   ███▄    █ ▓█████
              ▒██▀ ██▌▒██▒  ██▒ ██ ▀█   █ ▓█   ▀
              ░██   █▌▒██░  ██▒▓██  ▀█ ██▒▒███
              ░▓█▄   ▌▒██   ██░▓██▒  ▐▌██▒▒▓█  ▄
              ░▒████▓ ░ ████▓▒░▒██░   ▓██░░▒████▒
               ▒▒▓  ▒ ░ ▒░▒░▒░ ░ ▒░   ▒ ▒ ░░ ▒░ ░
               ░ ▒  ▒   ░ ▒ ▒░ ░ ░░   ░ ▒░ ░ ░  ░
               ░ ░  ░ ░ ░ ░ ▒     ░   ░ ░    ░
                 ░        ░ ░           ░    ░  ░
               ░
              ----- Restart to apply changes -----


EOF

