#!/usr/bin/env bash
#
#
# Arch Post Install Script

cat << "EOF"
                                                 ,
                .         ,-.       _,---._ __  / \
               / \       /  )    .-'       `./ /   \
              /   \     (  (   ,'            `/    /|
             /     \     \  `-"             \'\   / |
            /.      \     `.              ,  \ \ /  |
           ,_ `.     \     /`.          ,'-`----Y   |
          /   ``-     .   (            ;        |   '
         /             `  |  ,-.    ,-'         |  /
        /               `.|  | (   |            | /
      .`      ."`".       \  |  \  `.___________|/
     .       '     \       \-'   `--'
    /        \      ;     -.\
   /        .'     /._     `".
  /   .-"`             `"-.   `.
.`.-`                       `-._\
`                               `

EOF

# check for system updates
sudo pacman -Syu

cat << "EOF"

              ┳      ┓┓•
              ┃┏┓┏╋┏┓┃┃┓┏┓┏┓
              ┻┛┗┛┗┗┻┗┗┗┛┗┗┫
                           ┛ NECESSARY COMPONENTS

EOF

# Function to install an AUR helper
install_aur() {
    choice=$1
    case $choice in
        1)
            mkdir -p "$HOME"/tmp/
            cd "$HOME"/tmp/ || exit 1
            git clone 'https://aur.archlinux.org/yay.git'
            cd yay && makepkg -si --noconfirm
            cd "$HOME" && rm -rf tmp/
            yay --version
            ;;
        2)
            mkdir -p "$HOME"/tmp/
            cd "$HOME"/tmp/ || exit 1
            git clone 'https://aur.archlinux.org/paru.git'
            cd paru && makepkg -si --noconfirm
            cd "$HOME" && rm -rf tmp/
            ;;
    esac
}

# Function to check if yay or paru is installed
check_aur() {
    if command -v yay &> /dev/null; then
        AUR_HELPER="yay"
        echo "yay is already installed -- skipping"
    elif command -v paru &> /dev/null; then
        AUR_HELPER="paru"
        echo "paru is already installed -- skipping"
    else
        echo "No AUR helpers found."

        # Display menu and get user input
        echo ":: There are 2 available AUR helpers:"
        echo "   1) yay  2) paru"
        echo

        while true; do
            read -p "Enter a number (default=1): " user_choice

            # If user input is empty, default to option 1
            if [ -z "$user_choice" ]; then
                user_choice=1
            fi

            # Check if the input is a valid choice (1 or 2)
            if [ "$user_choice" = "1" ] || [ "$user_choice" = "2" ]; then
                break  # Exit the loop if valid choice is made
            else
                echo "Invalid choice"
            fi
        done

        # Call function to install AUR helper
        install_aur "$user_choice"
    fi
}

# Call the check_aur to check for AUR helpers
check_aur

# AUR packages to install
aur_PKGS=(
    'auto-cpufreq'      # Automatic CPU frequency scaling tool
    'cava'              # Audio Visualizer
    'sddm-git'          # Display manager (SDDM) from Git
    'slurp'
    'wallust-git'
    'wayshot'       # Screenshot utility
    'wlogout'
    'apple-fonts'       # Apple fonts
)

# Base packages to install
base_PKGS=(
    # SYSTEM --------------------------------------------------------------
    'pipewire'                  # Audio/video server
    'pipewire-alsa'             # PipeWire ALSA client
    'pipewire-audio'            # PipeWire audio client
    'pipewire-pulse'            # PipeWire PulseAudio client
    'wireplumber'               # PipeWire session manager
    'pavucontrol'               # PulseAudio volume control
    'brightnessctl'             # Screen brightness control
    'udiskie'                   # Manage removable media
    'ldns'                      # DNS library
    'thermald'                  # CPU temperature monitor (Intel)

    # DISPLAY MANAGER -----------------------------------------------------
    'qt5-quickcontrols'         # Qt5 controls for SDDM theme UI elements
    'qt5-quickcontrols2'        # Qt5 controls for SDDM theme UI elements
    'qt5-graphicaleffects'      # Qt5 graphical effects for SDDM theme

    # WINDOW MANAGER ------------------------------------------------------
    'hyprland'                  # wlroots-based Wayland compositor
    'hyprlock'
    'hypridle'
    'dunst'                     # Notification daemon
    'rofi-wayland'              # Application launcher for Wayland
    'swappy'                    # Screenshot editing tool
    'sww'                       # Wallpaper
    'waybar'                    # System status bar for Sway
    'wl-clipboard'              # CLI copy/paste utilities for Wayland
    'wf-recorder'               # Screen recording tool for Wayland

    # DEPENDENCIES --------------------------------------------------------
    'imagemagick'
    'polkit-kde-agent'          # Authentication agent for KDE
    'xdg-desktop-portal-hyprland'   # XDG Desktop Portal for Hyprland
    'qt5-imageformats'          # Qt5 image format plugins for Dolphin
    'ffmpegthumbs'              # Dolphin video thumbnail generator
    'mesa-utils'                # OpenGL graphics library utilities
    'xdg-user-dirs'             # Manage user directories
    'stow'                      # Symlink farm manager

    # THEMING -------------------------------------------------------------
    'qt5-wayland'               # Wayland support in Qt5
    'qt6-wayland'               # Wayland support in Qt6

    # SHELL ---------------------------------------------------------------
    'zsh'                       # Shell
    'fd'                        # Filesystem entry finder
    'fzf'                       # Command-line fuzzy finder
    'thefuck'                   # Corrects previous console command
    'zoxide'                    # Smarter `cd` command
    'eza'                       # File lister

    # FONTS ---------------------------------------------------------------
    'noto-fonts'                # Google Noto fonts
    'ttf-nerd-fonts-symbols'    # Nerd Fonts - Iconic font patches
    'ttf-nerd-fonts-symbols-common'    # Common Nerd Fonts - Iconic font patches
    'ttf-cascadia-code-nerd'    # Nerd Fonts Cascadia Code
    'ttf-jetbrains-mono-nerd'   # Nerd Fonts JetBrains Mono
    'ttf-mononoki-nerd'         # Nerd Fonts Mononoki
    'ttf-dejavu'                # DejaVu fonts
    'ttf-fira-code'             # Fira Code fonts
    'ttf-firacode-nerd'         # Nerd Fonts Fira Code
    'ttf-font-awesome'          # Font Awesome icons
    'ttf-iosevka-nerd'          # Nerd Fonts Iosevka

    # APPLICATIONS --------------------------------------------------------
    'alacritty'                 # Terminal emulator
    'dolphin'                   # KDE file manager
    'ark'                       # KDE file archiver
    'firefox'                   # Web browser
    'discord'                   # Messaging platform
    'spotify-launcher'          # Spotify launcher
    'github-cli'                # GitHub command line tool
    'cmake'                     # Cross-platform build system
)

for pPKG in "${base_PKGS[@]}"; do
    echo
    echo "INSTALLING ${pPKG}..."
    sudo pacman -S "$pPKG" --noconfirm --needed
done

for aPKG in "${aur_PKGS[@]}"; do
    echo
    echo "INSTALLING ${aPKG}..."
    $AUR_HELPER -S "$aPKG"
done

cp -r Pictures "$HOME"

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
              ----- Reboot to apply changes -----


EOF

