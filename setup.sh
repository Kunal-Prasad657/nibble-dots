#!/bin/bash

# -----------------------------------------------------------------------------
# This script installs various packages, updates the system, copies
# configuration files (dotfiles), and sets up user preferences on an Arch-based
# system using Yay as the AUR helper.
# SCRIPTED BY: notdanna
# -----------------------------------------------------------------------------

# List of packages to install with Yay
install_packages_yay=(
    kitty
    hyprland
    waybar
    hyprshot
    hyprpicker
    grim
    slurp
    nautilus
    pamixer
    pavucontrol
    brightnessctl
    zsh
    lsd
    zsh-syntax-highlighting
    zsh-autosuggestions
    neovim
    wget
    unzip
    gtk3
    imagemagick
    rust
    zen-browser-bin
    wf-recorder
    rofi
    swww
    vesktop
    cliphist
    keyd
    ttf-jetbrains-mono-nerd
    hyprpicker
    rofi-calc
    rofimoji
    tmux
    adwaita-colors-icon-theme
    spicetify-cli
    swaync-git
    swaync-widgets-git
    gnome-tweaks
    python-pywal
    matugen-bin
    mpv
)

# Installation log file
INSTLOG="install.log"

function present() {
    # Array of characters to animate
    local array=(
        "\040b"
        "y\040"
        "d"
        "a"
        "n"
        "n"
        "a"
        "l"
        "^"
        "^\n"
    )

    # Print each character with a short delay
    for letter in "${array[@]}"; do
        echo -en "\e[95m${letter}\e[0m"
        sleep 0.2
    done
}

# -----------------------------------------------------------------------------
# show_progress: Displays progress dots while a background process (pid) is running
# -----------------------------------------------------------------------------
function show_progress() {
    # Wait until the process with PID $1 finishes
    while ps -p "$1" &> /dev/null; do
        echo -n "."
        sleep 2
    done
    echo -en "\e[32mOK\e[0m"
    sleep 2
}

# -----------------------------------------------------------------------------
# install_software: Installs a given package ($1) using Yay
# -----------------------------------------------------------------------------
function install_software() {
    echo -en "$1"
    yay -S --noconfirm "$1" &>> "$INSTLOG" &
    show_progress $!

    # Check if installed correctly
    if yay -Q "$1" &>> /dev/null; then
        echo -e ""
    else
        # If not installed correctly, print an error message
        echo -e "$1 OH, NO! something went wrong, please read the file: install.log"
        exit 0
    fi
}

# -----------------------------------------------------------------------------
# update: Updates the system package database and upgrades packages
# -----------------------------------------------------------------------------
function update() {
    echo -en "Updating."
    sudo pacman -Syu --noconfirm &>> "$INSTLOG" &
    show_progress $!
    echo -en "\n"
}

# -----------------------------------------------------------------------------
# packagemanager: Installs Yay if it's not already installed
# -----------------------------------------------------------------------------
function packagemanager() {
    if [ ! -f /sbin/yay ]; then
        echo -en "Installing yay."
        git clone https://aur.archlinux.org/yay-git &>> "$INSTLOG"
        cd yay-git || exit 1
        makepkg -si --noconfirm &>> ../"$INSTLOG" &
        show_progress $!
        if [ -f /sbin/yay ]; then
            :
        else
            echo -e "Yay installation failed, please read the file >< install.log"
            exit 0
        fi
        cd ..
    fi
}

# -----------------------------------------------------------------------------
# setup: Installs the list of packages defined in install_packages_yay
# -----------------------------------------------------------------------------
function setup() {
    echo -e "\n"
    echo -en "\e[33m[x] Installing Yay packages...\e[0m\n"

    # Iterate over the packages to be installed
    for SOFTWR in "${install_packages_yay[@]}"; do
        if [ "$SOFTWR" == 'rustup' ]; then
            sudo pacman -R --noconfirm rust > /dev/null 2>&1
            install_software "$SOFTWR"
        else
            install_software "$SOFTWR"
        fi
    done
}

# -----------------------------------------------------------------------------
# copia: Copies dotfiles to the user's home directory, sets up zsh and other configs
# -----------------------------------------------------------------------------
function copia() {
    echo -en "\n"
    echo -en "\e[33m[x] Copying configuration...\e[0m\n"
    echo -en "dots."

    # Create ~/.config directory if it doesn't exist
    mkdir -p "$HOME/.config" > /dev/null 2>&1

    # dunst
    mkdir -p "$HOME/.config/dunst" > /dev/null 2>&1
    cp -r "$1/dots/dunst/"* "$HOME/.config/dunst/"

    # fastfetch
    mkdir -p "$HOME/.config/fastfetch" > /dev/null 2>&1
    cp -r "$1/dots/fastfetch/"* "$HOME/.config/fastfetch/"

    # gtk-3.0
    mkdir -p "$HOME/.config/gtk-3.0" > /dev/null 2>&1
    cp -r "$1/dots/gtk-3.0/"* "$HOME/.config/gtk-3.0/"

    # gtk-4.0
    mkdir -p "$HOME/.config/gtk-4.0" > /dev/null 2>&1
    cp -r "$1/dots/gtk-4.0/"* "$HOME/.config/gtk-4.0/"

    # hypr
    mkdir -p "$HOME/.config/hypr" > /dev/null 2>&1
    cp -r "$1/dots/hypr/"* "$HOME/.config/hypr/"

    # kitty
    mkdir -p "$HOME/.config/kitty" > /dev/null 2>&1
    cp -r "$1/dots/kitty/"* "$HOME/.config/kitty/"

    # rofi
    mkdir -p "$HOME/.config/rofi" > /dev/null 2>&1
    cp -r "$1/dots/rofi/"* "$HOME/.config/rofi/"

    # spicetify
    mkdir -p "$HOME/.config/spicetify/Themes" > /dev/null 2>&1
    cp -r "$1/dots/spicetify/"* "$HOME/.config/spicetify/Themes/"

    # vesktop
    mkdir -p "$HOME/.config/vesktop/themes" > /dev/null 2>&1
    cp -r "$1/dots/vesktop/"* "$HOME/.config/vesktop/themes/"

    # waybar
    mkdir -p "$HOME/.config/waybar" > /dev/null 2>&1
    cp -r "$1/dots/waybar/"* "$HOME/.config/waybar/"

    # Change shell to ZSH for the current user and root
    sudo usermod --shell /usr/bin/zsh "$USER" > /dev/null 2>&1
    sudo usermod --shell /usr/bin/zsh root > /dev/null 2>&1
    cp -r "$1/dots/.zshrc" "$HOME/"
    sudo ln -s -f "$HOME/.zshrc" "/root/.zshrc"

    # Powerlevel10k theme installation
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k > /dev/null 2>&1
    sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/powerlevel10k > /dev/null 2>&1
    cp -r "$1/dots/powerlevel10k/user/.p10k.zsh" "$HOME/"
    sudo cp -r "$1/dots/powerlevel10k/root/.p10k.zsh" "/root/"

    # zsh-sudo plugin
    cd /usr/share || exit 1
    sudo mkdir -p zsh-sudo
    sudo chown "$USER":"$USER" zsh-sudo/
    cd zsh-sudo || exit 1
    sudo cp -r "$1/dots/sudo.plugin.zsh" /usr/share/zsh-sudo/



    # ...existing code...
    # keyd configuration
    read -rp 'Configure keyd? Will change the "ñ" to "-" (y,n)? ' KEYDANS
    if [[ "$KEYDANS" =~ ^[Yy]$ ]]; then
        sudo cp -r "$1/dots/default.conf" /etc/keyd/
    fi
    # ...existing code...

    # spiceify configuration
    spicetify config current_theme catppuccin
    spicetify config color_scheme mocha
    spicetify config inject_css 1 inject_theme_js 1 replace_colors 1 overwrite_assets 1
    spicetify apply


    echo -en "\e[32mOK\e[0m\n"
}

# -----------------------------------------------------------------------------
# finalizacion: Final message after completing the setup
# -----------------------------------------------------------------------------
function finalizacion() {
    echo ""
    echo "Well, all right? Restart and enjoy :)"
    echo ""
}

# -----------------------------------------------------------------------------
# call: Calls all the main functions in order
# -----------------------------------------------------------------------------
function call() {
    local ruta
    ruta="$(pwd)"
    update
    packagemanager
    setup "$ruta"
    copia "$ruta"
    finalizacion
}

# -----------------------------------------------------------------------------
# Main script logic:
# Checks if the script is NOT run as root, then proceeds with installation
# -----------------------------------------------------------------------------
if [ "$(whoami)" != "root" ]; then
    present
    echo -en '\n'
    read -rep 'Install? (y,n)? ' CONTINST

    if [[ "$CONTINST" == "Y" || "$CONTINST" == "y" || "$CONTINST" == "yes" ]]; then
        echo -en "\n"
        echo -en "\e[33m[x] Installing >.<...\e[0m\n"
        sudo touch /tmp/hyprv.tmp
        call
    else
        echo -e "Exiting the script, no changes have been made to your system."
        exit 0
    fi
else
    echo 'Error, the script should not be run as root.'
    exit 0
fi
